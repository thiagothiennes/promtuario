using DentalClinic.Core.Domain.Entities;

namespace DentalClinic.Core.Domain.Repositories;

/// <summary>
/// Interface para persistência de referências a arquivos anexos (Radiografias, Fotos).
/// </summary>
public interface IAnexoRepository
{
    Task<Anexo?> GetByIdAsync(Guid id);
    Task<IEnumerable<Anexo>> GetByPacienteIdAsync(int pacienteId);
    Task AddAsync(Anexo anexo);
    Task DeleteAsync(Guid id);
}
