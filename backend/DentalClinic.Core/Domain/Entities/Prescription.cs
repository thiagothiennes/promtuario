namespace DentalClinic.Core.Domain.Entities;

public sealed class Prescription : Entity
{
    public int PatientId { get; private set; }
    public Patient Patient { get; private set; } = null!;

    public Guid DoctorId { get; private set; }
    public User Doctor { get; private set; } = null!;

    public string? Observations { get; private set; }
    public List<PrescriptionItem> Items { get; private set; } = new();

    public Guid ClinicId { get; private set; }

    private Prescription() { }

    public static Prescription Create(int patientId, Guid doctorId, Guid clinicId, string? observations)
    {
        return new Prescription
        {
            PatientId = patientId,
            DoctorId = doctorId,
            ClinicId = clinicId,
            Observations = observations
        };
    }

    public void AddItem(string medicine, string dosage, string instructions)
    {
        Items.Add(new PrescriptionItem(medicine, dosage, instructions));
    }
}

public record PrescriptionItem(string MedicineName, string Dosage, string Instructions);
