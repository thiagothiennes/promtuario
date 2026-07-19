import 'dart:async';
import 'dart:io';
import 'package:logging/logging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/local_database.dart';
import '../providers/providers.dart';
import '../../features/prontuario/domain/entities/attachment.dart';

/// Serviço responsável por sincronizar dados pendentes do banco local para a API.
/// Garante a resiliência do sistema em ambientes com internet instável.
class SyncService {
  final AppDatabase _db;
  final Ref _ref;
  final _logger = Logger('SyncService');
  Timer? _syncTimer;

  SyncService(this._db, this._ref);

  /// Inicia o monitoramento de sincronização periódica.
  void startAutoSync() {
    _syncTimer?.cancel();
    syncAll();
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (_) => syncAll());
    _logger.info('Auto-sync iniciado.');
  }

  /// Executa o ciclo completo de sincronização.
  Future<void> syncAll() async {
    _logger.info('Iniciando ciclo de sincronização de dados pendentes...');
    
    await _syncPatients();
    await _syncAppointments();
    await _syncWaitList();
    await _syncProntuario();
    await _syncAttachments();
    await _syncAuditLogs();
    
    _logger.info('Ciclo de sincronização finalizado.');
  }

  /// Sincroniza novos pacientes cadastrados offline.
  Future<void> _syncPatients() async {
    try {
      await _ref.read(patientRepositoryProvider).syncPatients();
    } catch (e) {
      _logger.warning('Falha ao sincronizar pacientes: $e');
    }
  }

  /// Sincroniza agendamentos feitos offline.
  Future<void> _syncAppointments() async {
    try {
      await _ref.read(appointmentRepositoryProvider).syncAppointments();
    } catch (e) {
      _logger.warning('Falha ao sincronizar agendamentos: $e');
    }
  }

  /// Sincroniza a lista de espera.
  Future<void> _syncWaitList() async {
    try {
      await _ref.read(waitListRepositoryProvider).syncWaitList();
    } catch (e) {
      _logger.warning('Falha ao sincronizar lista de espera: $e');
    }
  }

  /// Sincroniza evoluções, anamneses e itens de tratamento.
  Future<void> _syncProntuario() async {
    try {
      await _ref.read(prontuarioRepositoryProvider).syncPendingData();
    } catch (e) {
      _logger.warning('Falha ao sincronizar dados do prontuário: $e');
    }
  }

  /// Sincroniza anexos (fotos e exames) pendentes.
  Future<void> _syncAttachments() async {
    final unsynced = await (_db.select(_db.attachmentsLocal)
          ..where((t) => t.isSynced.equals(false)))
        .get();

    if (unsynced.isEmpty) return;

    final repo = _ref.read(attachmentRepositoryProvider);
    for (final row in unsynced) {
      try {
        final file = File(row.localPath);
        if (await file.exists()) {
          final type = AttachmentType.values.firstWhere((e) => e.name == row.type);
          await repo.uploadAttachment(row.patientId, file, type, description: row.description);
          
          // Se o upload foi bem sucedido (o repo marcará como sincronizado), podemos remover o registro local
          await (_db.delete(_db.attachmentsLocal)..where((t) => t.id.equals(row.id))).go();
          _logger.info('Anexo ${row.id} sincronizado com sucesso.');
        } else {
          // Arquivo local não encontrado, remove da fila
          await (_db.delete(_db.attachmentsLocal)..where((t) => t.id.equals(row.id))).go();
        }
      } catch (e) {
        _logger.warning('Falha ao sincronizar anexo ${row.id}: $e');
      }
    }
  }

  /// Sincroniza logs de auditoria (Conformidade LGPD).
  Future<void> _syncAuditLogs() async {
    final unsynced = await (_db.select(_db.auditLocal)
          ..where((t) => t.isSynced.equals(false)))
        .get();

    if (unsynced.isEmpty) return;

    final repo = _ref.read(auditRepositoryProvider);
    for (final log in unsynced) {
      try {
        await repo.registerAccess(log.resourceId, log.action);
        await (_db.delete(_db.auditLocal)..where((t) => t.id.equals(log.id))).go();
      } catch (_) {}
    }
  }

  void stop() {
    _syncTimer?.cancel();
  }
}

final syncServiceProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);
  return SyncService(db, ref);
});
