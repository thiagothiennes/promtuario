using DentalClinic.Core.Domain.Entities; // Ajuste este namespace se sua entidade estiver em outro lugar dentro do Core
using System.Linq.Expressions;

namespace DentalClinic.Core.Domain.Repositories
{
    public interface ILogAuditoriaRepository
    {
        Task<LogAuditoria> CreateAsync(LogAuditoria log);
        Task<IEnumerable<LogAuditoria>> GetAllAsync();
        Task<IEnumerable<LogAuditoria>> FindAsync(Expression<Func<LogAuditoria, bool>> predicate);
        Task<LogAuditoria?> GetByIdAsync(int id);
        Task<int> SaveChangesAsync();
    }
}