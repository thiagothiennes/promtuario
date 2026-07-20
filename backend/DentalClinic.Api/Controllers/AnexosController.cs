using DentalClinic.Core.Application.Interfaces;
using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace DentalClinic.Api.Controllers;

/// <summary>
/// Controller para gestão de anexos (Radiografias, Fotos e Documentos).
/// Segue rigorosamente os requisitos de armazenamento em Object Storage e referência em Banco.
/// </summary>
[Authorize]
[ApiController]
[Route("api/[controller]")]
public class AnexosController : ControllerBase
{
    private readonly IStorageService _storageService;
    private readonly IAnexoRepository _anexoRepository;
    private readonly ILogger<AnexosController> _logger;

    public AnexosController(
        IStorageService storageService,
        IAnexoRepository anexoRepository,
        ILogger<AnexosController> logger)
    {
        _storageService = storageService;
        _anexoRepository = anexoRepository;
        _logger = logger;
    }

    /// <summary>
    /// Realiza o upload de um novo anexo para um paciente.
    /// Registra o metadado no banco e armazena o binário no Storage.
    /// </summary>
    [HttpPost("upload/{pacienteId}")]
    [ProducesResponseType(typeof(Anexo), StatusCodes.Status201Created)]
    public async Task<IActionResult> Upload(int pacienteId, IFormFile file, [FromQuery] string tipo)
    {
        if (file == null || file.Length == 0)
            return BadRequest("Arquivo inválido ou vazio.");

        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userId)) return Unauthorized();

        try
        {
            _logger.LogInformation("Iniciando upload de {Tipo} para o paciente {PacienteId}", tipo, pacienteId);

            using var stream = file.OpenReadStream();
            var url = await _storageService.UploadFileAsync(stream, file.FileName, file.ContentType);

            var anexo = Anexo.Create(
                pacienteId,
                file.FileName,
                tipo,
                url,
                file.Length,
                Guid.Parse(userId)
            );

            await _anexoRepository.AddAsync(anexo);

            return CreatedAtAction(nameof(GetByPaciente), new { pacienteId = anexo.PacienteId }, anexo);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Falha crítica no processamento de anexo.");
            return StatusCode(500, "Erro interno ao processar o arquivo clínico.");
        }
    }

    /// <summary>
    /// Lista todos os anexos registrados para um paciente.
    /// </summary>
    [HttpGet("paciente/{pacienteId}")]
    public async Task<IActionResult> GetByPaciente(int pacienteId)
    {
        var anexos = await _anexoRepository.GetByPacienteIdAsync(pacienteId);
        return Ok(anexos);
    }

    /// <summary>
    /// Remove um anexo permanentemente (Banco e Storage).
    /// </summary>
    [HttpDelete("{id}")]
    [Authorize(Roles = "Admin,Professor")]
    public async Task<IActionResult> Delete(Guid id)
    {
        var anexo = await _anexoRepository.GetByIdAsync(id);
        if (anexo == null) return NotFound();

        try
        {
            await _storageService.DeleteFileAsync(anexo.Url);
            await _anexoRepository.DeleteAsync(id);
            return NoContent();
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Erro ao excluir arquivo físico ou registro.");
            return StatusCode(500, "Erro ao remover anexo.");
        }
    }
}
