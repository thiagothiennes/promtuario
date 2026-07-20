using DentalClinic.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace DentalClinic.Infrastructure.Persistence.Configurations;

public class PatientConfiguration : IEntityTypeConfiguration<Patient>
{
    public void Configure(EntityTypeBuilder<Patient> builder)
    {
        builder.ToTable("pacientes");

        builder.HasKey(p => p.Id);

        builder.Property(p => p.Name)
            .IsRequired()
            .HasMaxLength(150);

        builder.Property(p => p.CPF)
            .HasColumnName("cpf")
            .IsRequired()
            .HasMaxLength(14);

        builder.HasIndex(p => p.CPF).IsUnique();

        builder.Property(p => p.Email)
            .IsRequired()
            .HasMaxLength(100)
            .HasColumnName("email");

        builder.Property(p => p.Phone)
            .IsRequired()
            .HasMaxLength(20);

        builder.Property(p => p.DateOfBirth)
            .IsRequired();

        builder.Property(p => p.Address)
            .HasMaxLength(200);

        builder.Property(p => p.Neighborhood)
            .HasMaxLength(100);

        builder.Property(p => p.City)
            .HasMaxLength(100);

        builder.Property(p => p.State)
            .HasMaxLength(2);

        builder.Property(p => p.ZipCode)
            .HasMaxLength(9);

        // Auditoria LGPD: Índice para buscas frequentes por nome
        builder.HasIndex(p => p.Name);
    }
}
