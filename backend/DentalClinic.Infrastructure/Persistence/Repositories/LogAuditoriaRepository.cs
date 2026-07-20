using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace DentalClinic.Infrastructure.Persistence.Repositories;

/// <summary>
/// Implementação do repositório de auditoria para conformidade com a LGPD.
/// </summary>
public class LogAuditoriaRepository : ILogAuditoriaRepository
{
    private readonly ApplicationDbContext _context;

    public LogAuditoriaRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<LogAuditoria> CreateAsync(LogAuditoria log)
    {
        await _context.Set<LogAuditoria>().AddAsync(log);
        return log;
    }

    public async Task<IEnumerable<LogAuditoria>> GetAllAsync()
    {
        return await _context.Set<LogAuditoria>()
            .OrderByDescending(l => l.DataHora)
            .ToListAsync();
    }

    public async Task<IEnumerable<LogAuditoria>> FindAsync(Expression<Func<LogAuditoria, bool>> predicate)
    {
        return await _context.Set<LogAuditoria>()
            .Where(predicate)
            .OrderByDescending(l => l.DataHora)
            .ToListAsync();
    }

    public async Task<LogAuditoria?> GetByIdAsync(int id)
    {
        return await _context.Set<LogAuditoria>()
            .FirstOrDefaultAsync(l => l.Id == id);
    }

    public async Task<int> SaveChangesAsync()
    {
        return await _context.SaveChangesAsync();
    }
}
