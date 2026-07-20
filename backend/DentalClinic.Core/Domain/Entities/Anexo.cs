namespace DentalClinic.Core.Domain.Entities;

/// <summary>
/// Representa um arquivo anexo (Radiografia, Foto ou Documento) associado a um paciente.
/// Seguindo os requisitos, o arquivo físico fica no Storage e apenas a referência no Banco.
/// </summary>
public sealed class Anexo : Entity
{
    public int PacienteId { get; private set; }
    public Patient Paciente { get; private set; } = null!;

    public string Nome { get; private set; } = string.Empty;
    public string Tipo { get; private set; } = string.Empty; // 'Radiografia', 'Foto', 'Documento'
    public string Url { get; private set; } = string.Empty;
    public long Tamanho { get; private set; }

    public Guid CriadoPorId { get; private set; }
    public User CriadoPor { get; private set; } = null!;

    private Anexo() { }

    public static Anexo Create(int pacienteId, string nome, string tipo, string url, long tamanho, Guid criadoPorId)
    {
        return new Anexo
        {
            PacienteId = pacienteId,
            Nome = nome,
            Tipo = tipo,
            Url = url,
            Tamanho = tamanho,
            CriadoPorId = criadoPorId
        };
    }
}
