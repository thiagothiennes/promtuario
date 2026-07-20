namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Representa uma sessão ativa de um usuário para controle de Refresh Token.
/// </summary>
public sealed class UserSession : Entity
{
    public Guid UserId { get; private set; }
    public string Token { get; private set; } = string.Empty;
    public DateTime ExpiryDate { get; private set; }
    public bool IsRevoked { get; private set; }
    public string CreatedByIp { get; private set; } = string.Empty;

    private UserSession() { }

    public static UserSession Create(Guid userId, string token, int daysExpiry, string ipAddress)
    {
        return new UserSession
        {
            UserId = userId,
            Token = token,
            ExpiryDate = DateTime.UtcNow.AddDays(daysExpiry),
            CreatedByIp = ipAddress,
            IsRevoked = false
        };
    }

    public void Revoke()
    {
        IsRevoked = true;
        UpdatedAt = DateTime.UtcNow;
    }

    public bool IsActive => !IsRevoked && DateTime.UtcNow < ExpiryDate;
}
