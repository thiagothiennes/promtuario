using DentalClinic.Core.Domain.Entities;

namespace DentalClinic.Core.Domain.Repositories;

/// <summary>
/// Interface para persistência de pacientes.
/// </summary>
public interface IPatientRepository
{
    Task<Patient?> GetByIdAsync(int id);
    Task<IEnumerable<Patient>> GetAllAsync(int page, int pageSize, string? searchTerm);
    Task AddAsync(Patient patient);
    Task UpdateAsync(Patient patient);
    Task<int> CountAsync(string? searchTerm);

    /// <summary>
    /// Anonimiza os dados pessoais do paciente conforme a LGPD.
    /// </summary>
    Task AnonymizeAsync(int id);
}
