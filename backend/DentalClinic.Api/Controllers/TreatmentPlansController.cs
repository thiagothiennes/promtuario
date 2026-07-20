using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace DentalClinic.Api.Controllers;

/// <summary>
/// Controller para gestão dos Planos de Tratamento dos pacientes.
/// </summary>
[Authorize]
[ApiController]
[Route("api/[controller]")]
public class TreatmentPlansController : ControllerBase
{
    private readonly ITreatmentPlanRepository _repository;
    private readonly ILogger<TreatmentPlansController> _logger;

    public TreatmentPlansController(ITreatmentPlanRepository repository, ILogger<TreatmentPlansController> logger)
    {
        _repository = repository;
        _logger = logger;
    }

    /// <summary>
    /// Obtém o plano de tratamento ativo de um paciente.
    /// </summary>
    [HttpGet("active/{patientId}")]
    public async Task<IActionResult> GetActive(int patientId)
    {
        var plan = await _repository.GetActivePlanByPatientIdAsync(patientId);
        if (plan == null) return NotFound();
        return Ok(plan);
    }

    /// <summary>
    /// Cria um novo plano de tratamento (Rascunho).
    /// </summary>
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateTreatmentPlanRequest request)
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        if (string.IsNullOrEmpty(userId)) return Unauthorized();

        var plan = TreatmentPlan.Create(request.PatientId, new Guid(userId), request.Description);
        await _repository.AddAsync(plan);

        return CreatedAtAction(nameof(GetActive), new { patientId = plan.PatientId }, plan);
    }

    /// <summary>
    /// Adiciona um item ao plano de tratamento.
    /// </summary>
    [HttpPost("{id}/items")]
    public async Task<IActionResult> AddItem(Guid id, [FromBody] AddTreatmentItemRequest request)
    {
        var plan = await _repository.GetByIdAsync(id);
        if (plan == null) return NotFound();

        plan.AddItem(request.ProcedureId, request.ProcedureName, request.Value, request.ToothNumber);
        await _repository.UpdateAsync(plan);

        return Ok(plan);
    }

    /// <summary>
    /// Aprova o plano de tratamento (Ação do Professor/Responsável).
    /// </summary>
    [HttpPatch("{id}/approve")]
    [Authorize(Roles = "Professor,Admin,Coordinator")]
    public async Task<IActionResult> Approve(Guid id)
    {
        var plan = await _repository.GetByIdAsync(id);
        if (plan == null) return NotFound();

        plan.Approve();
        await _repository.UpdateAsync(plan);

        return NoContent();
    }
}

public record CreateTreatmentPlanRequest(int PatientId, string Description);
public record AddTreatmentItemRequest(Guid ProcedureId, string ProcedureName, decimal Value, int? ToothNumber);
