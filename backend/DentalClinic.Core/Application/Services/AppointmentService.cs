using Microsoft.Extensions.Logging;
using DentalClinic.Core.Application.DTOs;
using DentalClinic.Core.Common;
using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;

namespace DentalClinic.Core.Application.Services;

/// <summary>
/// Serviço responsável pelas regras complexas de agendamento.
/// Garante a integridade da agenda e evita conflitos de horários.
/// </summary>
public class AppointmentService : IAppointmentService
{
    private readonly IAppointmentRepository _appointmentRepository;
    private readonly ILogger<AppointmentService> _logger;

    public AppointmentService(IAppointmentRepository appointmentRepository, ILogger<AppointmentService> logger)
    {
        _appointmentRepository = appointmentRepository;
        _logger = logger;
    }

    public async Task<Result<Appointment>> ScheduleAsync(Appointment appointment)
    {
        // 1. Verificar se o horário de término é após o início
        if (appointment.EndTime <= appointment.StartTime)
            return Result<Appointment>.Failure("O horário de término deve ser após o início.");

        // 2. Verificar conflitos para o profissional (Professor/Aluno)
        var hasConflict = await HasConflictAsync(appointment.DoctorId, appointment.StartTime, appointment.EndTime);
        if (hasConflict)
        {
            return Result<Appointment>.Failure("O profissional já possui um agendamento neste horário.");
        }

        // 3. Persistir o agendamento
        await _appointmentRepository.AddAsync(appointment);

        _logger.LogInformation("Nova consulta agendada: Paciente {PatientId} com Profissional {DoctorId}",
            appointment.PatientId, appointment.DoctorId);

        return Result<Appointment>.Ok(appointment);
    }

    public async Task<bool> HasConflictAsync(Guid doctorId, DateTime start, DateTime end)
    {
        var existing = await _appointmentRepository.GetByRangeAsync(start.Date, start.Date.AddDays(1), null);

        return existing.Any(a =>
            a.DoctorId == doctorId &&
            a.Status != AppointmentStatus.Cancelled &&
            ((start >= a.StartTime && start < a.EndTime) ||
             (end > a.StartTime && end <= a.EndTime) ||
             (start <= a.StartTime && end >= a.EndTime)));
    }

    public async Task AddToWaitListAsync(Guid patientId, Guid clinicId, string procedure)
    {
        // Lógica para lista de espera (seria uma nova tabela no banco)
        await Task.CompletedTask;
    }

    public async Task<Result<bool>> CancelAsync(Guid appointmentId, string reason)
    {
        var appointment = await _appointmentRepository.GetByIdAsync(appointmentId);
        if (appointment == null) return Result<bool>.Failure("Agendamento não encontrado.");

        appointment.UpdateStatus(AppointmentStatus.Cancelled);
        // Em produção, registraríamos o motivo e quem cancelou para auditoria
        await _appointmentRepository.UpdateAsync(appointment);

        return Result<bool>.Ok(true);
    }
}
