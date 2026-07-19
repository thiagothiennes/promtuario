import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';
import 'package:promt/core/database/local_database.dart';
import 'package:promt/core/providers/providers.dart';

/// Coordena a sincronizaÃ§Ã£o de dados persistidos localmente.
class SyncService {
  SyncService(this._db, this._ref);

  final AppDatabase _db;
  final Ref _ref;
  final Logger _logger = Logger('SyncService');
  Timer? _syncTimer;
  bool _isSynchronizing = false;

  void startAutoSync() {
    _syncTimer?.cancel();
    unawaited(syncAll());
    _syncTimer =
        Timer.periodic(const Duration(minutes: 5), (_) => unawaited(syncAll()));
  }

  Future<void> syncAll() async {
    if (_isSynchronizing) return;
    _isSynchronizing = true;
    try {
      _logger.info('Iniciando sincronizaÃ§Ã£o de dados pendentes.');
      await _syncPatients();
      await _syncAppointments();
      await _syncWaitList();
      await _syncProntuario();
      await _syncAttachments();
      await _syncAuditLogs();
      _logger.info('SincronizaÃ§Ã£o de dados pendentes concluÃ­da.');
    } finally {
      _isSynchronizing = false;
    }
  }

  Future<void> _syncPatients() => _run(
      'pacientes', () => _ref.read(patientRepositoryProvider).syncPatients());

  Future<void> _syncAppointments() => _run('agendamentos',
      () => _ref.read(appointmentRepositoryProvider).syncAppointments());

  Future<void> _syncWaitList() => _run('lista de espera',
      () => _ref.read(waitListRepositoryProvider).syncWaitList());

  Future<void> _syncProntuario() => _run('prontuÃ¡rio',
      () => _ref.read(prontuarioRepositoryProvider).syncPendingData());

  Future<void> _syncAttachments() async {
    final pending = await (_db.select(_db.attachmentsLocal)
          ..where((table) => table.isSynced.equals(false)))
        .get();
    final repository = _ref.read(attachmentRepositoryProvider);
    for (final attachment in pending) {
      final sent = await repository.syncPendingAttachment(attachment.id);
      if (!sent) {
        _logger.warning(
            'Anexo ${attachment.id} mantido na fila para nova tentativa.');
      }
    }
  }

  Future<void> _syncAuditLogs() async {
    final pending = await (_db.select(_db.auditLocal)
          ..where((table) => table.isSynced.equals(false)))
        .get();
    final repository = _ref.read(auditRepositoryProvider);
    for (final log in pending) {
      try {
        final sent =
            await repository.syncPendingAccess(log.resourceId, log.action);
        if (!sent) continue;
        await (_db.delete(_db.auditLocal)
              ..where((table) => table.id.equals(log.id)))
            .go();
      } catch (error, stackTrace) {
        _logger.warning(
            'Falha ao sincronizar auditoria ${log.id}.', error, stackTrace);
      }
    }
  }

  Future<void> _run(String scope, Future<void> Function() action) async {
    try {
      await action();
    } catch (error, stackTrace) {
      _logger.warning('Falha ao sincronizar $scope.', error, stackTrace);
    }
  }

  void stop() => _syncTimer?.cancel();
}

final syncServiceProvider =
    Provider((ref) => SyncService(ref.watch(databaseProvider), ref));
