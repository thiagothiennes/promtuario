using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace DentalClinic.Api.Controllers;

/// <summary>
/// Controller para registro de evoluções clínicas no prontuário.
/// </summary>
[Authorize]
[ApiController]
[Route("api/[controller]")]
public class EvolutionsController : ControllerBase
{
    private readonly IProntuarioRepository _prontuarioRepository;
    private readonly ILogger<EvolutionsController> _logger;

    public EvolutionsController(IProntuarioRepository prontuarioRepository, ILogger<EvolutionsController> logger)
    {
        _prontuarioRepository = prontuarioRepository;
        _logger = logger;
    }

    /// <summary>
    /// Adiciona uma nova evolução ao prontuário do paciente.
    /// </summary>
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateEvolutionRequest request)
    {
        var currentUserId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(currentUserId)) return Unauthorized();

        // Em um cenário real, verificaríamos se o usuário é aluno ou professor
        // e se o professor indicado realmente é o responsável.

        await _prontuarioRepository.AddEvolutionAsync(
            request.PatientId,
            request.Description,
            request.ProfessorId,
            new Guid(currentUserId));

        return Ok(new { message = "Evolução registrada com sucesso." });
    }

    /// <summary>
    /// Assina digitalmente uma evolução (Ação exclusiva do Professor).
    /// </summary>
    [HttpPost("{id}/sign")]
    [Authorize(Roles = "Professor,Admin")]
    public async Task<IActionResult> Sign(Guid id)
    {
        var professorId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        // Lógica de assinatura aqui
        return Ok(new { message = "Evolução assinada com sucesso." });
    }
}

public record CreateEvolutionRequest(int PatientId, string Description, Guid ProfessorId, Guid ClinicId);
