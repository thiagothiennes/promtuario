import 'package:drift/drift.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/database/local_database.dart';
import '../domain/entities/wait_list_entry.dart';
import '../domain/repositories/i_wait_list_repository.dart';

/// Implementação do repositório de Lista de Espera com suporte a Cache Offline.
class WaitListRepository implements IWaitListRepository {
  final ApiClient _apiClient;
  final AppDatabase _localDb;

  WaitListRepository(this._apiClient, this._localDb);

  @override
  Future<List<WaitListEntry>> getWaitListByClinic(String clinicId) async {
    try {
      final response = await _apiClient.instance.get('/wait-list', queryParameters: {
        'clinicId': clinicId,
      });

      final List<dynamic> data = response.data;
      final entries = data.map((json) => WaitListEntry.fromJson(json)).toList();

      // Atualiza o cache local
      _updateLocalCache(entries);

      return entries;
    } catch (e) {
      // Offline: Busca no banco local
      final results = await (_localDb.select(_localDb.waitListLocal)
            ..where((t) => t.clinicId.equals(clinicId)))
          .get();
      
      return results.map((row) => WaitListEntry(
        id: row.id,
        patientId: row.patientId,
        patientName: row.patientName,
        clinicId: row.clinicId,
        specialty: row.specialty,
        priority: row.priority,
        createdAt: row.createdAt,
      )).toList();
    }
  }

  @override
  Future<void> addToWaitList(WaitListEntry entry) async {
    try {
      await _apiClient.instance.post('/wait-list', data: entry.toJson());
      await _saveLocal(entry, true);
    } catch (e) {
      // Falha na rede: Salva localmente marcado como NÃO sincronizado
      await _saveLocal(entry, false);
    }
  }

  @override
  Future<void> resolveEntry(String entryId) async {
    try {
      await _apiClient.instance.patch('/wait-list/$entryId/resolve');
      // Remove do banco local ao resolver
      await (_localDb.delete(_localDb.waitListLocal)..where((t) => t.id.equals(entryId))).go();
    } catch (e) {
      // No offline, poderíamos marcar como "pendente de resolução"
    }
  }

  @override
  Future<void> syncWaitList() async {
    final unsynced = await (_localDb.select(_localDb.waitListLocal)
          ..where((t) => t.isSynced.equals(false)))
        .get();

    for (final row in unsynced) {
      try {
        final entry = WaitListEntry(
          id: row.id,
          patientId: row.patientId,
          patientName: row.patientName,
          clinicId: row.clinicId,
          priority: row.priority,
          specialty: row.specialty,
          createdAt: row.createdAt,
        );
        await _apiClient.instance.post('/wait-list', data: entry.toJson());
        
        await (_localDb.update(_localDb.waitListLocal)..where((t) => t.id.equals(row.id))).write(
          const WaitListLocalCompanion(isSynced: Value(true)),
        );
      } catch (_) {}
    }
  }

  Future<void> _saveLocal(WaitListEntry entry, bool isSynced) async {
    await _localDb.into(_localDb.waitListLocal).insertOnConflictUpdate(
      WaitListLocalCompanion.insert(
        id: entry.id,
        patientId: entry.patientId,
        patientName: entry.patientName,
        clinicId: entry.clinicId,
        priority: entry.priority,
        specialty: entry.specialty,
        createdAt: entry.createdAt,
        isSynced: Value(isSynced),
      ),
    );
  }

  void _updateLocalCache(List<WaitListEntry> entries) async {
    for (var entry in entries) {
      await _saveLocal(entry, true);
    }
  }
}
