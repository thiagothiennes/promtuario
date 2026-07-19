import 'package:drift/drift.dart';
import 'package:logging/logging.dart';
import 'package:promt/core/network/api_client.dart';
import 'package:promt/core/database/local_database.dart';
import 'package:promt/features/agenda/domain/entities/appointment.dart';
import 'package:promt/features/agenda/domain/repositories/i_appointment_repository.dart';

/// Implementação do Repositório de Agenda com Cache Offline e Sincronização.
class AppointmentRepository implements IAppointmentRepository {
  final ApiClient _apiClient;
  final AppDatabase _localDb;
  final _logger = Logger('AppointmentRepository');

  AppointmentRepository(this._apiClient, this._localDb);

  @override
  Future<List<Appointment>> getAppointments({
    required DateTime start,
    required DateTime end,
    String? clinicId,
  }) async {
    try {
      final response = await _apiClient.instance.get('/appointments', queryParameters: {
        'start': start.toIso8601String(),
        'end': end.toIso8601String(),
        if (clinicId != null) 'clinicId': clinicId,
      });

      final List<dynamic> data = response.data ?? [];
      final appointments = data.map((json) => Appointment.fromJson(json)).toList();

      // Atualiza o cache local
      _updateLocalCache(appointments);

      return appointments;
    } catch (e) {
      _logger.warning('Falha ao buscar agendamentos remotos, carregando cache local: $e');
      
      // Fallback para o Banco Local em caso de falha de conexão (Offline)
      final query = _localDb.select(_localDb.appointmentsLocal)
        ..where((t) => t.startTime.isBetweenValues(start, end));
      
      if (clinicId != null) {
        query.where((t) => t.clinicId.equals(clinicId));
      }

      final results = await query.get();
      return results.map((row) => _mapSchemaToEntity(row)).toList();
    }
  }

  @override
  Future<Appointment> scheduleAppointment(Appointment appointment) async {
    try {
      final response = await _apiClient.instance.post(
        '/appointments',
        data: appointment.toJson(),
      );
      final newAppointment = Appointment.fromJson(response.data);
      
      await _saveLocal(newAppointment, true);
      return newAppointment;
    } catch (e) {
      _logger.severe('Erro no agendamento, salvando para sincronização offline: $e');
      // Falha na rede: Salva localmente marcado como NÃO sincronizado para o SyncService
      await _saveLocal(appointment, false);
      return appointment;
    }
  }

  @override
  Future<void> updateAppointmentStatus(String id, AppointmentStatus status) async {
    try {
      await _apiClient.instance.patch(
        '/appointments/$id/status',
        data: {'status': status.name},
      );
      
      // Atualiza localmente e marca como sincronizado
      await _updateLocalStatus(id, status, true);
    } catch (e) {
      _logger.warning('Falha ao atualizar status remotamente, marcando para sincronização: $e');
      // Falha na rede: Atualiza localmente mas marca como PENDENTE de sincronização
      await _updateLocalStatus(id, status, false);
    }
  }

  @override
  Future<void> syncAppointments() async {
    final unsynced = await (_localDb.select(_localDb.appointmentsLocal)
          ..where((t) => t.isSynced.equals(false)))
        .get();

    for (final row in unsynced) {
      try {
        final appointment = _mapSchemaToEntity(row);
        // Usa PUT para garantir que o registro seja criado ou atualizado (Idempotência)
        await _apiClient.instance.put(
          '/appointments/${appointment.id}',
          data: appointment.toJson(),
        );
        
        await (_localDb.update(_localDb.appointmentsLocal)..where((t) => t.id.equals(row.id))).write(
          const AppointmentsLocalCompanion(isSynced: Value(true)),
        );
      } catch (e) {
        _logger.warning('Falha ao sincronizar agendamento ${row.id}: $e');
      }
    }
  }

  @override
  Future<void> rescheduleAppointment(String id, DateTime newStart, DateTime newEnd) async {
    try {
      await _apiClient.instance.put(
        '/appointments/$id/reschedule',
        data: {
          'startTime': newStart.toIso8601String(),
          'endTime': newEnd.toIso8601String(),
        },
      );
    } catch (e) {
      _logger.severe('Erro ao reagendar: $e');
      rethrow;
    }
  }

  Future<void> _updateLocalStatus(String id, AppointmentStatus status, bool isSynced) async {
    await (_localDb.update(_localDb.appointmentsLocal)..where((t) => t.id.equals(id))).write(
      AppointmentsLocalCompanion(
        status: Value(status.name),
        isSynced: Value(isSynced),
      ),
    );
  }

  Future<void> _saveLocal(Appointment app, bool isSynced) async {
    await _localDb.into(_localDb.appointmentsLocal).insertOnConflictUpdate(
      AppointmentsLocalCompanion.insert(
        id: app.id,
        patientName: app.patientName,
        startTime: app.startTime,
        endTime: app.endTime,
        status: app.status.name,
        patientId: Value(app.patientId),
        doctorId: Value(app.doctorId),
        doctorName: Value(app.doctorName),
        procedureName: Value(app.procedureName),
        notes: Value(app.notes),
        clinicId: Value(app.clinicId),
        isSynced: Value(isSynced),
      ),
    );
  }

  void _updateLocalCache(List<Appointment> appointments) async {
    for (var app in appointments) {
      await _saveLocal(app, true);
    }
  }

  Appointment _mapSchemaToEntity(AppointmentsLocalData row) {
    return Appointment(
      id: row.id,
      patientId: row.patientId, 
      patientName: row.patientName,
      doctorId: row.doctorId,
      doctorName: row.doctorName,
      startTime: row.startTime,
      endTime: row.endTime,
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == row.status,
        orElse: () => AppointmentStatus.scheduled,
      ),
      procedureName: row.procedureName,
      notes: row.notes,
      clinicId: row.clinicId,
    );
  }
}
