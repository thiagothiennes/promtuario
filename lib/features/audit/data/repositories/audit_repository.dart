import 'package:drift/drift.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/database/local_database.dart';
import '../../domain/entities/audit_log.dart';
import '../../domain/repositories/i_audit_repository.dart';

/// Implementação do repositório de auditoria com suporte offline.
/// Garante que toda ação sensível seja registrada, mesmo sem internet.
class AuditRepository implements IAuditRepository {
  final ApiClient _apiClient;
  final AppDatabase _localDb;

  AuditRepository(this._apiClient, this._localDb);

  @override
  Future<List<AuditLog>> getLogs({int page = 1, int pageSize = 50, String? userId, String? action}) async {
    final response = await _apiClient.instance.get('/logs', queryParameters: {
      'page': page,
      'pageSize': pageSize,
      if (userId != null) 'userId': userId,
      if (action != null) 'action': action,
    });

    final List<dynamic> data = response.data['items'] ?? [];
    return data.map((json) => AuditLog.fromJson(json)).toList();
  }

  @override
  Future<void> registerAccess(String resourceId, String action) async {
    try {
      await _apiClient.instance.post('/logs/register', data: {
        'resourceId': resourceId,
        'action': action,
        'timestamp': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Falha na rede: Garante a conformidade salvando no banco local
      await _localDb.into(_localDb.auditLocal).insert(
            AuditLocalCompanion.insert(
              resourceId: resourceId,
              action: action,
              timestamp: DateTime.now(),
              isSynced: const Value(false),
            ),
          );
    }
  }

  @override
  Future<bool> syncPendingAccess(String resourceId, String action) async {
    try {
      await _apiClient.instance.post('/logs/register', data: {
        'resourceId': resourceId,
        'action': action,
        'timestamp': DateTime.now().toIso8601String(),
      });
      return true;
    } catch (_) {
      return false;
    }
  }
}
