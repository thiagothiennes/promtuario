namespace DentalClinic.Core.Domain.Entities;

public class LogAuditoria
{
    public int Id { get; set; }
    public string Usuario { get; set; } = string.Empty;
    public string Acao { get; set; } = string.Empty;
    public string Tabela { get; set; } = string.Empty;
    public string DadosAntigos { get; set; } = string.Empty;
    public string DadosNovos { get; set; } = string.Empty;
    public DateTime DataHora { get; set; } = DateTime.UtcNow;
    public string IpOrigem { get; set; } = string.Empty;
}