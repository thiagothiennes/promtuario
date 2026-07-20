using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DentalClinic.Core.Domain.Entities
{
    public class Patient
    {
        [Key]
        public int Id { get; set; }

        [Required]
        [MaxLength(150)]
        public string Name { get; set; } = string.Empty;

        [Required]
        [MaxLength(14)]
        public string CPF { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? RG { get; set; }

        [Required]
        [EmailAddress]
        [MaxLength(100)]
        public string Email { get; set; } = string.Empty;

        [Required]
        [MaxLength(20)]
        public string Phone { get; set; } = string.Empty;

        [MaxLength(20)]
        public string? AlternatePhone { get; set; }

        [MaxLength(50)]
        public string? Gender { get; set; }

        public DateTime DateOfBirth { get; set; }

        [MaxLength(200)]
        public string? Address { get; set; }

        [MaxLength(100)]
        public string? Neighborhood { get; set; }

        [MaxLength(100)]
        public string? City { get; set; }

        [MaxLength(2)]
        public string? State { get; set; }

        [MaxLength(9)]
        public string? ZipCode { get; set; }

        [MaxLength(200)]
        public string? ResponsibleName { get; set; }

        [MaxLength(20)]
        public string? ResponsiblePhone { get; set; }

        [MaxLength(500)]
        public string? MedicalHistory { get; set; }

        [MaxLength(500)]
        public string? Allergies { get; set; }

        [MaxLength(500)]
        public string? Medications { get; set; }

        public bool IsActive { get; set; } = true;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;

        public DateTime? UpdatedAt { get; set; }

        // Relacionamentos
        public ICollection<Appointment>? Appointments { get; set; }
        public ICollection<MedicalRecord>? MedicalRecords { get; set; }
        public ICollection<Attachment>? Attachments { get; set; }
        public ICollection<Anexo>? Anexos { get; set; }

        // Método auxiliar para idade
        public int GetAge()
        {
            var today = DateTime.Today;
            var age = today.Year - DateOfBirth.Year;
            if (DateOfBirth.Date > today.AddYears(-age)) age--;
            return age;
        }
    }
}