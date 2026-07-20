namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Representa um procedimento disponível no catálogo da universidade.
/// </summary>
public sealed class Procedure : Entity
{
    public string Name { get; private set; } = string.Empty;
    public string Code { get; private set; } = string.Empty; // TUSS ou Código Interno
    public decimal BaseValue { get; private set; }
    public Specialty? Specialty { get; private set; }
    public int EstimatedTimeMinutes { get; private set; }

    private Procedure() { }

    public static Procedure Create(string name, string code, decimal baseValue, Specialty specialty, int estimatedTime)
    {
        return new Procedure
        {
            Name = name,
            Code = code,
            BaseValue = baseValue,
            Specialty = specialty,
            EstimatedTimeMinutes = estimatedTime
        };
    }
}
