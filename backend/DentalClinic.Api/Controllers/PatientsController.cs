using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace DentalClinic.Api.Controllers;

/// <summary>
/// Controller para gestão de pacientes.
/// </summary>
[Authorize]
[ApiController]
[Route("api/[controller]")]
public class PatientsController : ControllerBase
{
    private readonly IPatientRepository _patientRepository;
    private readonly ILogger<PatientsController> _logger;

    public PatientsController(IPatientRepository patientRepository, ILogger<PatientsController> logger)
    {
        _patientRepository = patientRepository;
        _logger = logger;
    }

    /// <summary>
    /// Lista pacientes com paginação e filtro.
    /// </summary>
    [HttpGet]
    public async Task<IActionResult> Get([FromQuery] int page = 1, [FromQuery] int pageSize = 10, [FromQuery] string? searchTerm = null)
    {
        var patients = await _patientRepository.GetAllAsync(page, pageSize, searchTerm);
        var total = await _patientRepository.CountAsync(searchTerm);

        return Ok(new
        {
            Items = patients,
            Total = total,
            Page = page,
            PageSize = pageSize
        });
    }

    /// <summary>
    /// Busca um paciente pelo ID.
    /// </summary>
    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(int id)
    {
        var patient = await _patientRepository.GetByIdAsync(id);
        if (patient == null) return NotFound();

        return Ok(patient);
    }

    /// <summary>
    /// Cadastra um novo paciente.
    /// </summary>
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] Patient patient)
    {
        await _patientRepository.AddAsync(patient);
        return CreatedAtAction(nameof(GetById), new { id = patient.Id }, patient);
    }

    /// <summary>
    /// Atualiza os dados de um paciente.
    /// </summary>
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(int id, [FromBody] Patient patient)
    {
        if (id != patient.Id) return BadRequest();

        var existing = await _patientRepository.GetByIdAsync(id);
        if (existing == null) return NotFound();

        await _patientRepository.UpdateAsync(patient);
        return NoContent();
    }

    /// <summary>
    /// Anonimiza os dados do paciente conforme a LGPD (Direito ao Esquecimento).
    /// Apenas Administradores podem realizar esta ação.
    /// </summary>
    [HttpPost("{id}/anonymize")]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> Anonymize(int id)
    {
        _logger.LogWarning("Solicitação de anonimização (LGPD) para o paciente {Id}", id);

        var patient = await _patientRepository.GetByIdAsync(id);
        if (patient == null) return NotFound();

        await _patientRepository.AnonymizeAsync(id);

        return NoContent();
    }
}
