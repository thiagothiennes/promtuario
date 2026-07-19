import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/notification_item.dart';
import '../../domain/repositories/i_notification_repository.dart';
import '../../../../core/providers/providers.dart';
import '../../../../core/network/realtime_service.dart';

part 'notification_viewmodel.g.dart';

@riverpod
class NotificationViewModel extends _$NotificationViewModel {
  @override
  FutureOr<List<NotificationItem>> build() async {
    final realtime = ref.read(realtimeServiceProvider);
    
    // Escuta novas notificações em tempo real
    realtime.on('ReceiveNotification', (args) {
      ref.invalidateSelf(); // Recarrega a lista automaticamente
    });

    return _fetchNotifications();
  }

  Future<List<NotificationItem>> _fetchNotifications() async {
    final repository = ref.read(notificationRepositoryProvider);
    return await repository.getNotifications();
  }

  Future<void> markAsRead(String notificationId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(notificationRepositoryProvider);
      await repository.markAsRead(notificationId);
      return _fetchNotifications();
    });
  }

  Future<void> markAllAsRead() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(notificationRepositoryProvider);
      await repository.markAllAsRead();
      return _fetchNotifications();
    });
  }

  Future<void> delete(String notificationId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(notificationRepositoryProvider);
      await repository.deleteNotification(notificationId);
      return _fetchNotifications();
    });
  }
}
