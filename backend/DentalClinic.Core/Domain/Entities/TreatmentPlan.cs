namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Representa o Plano de Tratamento proposto para um paciente.
/// Contém uma lista de procedimentos a serem realizados.
/// </summary>
public sealed class TreatmentPlan : Entity
{
    public int PatientId { get; private set; }
    public Patient Patient { get; private set; } = null!;

    public string Description { get; private set; } = string.Empty;

    public List<TreatmentItem> Items { get; private set; } = new();

    public Guid CreatedByUserId { get; private set; }
    public User CreatedBy { get; private set; } = null!;

    public TreatmentPlanStatus Status { get; private set; }

    private TreatmentPlan() { }

    public static TreatmentPlan Create(int patientId, Guid createdByUserId, string description)
    {
        return new TreatmentPlan
        {
            PatientId = patientId,
            CreatedByUserId = createdByUserId,
            Description = description,
            Status = TreatmentPlanStatus.Draft
        };
    }

    public void AddItem(Guid procedureId, string procedureName, decimal value, int? toothNumber)
    {
        Items.Add(TreatmentItem.Create(Id, procedureId, procedureName, value, toothNumber));
        UpdatedAt = DateTime.UtcNow;
    }

    public void Approve()
    {
        Status = TreatmentPlanStatus.Approved;
        UpdatedAt = DateTime.UtcNow;
    }

    public void Complete()
    {
        Status = TreatmentPlanStatus.Completed;
        UpdatedAt = DateTime.UtcNow;
    }
}

public enum TreatmentPlanStatus
{
    Draft = 1,
    Approved = 2,
    InProgress = 3,
    Completed = 4,
    Cancelled = 5
}
