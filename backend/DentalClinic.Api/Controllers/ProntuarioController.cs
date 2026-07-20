using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace DentalClinic.Api.Controllers;

/// <summary>
/// Controller principal para operações de prontuário, incluindo Odontograma e Planos de Tratamento.
/// </summary>
[Authorize]
[ApiController]
[Route("api/[controller]")]
public class ProntuarioController : ControllerBase
{
    private readonly IProntuarioRepository _repository;
    private readonly ITreatmentPlanRepository _planRepository;
    private readonly ILogger<ProntuarioController> _logger;

    public ProntuarioController(
        IProntuarioRepository repository,
        ITreatmentPlanRepository planRepository,
        ILogger<ProntuarioController> logger)
    {
        _repository = repository;
        _planRepository = planRepository;
        _logger = logger;
    }

    /// <summary>
    /// Recupera o odontograma de um paciente.
    /// </summary>
    [HttpGet("{patientId}/odontogram")]
    public async Task<IActionResult> GetOdontogram(int patientId)
    {
        var odontogram = await _repository.GetOdontogramByPatientIdAsync(patientId);
        if (odontogram == null) return NotFound();
        return Ok(odontogram);
    }

    /// <summary>
    /// Salva ou atualiza o odontograma.
    /// </summary>
    [HttpPost("{patientId}/odontogram")]
    public async Task<IActionResult> SaveOdontogram(int patientId, [FromBody] Odontogram odontogram)
    {
        if (patientId != odontogram.PatientId) return BadRequest();
        await _repository.SaveOdontogramAsync(odontogram);
        return NoContent();
    }

    /// <summary>
    /// Recupera o histórico de evoluções.
    /// </summary>
    [HttpGet("{patientId}/evolutions")]
    public async Task<IActionResult> GetEvolutions(int patientId)
    {
        var history = await _repository.GetEvolutionHistoryAsync(patientId);
        return Ok(history);
    }

    /// <summary>
    /// Assina uma evolução clínica. Ação exclusiva de Professores.
    /// </summary>
    [HttpPatch("evolutions/{id}/sign")]
    [Authorize(Roles = "Professor,Admin")]
    public async Task<IActionResult> SignEvolution(Guid id)
    {
        var professorId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var evolution = await _repository.GetEvolutionByIdAsync(id);

        if (evolution == null) return NotFound();

        try
        {
            evolution.Sign(Guid.Parse(professorId!));
            await _repository.UpdateEvolutionAsync(evolution);
            return NoContent();
        }
        catch (InvalidOperationException ex)
        {
            return BadRequest(ex.Message);
        }
    }

    /// <summary>
    /// Atualiza o status de um item do plano de tratamento (ex: marcar como concluído).
    /// </summary>
    [HttpPatch("plans/{planId}/items/{itemId}/status")]
    public async Task<IActionResult> UpdateItemStatus(Guid planId, Guid itemId, [FromBody] TreatmentItemStatusRequest request)
    {
        var plan = await _planRepository.GetByIdAsync(planId);
        if (plan == null) return NotFound();

        var item = plan.Items.FirstOrDefault(i => i.Id == itemId);
        if (item == null) return NotFound();

        if (request.Status == "Completed") item.MarkAsCompleted();
        else if (request.Status == "Cancelled") item.Cancel();

        await _planRepository.UpdateAsync(plan);
        return NoContent();
    }
}

public record TreatmentItemStatusRequest(string Status);
