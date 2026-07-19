import '../entities/audit_log.dart';

/// Contrato para o Repositório de Auditoria.
abstract class IAuditRepository {
  /// Recupera logs de auditoria de forma paginada.
  Future<List<AuditLog>> getLogs(
      {int page = 1, int pageSize = 50, String? userId});

  /// Registra uma ação sensível para conformidade LGPD.
  Future<void> registerAccess(String resourceId, String action);

  /// Reenvia um evento pendente sem criar uma nova cÃ³pia na fila offline.
  Future<bool> syncPendingAccess(String resourceId, String action);
}
