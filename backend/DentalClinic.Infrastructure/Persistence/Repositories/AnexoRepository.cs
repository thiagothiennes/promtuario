using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace DentalClinic.Infrastructure.Persistence.Repositories;

/// <summary>
/// Implementação do repositório de anexos utilizando Entity Framework Core.
/// </summary>
public class AnexoRepository : IAnexoRepository
{
    private readonly ApplicationDbContext _context;

    public AnexoRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Anexo?> GetByIdAsync(Guid id)
    {
        return await _context.Anexos
            .Include(a => a.CriadoPor)
            .FirstOrDefaultAsync(a => a.Id == id);
    }

    public async Task<IEnumerable<Anexo>> GetByPacienteIdAsync(int pacienteId)
    {
        return await _context.Anexos
            .Where(a => a.PacienteId == pacienteId)
            .OrderByDescending(a => a.CreatedAt)
            .ToListAsync();
    }

    public async Task AddAsync(Anexo anexo)
    {
        await _context.Anexos.AddAsync(anexo);
        await _context.SaveChangesAsync();
    }

    public async Task DeleteAsync(Guid id)
    {
        var anexo = await _context.Anexos.FindAsync(id);
        if (anexo != null)
        {
            _context.Anexos.Remove(anexo);
            await _context.SaveChangesAsync();
        }
    }
}
