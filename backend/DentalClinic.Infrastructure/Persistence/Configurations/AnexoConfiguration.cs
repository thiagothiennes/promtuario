using DentalClinic.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace DentalClinic.Infrastructure.Persistence.Configurations;

public class AnexoConfiguration : IEntityTypeConfiguration<Anexo>
{
    public void Configure(EntityTypeBuilder<Anexo> builder)
    {
        builder.ToTable("anexos");

        builder.HasKey(a => a.Id);

        builder.Property(a => a.Nome)
            .IsRequired()
            .HasMaxLength(255);

        builder.Property(a => a.Tipo)
            .IsRequired()
            .HasMaxLength(50);

        builder.Property(a => a.Url)
            .IsRequired()
            .HasMaxLength(500);

        builder.Property(a => a.Tamanho)
            .IsRequired();

        // Configura o relacionamento com Patient (chave estrangeira int)
        builder.HasOne(a => a.Paciente)
            .WithMany(p => p.Anexos)
            .HasForeignKey(a => a.PacienteId)
            .OnDelete(DeleteBehavior.Restrict);

        // Configura o relacionamento com User (quem criou)
        builder.HasOne(a => a.CriadoPor)
            .WithMany()
            .HasForeignKey(a => a.CriadoPorId)
            .OnDelete(DeleteBehavior.Restrict);

        // Índices para otimização
        builder.HasIndex(a => a.PacienteId);
        builder.HasIndex(a => a.CriadoPorId);
    }
}
