using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace DentalClinic.Infrastructure.Persistence.Repositories;

/// <summary>
/// Implementação do repositório de usuários utilizando Entity Framework Core.
/// </summary>
public class UserRepository : IUserRepository
{
    private readonly ApplicationDbContext _context;

    public UserRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<User?> GetByEmailAsync(string email)
    {
        // Ajustado para acessar a propriedade Value do Value Object Email
        return await _context.Users
            .FirstOrDefaultAsync(u => u.EmailAddress.Value == email.ToLower());
    }

    public async Task<User?> GetByIdAsync(Guid id)
    {
        return await _context.Users.FindAsync(id);
    }

    public async Task<IEnumerable<User>> GetAllAsync(UserRole? role = null, string? search = null)
    {
        var query = _context.Users.AsQueryable();

        if (role.HasValue)
        {
            // Ajustado para verificar se a lista de Roles contém o papel solicitado
            query = query.Where(u => u.Roles.Contains(role.Value));
        }

        if (!string.IsNullOrWhiteSpace(search))
        {
            search = search.ToLower();
            query = query.Where(u =>
                u.Name.ToLower().Contains(search) ||
                u.EmailAddress.Value.ToLower().Contains(search));
        }

        return await query
            .OrderBy(u => u.Name)
            .ToListAsync();
    }

    public async Task AddAsync(User user)
    {
        await _context.Users.AddAsync(user);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateAsync(User user)
    {
        _context.Users.Update(user);
        await _context.SaveChangesAsync();
    }
}
