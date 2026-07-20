using DentalClinic.Core.Domain.ValueObjects;

namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Entidade que representa uma clínica (especialidade) no sistema.
/// </summary>
public sealed class Clinic : Entity
{
    /// <summary>
    /// Nome da clínica/especialidade.
    /// </summary>
    public string Name { get; private set; } = string.Empty;

    /// <summary>
    /// Descrição detalhada da clínica.
    /// </summary>
    public string Description { get; private set; } = string.Empty;

    /// <summary>
    /// Especialidade dentária da clínica.
    /// </summary>
    public Specialty Specialty { get; private set; }

    /// <summary>
    /// Endereço da clínica (Value Object).
    /// </summary>
    public Address Address { get; private set; } = null!;

    /// <summary>
    /// Capacidade máxima de pacientes simultâneos.
    /// </summary>
    public int MaxCapacity { get; private set; }

    /// <summary>
    /// ID do professor coordenador da clínica.
    /// </summary>
    public Guid CoordinatorUserId { get; private set; }

    /// <summary>
    /// Status da clínica.
    /// </summary>
    public bool IsActive { get; private set; }

    /// <summary>
    /// Horário de abertura (formato HH:mm).
    /// </summary>
    public string OpeningTime { get; private set; } = string.Empty;

    /// <summary>
    /// Horário de fechamento (formato HH:mm).
    /// </summary>
    public string ClosingTime { get; private set; } = string.Empty;

    private Clinic()
    {
        Name = string.Empty;
        Description = string.Empty;
        OpeningTime = string.Empty;
        ClosingTime = string.Empty;
        Address = Address.Create(".", ".", null, ".", ".", "SP", "00000-000");
    }

    /// <summary>
    /// Cria uma nova clínica com validações.
    /// </summary>
    /// <param name="name">Nome da clínica.</param>
    /// <param name="description">Descrição da clínica.</param>
    /// <param name="specialty">Especialidade dentária.</param>
    /// <param name="address">Endereço (Value Object).</param>
    /// <param name="maxCapacity">Capacidade máxima.</param>
    /// <param name="coordinatorUserId">ID do professor coordenador.</param>
    /// <param name="openingTime">Horário de abertura (HH:mm).</param>
    /// <param name="closingTime">Horário de fechamento (HH:mm).</param>
    /// <returns>Uma nova clínica.</returns>
    public static Clinic Create(
        string name,
        string description,
        Specialty specialty,
        Address address,
        int maxCapacity,
        Guid coordinatorUserId,
        string openingTime,
        string closingTime)
    {
        ValidateName(name);
        ValidateDescription(description);
        ValidateCapacity(maxCapacity);
        ValidateTime(openingTime);
        ValidateTime(closingTime);
        ValidateOpeningClosingTimes(openingTime, closingTime);

        if (coordinatorUserId == Guid.Empty)
            throw new InvalidOperationException("ID do coordenador não pode ser vazio.");

        var clinic = new Clinic
        {
            Name = name.Trim(),
            Description = description.Trim(),
            Specialty = specialty,
            Address = address,
            MaxCapacity = maxCapacity,
            CoordinatorUserId = coordinatorUserId,
            OpeningTime = openingTime,
            ClosingTime = closingTime,
            IsActive = true
        };

        return clinic;
    }

    /// <summary>
    /// Desativa a clínica.
    /// </summary>
    public void Deactivate()
    {
        IsActive = false;
        UpdatedAt = DateTime.UtcNow;
    }

    /// <summary>
    /// Ativa a clínica.
    /// </summary>
    public void Activate()
    {
        IsActive = true;
        UpdatedAt = DateTime.UtcNow;
    }

    /// <summary>
    /// Atualiza os horários de funcionamento.
    /// </summary>
    /// <param name="openingTime">Novo horário de abertura (HH:mm).</param>
    /// <param name="closingTime">Novo horário de fechamento (HH:mm).</param>
    public void UpdateOperatingHours(string openingTime, string closingTime)
    {
        ValidateTime(openingTime);
        ValidateTime(closingTime);
        ValidateOpeningClosingTimes(openingTime, closingTime);

        OpeningTime = openingTime;
        ClosingTime = closingTime;
        UpdatedAt = DateTime.UtcNow;
    }

    private static void ValidateName(string name)
    {
        if (string.IsNullOrWhiteSpace(name))
            throw new InvalidOperationException("Nome da clínica não pode ser vazio.");

        if (name.Length < 3)
            throw new InvalidOperationException("Nome deve ter no mínimo 3 caracteres.");

        if (name.Length > 255)
            throw new InvalidOperationException("Nome não pode ter mais de 255 caracteres.");
    }

    private static void ValidateDescription(string description)
    {
        if (string.IsNullOrWhiteSpace(description))
            throw new InvalidOperationException("Descrição não pode ser vazia.");

        if (description.Length < 10)
            throw new InvalidOperationException("Descrição deve ter no mínimo 10 caracteres.");

        if (description.Length > 1000)
            throw new InvalidOperationException("Descrição não pode ter mais de 1000 caracteres.");
    }

    private static void ValidateCapacity(int maxCapacity)
    {
        if (maxCapacity < 1)
            throw new InvalidOperationException("Capacidade máxima deve ser no mínimo 1.");

        if (maxCapacity > 1000)
            throw new InvalidOperationException("Capacidade máxima não pode exceder 1000.");
    }

    private static void ValidateTime(string time)
    {
        if (string.IsNullOrWhiteSpace(time))
            throw new InvalidOperationException("Horário não pode ser vazio.");

        if (!System.Text.RegularExpressions.Regex.IsMatch(time, @"^([01]?[0-9]|2[0-3]):[0-5][0-9]$"))
            throw new InvalidOperationException("Horário deve estar no formato HH:mm.");
    }

    private static void ValidateOpeningClosingTimes(string openingTime, string closingTime)
    {
        var opening = TimeOnly.Parse(openingTime);
        var closing = TimeOnly.Parse(closingTime);

        if (opening >= closing)
            throw new InvalidOperationException("Horário de abertura deve ser antes do horário de fechamento.");
    }
}
