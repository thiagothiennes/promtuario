namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Representa uma notificação do sistema para um usuário específico.
/// </summary>
public sealed class Notification : Entity
{
    public Guid UserId { get; private set; }
    public User User { get; private set; } = null!;

    public string Title { get; private set; } = string.Empty;
    public string Message { get; private set; } = string.Empty;
    public bool IsRead { get; private set; }
    public NotificationType Type { get; private set; }
    public string? RelatedEntityId { get; private set; }

    private Notification() { }

    public static Notification Create(Guid userId, string title, string message, NotificationType type, string? relatedEntityId = null)
    {
        return new Notification
        {
            UserId = userId,
            Title = title,
            Message = message,
            Type = type,
            RelatedEntityId = relatedEntityId,
            IsRead = false
        };
    }

    public void MarkAsRead()
    {
        IsRead = true;
        UpdatedAt = DateTime.UtcNow;
    }
}

public enum NotificationType
{
    AppointmentReminder = 1,
    PendingSignature = 2,
    TreatmentApproved = 3,
    SystemAlert = 4
}
