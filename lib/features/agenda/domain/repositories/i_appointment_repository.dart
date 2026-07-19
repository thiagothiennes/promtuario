import '../entities/appointment.dart';

/// Contrato para o Repositório de Agenda.
abstract class IAppointmentRepository {
  /// Recupera agendamentos para um intervalo de datas e opcionalmente uma clínica.
  Future<List<Appointment>> getAppointments({
    required DateTime start,
    required DateTime end,
    String? clinicId,
  });

  /// Cria um novo agendamento.
  Future<Appointment> scheduleAppointment(Appointment appointment);

  /// Atualiza o status de um agendamento (ex: Confirmar, Cancelar).
  Future<void> updateAppointmentStatus(String id, AppointmentStatus status);

  /// Reagenda uma consulta para novo horário.
  Future<void> rescheduleAppointment(String id, DateTime newStart, DateTime newEnd);

  /// Sincroniza agendamentos feitos em modo offline.
  Future<void> syncAppointments();
}
