using DentalClinic.Core.Domain.Entities;

namespace DentalClinic.Core.Domain.Repositories;

/// <summary>
/// Interface para o repositório de prontuários.
/// Gerencia Odontogramas, Evoluções, Prescrições, Atestados e Anamnese.
/// </summary>
public interface IProntuarioRepository
{
    // Odontograma
    Task<Odontogram?> GetOdontogramByPatientIdAsync(int patientId);
    Task SaveOdontogramAsync(Odontogram odontogram);

    // Evoluções
    Task AddEvolutionAsync(int patientId, string description, Guid professorId, Guid studentId);
    Task<IEnumerable<Evolution>> GetEvolutionHistoryAsync(int patientId);
    Task<Evolution?> GetEvolutionByIdAsync(Guid id);
    Task UpdateEvolutionAsync(Evolution evolution);

    // Documentos
    Task<Prescription> CreatePrescriptionAsync(Prescription prescription);
    Task<IEnumerable<Prescription>> GetPrescriptionHistoryAsync(int patientId);
    Task<MedicalCertificate> CreateCertificateAsync(MedicalCertificate certificate);

    // Anamnese
    Task<Anamnese?> GetAnamneseByPatientIdAsync(int patientId);
    Task SaveAnamneseAsync(Anamnese anamnese);
}
