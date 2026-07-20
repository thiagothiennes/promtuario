namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Representa uma evolução clínica (anotação de atendimento) no prontuário.
/// </summary>
public sealed class Evolution : Entity
{
    public int PatientId { get; private set; }
    public Patient Patient { get; private set; } = null!;

    public Guid StudentId { get; private set; }
    public User Student { get; private set; } = null!;

    public Guid ProfessorId { get; private set; }
    public User Professor { get; private set; } = null!;

    public Guid ClinicId { get; private set; }
    public Clinic Clinic { get; private set; } = null!;

    public string Description { get; private set; } = string.Empty;
    public bool IsSignedByProfessor { get; private set; }
    public DateTime? SignedAt { get; private set; }

    private Evolution() { }

    public static Evolution Create(
        int patientId,
        Guid studentId,
        Guid professorId,
        Guid clinicId,
        string description)
    {
        if (string.IsNullOrWhiteSpace(description))
            throw new InvalidOperationException("A descrição da evolução não pode ser vazia.");

        return new Evolution
        {
            PatientId = patientId,
            StudentId = studentId,
            ProfessorId = professorId,
            ClinicId = clinicId,
            Description = description,
            IsSignedByProfessor = false
        };
    }

    public void Sign(Guid professorId)
    {
        if (ProfessorId != professorId)
            throw new InvalidOperationException("Apenas o professor responsável pode assinar esta evolução.");

        IsSignedByProfessor = true;
        SignedAt = DateTime.UtcNow;
        UpdatedAt = DateTime.UtcNow;
    }
}
