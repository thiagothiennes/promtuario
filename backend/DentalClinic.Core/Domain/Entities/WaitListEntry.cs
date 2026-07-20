namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Representa uma entrada na lista de espera de uma clínica específica.
/// </summary>
public sealed class WaitListEntry : Entity
{
    public int PatientId { get; private set; }
    public Patient Patient { get; private set; } = null!;

    public Guid ClinicId { get; private set; }
    public Clinic Clinic { get; private set; } = null!;

    public Specialty? Specialty { get; private set; }
    public string Priority { get; private set; } = string.Empty; // 'Normal', 'Urgente', 'Prioritário'
    public string? Observation { get; private set; }
    public bool IsResolved { get; private set; }

    private WaitListEntry() { }

    public static WaitListEntry Create(int patientId, Guid clinicId, Specialty specialty, string priority, string? observation)
    {
        return new WaitListEntry
        {
            PatientId = patientId,
            ClinicId = clinicId,
            Specialty = specialty,
            Priority = priority,
            Observation = observation,
            IsResolved = false
        };
    }

    public void Resolve()
    {
        IsResolved = true;
        UpdatedAt = DateTime.UtcNow;
    }
}
