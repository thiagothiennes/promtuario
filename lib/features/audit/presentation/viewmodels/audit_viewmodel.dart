import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/audit_log.dart';
import '../../../core/providers/providers.dart';

/// Gerencia os logs de auditoria (LGPD).
class AuditViewModel extends StateNotifier<AsyncValue<List<AuditLog>>> {
  AuditViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchLogs();
  }

  final Ref ref;

  Future<List<AuditLog>> _fetchLogs({String? userId, String? action}) async {
    final repository = ref.read(auditRepositoryProvider);
    return await repository.getLogs(userId: userId, action: action);
  }

  /// Recarrega os logs de auditoria.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchLogs());
  }

  /// Filtra logs por usuário.
  Future<void> filterByUser(String userId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchLogs(userId: userId));
  }

  /// Filtra logs por ação.
  Future<void> filterByAction(String action) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchLogs(action: action));
  }
}

/// Provider para criar a instância do AuditViewModel.
final auditViewModelProvider = StateNotifierProvider<AuditViewModel, AsyncValue<List<AuditLog>>>((ref) {
  return AuditViewModel(ref);
});
