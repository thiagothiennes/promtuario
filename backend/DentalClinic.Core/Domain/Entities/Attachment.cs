using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DentalClinic.Core.Domain.Entities
{
    public class Attachment
    {
        [Key]
        public int Id { get; set; }

        public int PatientId { get; set; }

        [ForeignKey("PatientId")]
        public Patient? Patient { get; set; }

        public int? MedicalRecordId { get; set; }

        [ForeignKey("MedicalRecordId")]
        public MedicalRecord? MedicalRecord { get; set; }

        [Required]
        [MaxLength(255)]
        public string FileName { get; set; } = string.Empty;

        [Required]
        [MaxLength(50)]
        public string FileType { get; set; } = string.Empty;

        [Required]
        [MaxLength(500)]
        public string Url { get; set; } = string.Empty;

        [MaxLength(500)]
        public string? Description { get; set; }

        public DateTime UploadDate { get; set; } = DateTime.UtcNow;

        public int? UploadedByUserId { get; set; }
    }
}