using System.Text.Json;

namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Representa a ficha de anamnese do paciente.
/// Contém o histórico de saúde e questionários.
/// </summary>
public sealed class Anamnese : Entity
{
    public int PatientId { get; private set; }
    public Patient Patient { get; private set; } = null!;

    /// <summary>
    /// Respostas do questionário armazenadas em formato JSON para flexibilidade.
    /// Permite que a universidade altere as perguntas sem mudar o esquema do banco.
    /// </summary>
    public string RespostasJson { get; private set; } = "{}";

    public Guid CriadoPorId { get; private set; }
    public User CriadoPor { get; private set; } = null!;

    private Anamnese() { }

    public static Anamnese Create(int patientId, string respostasJson, Guid criadoPorId)
    {
        return new Anamnese
        {
            PatientId = patientId,
            RespostasJson = respostasJson,
            CriadoPorId = criadoPorId
        };
    }

    public void Update(string respostasJson)
    {
        RespostasJson = respostasJson;
        UpdatedAt = DateTime.UtcNow;
    }
}
