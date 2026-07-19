import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/notification_item.dart';
import '../../../core/providers/providers.dart';
import '../../../../core/network/realtime_service.dart';

/// Gerencia as notificações em tempo real.
class NotificationViewModel extends StateNotifier<AsyncValue<List<NotificationItem>>> {
  NotificationViewModel(this.ref) : super(const AsyncValue.loading()) {
    _initRealtime();
    _fetchNotifications();
  }

  final Ref ref;

  void _initRealtime() {
    final realtime = ref.read(realtimeServiceProvider);
    
    realtime.on('NewNotification', (args) {
      _fetchNotifications();
    });
  }

  Future<List<NotificationItem>> _fetchNotifications() async {
    // TODO: Implementar repositório de notificações
    return [];
  }

  /// Marca uma notificação como lida.
  Future<void> markAsRead(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar marcação como lida
      return _fetchNotifications();
    });
  }

  /// Limpa todas as notificações lidas.
  Future<void> clearRead() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar limpeza de notificacoes lidas
      return _fetchNotifications();
    });
  }
}

/// Provider para criar a instância do NotificationViewModel.
final notificationViewModelProvider = StateNotifierProvider<NotificationViewModel, AsyncValue<List<NotificationItem>>>((ref) {
  return NotificationViewModel(ref);
});
