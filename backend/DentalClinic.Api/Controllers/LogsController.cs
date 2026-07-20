using DentalClinic.Core.Domain.Repositories;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace DentalClinic.Api.Controllers;

/// <summary>
/// Controller para visualização de logs de auditoria e conformidade LGPD.
/// Acesso restrito a Administradores.
/// </summary>
[Authorize(Roles = "Admin")]
[ApiController]
[Route("api/[controller]")]
public class LogsController : ControllerBase
{
    private readonly ILogAuditoriaRepository _repository;
    private readonly ILogger<LogsController> _logger;

    public LogsController(ILogAuditoriaRepository repository, ILogger<LogsController> logger)
    {
        _repository = repository;
        _logger = logger;
    }

    /// <summary>
    /// Lista os logs de auditoria de forma paginada.
    /// </summary>
    [HttpGet]
    public async Task<IActionResult> Get([FromQuery] int page = 1, [FromQuery] int pageSize = 50, [FromQuery] string? userId = null)
    {
        try
        {
            var logs = await _repository.FindAsync(x => userId == null || x.Usuario == userId);
            var total = logs.Count();

            return Ok(new
            {
                Items = logs,
                Total = total,
                Page = page,
                PageSize = pageSize
            });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Erro ao recuperar logs de auditoria.");
            return StatusCode(500, "Erro interno ao processar logs.");
        }
    }
}
