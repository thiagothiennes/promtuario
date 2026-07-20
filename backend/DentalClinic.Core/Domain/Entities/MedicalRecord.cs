using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace DentalClinic.Core.Domain.Entities
{
    public class MedicalRecord
    {
        [Key]
        public int Id { get; set; }

        public int PatientId { get; set; }

        [ForeignKey("PatientId")]
        public Patient? Patient { get; set; }

        public string Anamnesis { get; set; } = string.Empty;
        public string ClinicalExam { get; set; } = string.Empty;
        public string Diagnosis { get; set; } = string.Empty;
        public string TreatmentPlan { get; set; } = string.Empty;

        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
        public DateTime? UpdatedAt { get; set; }

        // Relacionamentos
        public ICollection<Evolution>? Evolutions { get; set; } = new List<Evolution>();
        public ICollection<TreatmentItem>? TreatmentItems { get; set; } = new List<TreatmentItem>();
        public ICollection<Attachment>? Attachments { get; set; } = new List<Attachment>();
    }
}