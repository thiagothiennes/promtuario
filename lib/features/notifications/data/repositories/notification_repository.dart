import '../../../core/network/api_client.dart';
import '../../domain/entities/notification_item.dart';
import '../../domain/repositories/i_notification_repository.dart';

/// Implementação do repositório de notificações.
class NotificationRepository implements INotificationRepository {
  final ApiClient _apiClient;

  NotificationRepository(this._apiClient);

  @override
  Future<List<NotificationItem>> getNotifications() async {
    final response = await _apiClient.instance.get('/notifications');
    final List<dynamic> data = response.data;
    return data.map((json) => NotificationItem.fromJson(json)).toList();
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await _apiClient.instance.patch('/notifications/$notificationId/read');
  }

  @override
  Future<void> markAllAsRead() async {
    await _apiClient.instance.post('/notifications/read-all');
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await _apiClient.instance.delete('/notifications/$notificationId');
  }
}
