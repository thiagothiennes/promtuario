namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Representa o estado clínico da arcada dentária de um paciente.
/// </summary>
public sealed class Odontogram : Entity
{
    public int PatientId { get; private set; }
    public Patient Patient { get; private set; } = null!;

    public List<ToothCondition> Teeth { get; private set; } = new();

    public Guid UpdatedBy { get; private set; }

    private Odontogram() { }

    public static Odontogram Create(int patientId, Guid userId)
    {
        return new Odontogram
        {
            PatientId = patientId,
            UpdatedBy = userId,
            Teeth = new List<ToothCondition>()
        };
    }

    public void UpdateTooth(int toothNumber, ConditionType condition, List<ToothSurface> surfaces, string? observation, Guid userId)
    {
        var existing = Teeth.FirstOrDefault(t => t.ToothNumber == toothNumber);
        if (existing != null)
        {
            Teeth.Remove(existing);
        }

        Teeth.Add(new ToothCondition(toothNumber, surfaces, condition, observation));
        UpdatedBy = userId;
        UpdatedAt = DateTime.UtcNow;
    }
}

public record ToothCondition(int ToothNumber, List<ToothSurface> Surfaces, ConditionType Condition, string? Observation);

public enum ToothSurface
{
    Mesial, Distal, Occlusal, Buccal, Lingual, Palatal, Root
}

public enum ConditionType
{
    Healthy, Decayed, Restored, Missing, Implant, Endodontic, Prosthesis
}
