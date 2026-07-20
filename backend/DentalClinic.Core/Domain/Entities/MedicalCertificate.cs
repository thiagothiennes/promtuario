namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Representa um atestado médico ou odontológico emitido pelo sistema.
/// </summary>
public sealed class MedicalCertificate : Entity
{
    public int PatientId { get; private set; }
    public Patient Patient { get; private set; } = null!;

    public Guid DoctorId { get; private set; }
    public User Doctor { get; private set; } = null!;

    public string Content { get; private set; } = string.Empty;
    public int DaysOfRest { get; private set; }
    public string CID { get; private set; } = string.Empty;
    public Guid ClinicId { get; private set; }

    private MedicalCertificate() { }

    public static MedicalCertificate Create(
        int patientId,
        Guid doctorId,
        Guid clinicId,
        string content,
        int daysOfRest,
        string cid)
    {
        if (string.IsNullOrWhiteSpace(content))
            throw new InvalidOperationException("O conteúdo do atestado não pode ser vazio.");

        return new MedicalCertificate
        {
            PatientId = patientId,
            DoctorId = doctorId,
            ClinicId = clinicId,
            Content = content,
            DaysOfRest = daysOfRest,
            CID = cid
        };
    }
}
