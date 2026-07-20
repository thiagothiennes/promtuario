using DentalClinic.Core.Domain.ValueObjects;

namespace DentalClinic.Core.Domain.Entities;

public sealed class Appointment : Entity
{
    public int PatientId { get; private set; }
    public Patient Patient { get; private set; } = null!;

    public Guid DoctorId { get; private set; }
    public User Doctor { get; private set; } = null!;

    public DateTime StartTime { get; private set; }
    public DateTime EndTime { get; private set; }

    public AppointmentStatus Status { get; private set; }
    public string? ProcedureName { get; private set; }
    public string? Notes { get; private set; }
    public Guid ClinicId { get; private set; }

    private Appointment() { }

    public static Appointment Create(
        int patientId,
        Guid doctorId,
        DateTime startTime,
        DateTime endTime,
        Guid clinicId,
        string? procedureName = null,
        string? notes = null)
    {
        if (endTime <= startTime)
            throw new InvalidOperationException("End time must be after start time.");

        return new Appointment
        {
            PatientId = patientId,
            DoctorId = doctorId,
            StartTime = startTime,
            EndTime = endTime,
            ClinicId = clinicId,
            ProcedureName = procedureName,
            Notes = notes,
            Status = AppointmentStatus.Scheduled
        };
    }

    public void UpdateStatus(AppointmentStatus status)
    {
        Status = status;
        UpdatedAt = DateTime.UtcNow;
    }

    public void Reschedule(DateTime newStart, DateTime newEnd)
    {
        if (newEnd <= newStart)
            throw new InvalidOperationException("End time must be after start time.");

        StartTime = newStart;
        EndTime = newEnd;
        UpdatedAt = DateTime.UtcNow;
    }
}

public enum AppointmentStatus
{
    Scheduled = 1,
    Confirmed = 2,
    InProgress = 3,
    Completed = 4,
    Cancelled = 5,
    Missed = 6
}
