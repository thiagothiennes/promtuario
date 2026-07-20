using DentalClinic.Core.Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace DentalClinic.Infrastructure.Persistence.Configurations;

public class UserConfiguration : IEntityTypeConfiguration<User>
{
    public void Configure(EntityTypeBuilder<User> builder)
    {
        builder.ToTable("usuarios");

        builder.HasKey(u => u.Id);

        builder.Property(u => u.Name)
            .IsRequired()
            .HasMaxLength(255);

        // Configuração do Email como Owned Type
        builder.OwnsOne(u => u.EmailAddress, emailBuilder =>
        {
            emailBuilder.Property(e => e.Value)
                .HasColumnName("email")
                .IsRequired()
                .HasMaxLength(255);

            emailBuilder.HasIndex(e => e.Value).IsUnique();
        });

        builder.Property(u => u.PasswordHash)
            .IsRequired();

        // Configuração do CPF como Owned Type
        builder.OwnsOne(u => u.CPF, cpfBuilder =>
        {
            cpfBuilder.Property(c => c.Value)
                .HasColumnName("cpf")
                .IsRequired()
                .HasMaxLength(11);

            cpfBuilder.HasIndex(c => c.Value).IsUnique();
        });

        builder.Property(u => u.Phone)
            .HasMaxLength(20);

        // Configuração do Endereço como Owned Type
        builder.OwnsOne(u => u.Address, addressBuilder =>
        {
            addressBuilder.Property(a => a.Street).HasColumnName("endereco_rua").HasMaxLength(255);
            addressBuilder.Property(a => a.Number).HasColumnName("endereco_numero").HasMaxLength(20);
            addressBuilder.Property(a => a.Neighborhood).HasColumnName("endereco_bairro").HasMaxLength(100);
            addressBuilder.Property(a => a.City).HasColumnName("endereco_cidade").HasMaxLength(100);
            addressBuilder.Property(a => a.State).HasColumnName("endereco_estado").HasMaxLength(2);
            addressBuilder.Property(a => a.ZipCode).HasColumnName("endereco_cep").HasMaxLength(10);
        });

        // Configuração de Roles como JSONB (PostgreSQL)
        builder.Property(u => u.Roles)
            .HasColumnType("jsonb");

        builder.Property(u => u.Status)
            .HasConversion<int>();
    }
}
