import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/notifications/domain/entities/notification_item.dart';
import 'package:promt/core/providers/providers.dart';
import 'package:promt/core/network/realtime_service.dart';

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

  Future<void> _fetchNotifications() async {
    state = await AsyncValue.guard(() async {
      final repo = ref.read(notificationRepositoryProvider);
      return await repo.getNotifications();
    });
  }

  Future<void> markAsRead(String id) async {
    state = await AsyncValue.guard(() async {
      await ref.read(notificationRepositoryProvider).markAsRead(id);
      return await ref.read(notificationRepositoryProvider).getNotifications();
    });
  }

  Future<void> markAllAsRead() async {
    state = await AsyncValue.guard(() async {
      await ref.read(notificationRepositoryProvider).markAllAsRead();
      return await ref.read(notificationRepositoryProvider).getNotifications();
    });
  }
}

final notificationViewModelProvider = StateNotifierProvider<NotificationViewModel, AsyncValue<List<NotificationItem>>>((ref) {
  return NotificationViewModel(ref);
});
