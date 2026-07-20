using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace DentalClinic.Api.Controllers;

/// <summary>
/// Controller para gestão da lista de espera por clínica e especialidade.
/// </summary>
[Authorize]
[ApiController]
[Route("api/[controller]")]
public class WaitListController : ControllerBase
{
    private readonly IWaitListRepository _repository;
    private readonly ILogger<WaitListController> _logger;

    public WaitListController(IWaitListRepository repository, ILogger<WaitListController> logger)
    {
        _repository = repository;
        _logger = logger;
    }

    /// <summary>
    /// Lista pacientes na fila de espera de uma clínica específica.
    /// </summary>
    [HttpGet("clinic/{clinicId}")]
    public async Task<IActionResult> GetByClinic(Guid clinicId)
    {
        var entries = await _repository.GetActiveByClinicAsync(clinicId);
        return Ok(entries);
    }

    /// <summary>
    /// Adiciona um paciente à lista de espera.
    /// </summary>
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateWaitListRequest request)
    {
        var entry = WaitListEntry.Create(
            request.PatientId,
            request.ClinicId,
            request.Specialty,
            request.Priority,
            request.Observation);

        await _repository.AddAsync(entry);
        return CreatedAtAction(nameof(GetByClinic), new { clinicId = entry.ClinicId }, entry);
    }

    /// <summary>
    /// Resolve uma entrada na lista de espera (quando o paciente é agendado).
    /// </summary>
    [HttpPatch("{id}/resolve")]
    public async Task<IActionResult> Resolve(Guid id)
    {
        var entry = await _repository.GetByIdAsync(id);
        if (entry == null) return NotFound();

        entry.Resolve();
        await _repository.UpdateAsync(entry);
        return NoContent();
    }
}

public record CreateWaitListRequest(int PatientId, Guid ClinicId, Specialty Specialty, string Priority, string? Observation);
