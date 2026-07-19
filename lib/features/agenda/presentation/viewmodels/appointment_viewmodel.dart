import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/appointment.dart';
import '../../domain/repositories/i_appointment_repository.dart';
import '../../../../core/providers/providers.dart';
import '../../../../core/network/realtime_service.dart';

part 'appointment_viewmodel.g.dart';

/// Gerencia o estado da agenda de atendimentos.
/// Integra com SignalR para atualizações em tempo real e suporta cache offline.
@riverpod
class AppointmentViewModel extends _$AppointmentViewModel {
  DateTime _currentDate = DateTime.now();

  @override
  FutureOr<List<Appointment>> build() async {
    final realtime = ref.read(realtimeServiceProvider);
    
    // Escuta atualizações da agenda vindas do servidor (ex: novo agendamento por outro usuário)
    realtime.on('AppointmentUpdated', (args) {
      ref.invalidateSelf();
    });

    return _fetchDailyAppointments(_currentDate);
  }

  Future<List<Appointment>> _fetchDailyAppointments(DateTime date) async {
    _currentDate = date;
    final repository = ref.read(appointmentRepositoryProvider);
    final start = DateTime(date.year, date.month, date.day, 0, 0);
    final end = DateTime(date.year, date.month, date.day, 23, 59, 59);
    
    return await repository.getAppointments(start: start, end: end);
  }

  /// Navega para uma data específica e recarrega a agenda.
  Future<void> fetchByDate(DateTime date) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchDailyAppointments(date));
  }

  /// Agenda um novo atendimento.
  Future<void> schedule(Appointment appointment) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(appointmentRepositoryProvider);
      await repository.scheduleAppointment(appointment);
      return _fetchDailyAppointments(appointment.startTime);
    });
  }

  /// Atualiza o status (Confirmado, Faltou, Atendido, etc).
  Future<void> updateStatus(String id, AppointmentStatus status) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(appointmentRepositoryProvider);
      await repository.updateAppointmentStatus(id, status);
      return _fetchDailyAppointments(_currentDate);
    });
  }
}
