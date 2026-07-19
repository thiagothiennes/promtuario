import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../viewmodels/notification_viewmodel.dart';
import '../domain/entities/notification_item.dart';
import '../domain/entities/notification_item.dart' show NotificationType;

/// Tela de notificações e alertas do sistema.
class NotificationListScreen extends ConsumerWidget {
  const NotificationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notificações'),
        actions: [
          TextButton(
            onPressed: () => ref.read(notificationViewModelProvider.notifier).markAllAsRead(),
            child: const Text('Limpar tudo'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: notificationsAsync.when(
        data: (notifications) => notifications.isEmpty
            ? _buildEmptyState()
            : ListView.separated(
                itemCount: notifications.length,
                padding: const EdgeInsets.all(16),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = notifications[index];
                  return _NotificationCard(item: item);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Erro: $err')),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_none_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Você não possui novas notificações.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}

class _NotificationCard extends ConsumerWidget {
  final NotificationItem item;
  const _NotificationCard({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      elevation: item.isRead ? 0 : 2,
      color: item.isRead ? Colors.transparent : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: item.isRead ? BorderSide(color: Colors.grey.shade300) : BorderSide.none,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getTypeColor(item.type).withOpacity(0.1),
          child: Icon(_getTypeIcon(item.type), color: _getTypeColor(item.type), size: 20),
        ),
        title: Text(
          item.title,
          style: TextStyle(fontWeight: item.isRead ? FontWeight.normal : FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.message),
            const SizedBox(height: 4),
            Text(
              DateFormat('dd/MM HH:mm').format(item.timestamp),
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
        onTap: () {
          if (!item.isRead) {
            ref.read(notificationViewModelProvider.notifier).markAsRead(item.id);
          }
        },
      ),
    );
  }

  IconData _getTypeIcon(NotificationType type) {
    return switch (type) {
      NotificationType.appointmentReminder => Icons.calendar_today,
      NotificationType.pendingSignature => Icons.draw,
      NotificationType.treatmentApproved => Icons.check_circle_outline,
      NotificationType.systemAlert => Icons.warning_amber,
    };
  }

  Color _getTypeColor(NotificationType type) {
    return switch (type) {
      NotificationType.appointmentReminder => Colors.blue,
      NotificationType.pendingSignature => Colors.orange,
      NotificationType.treatmentApproved => Colors.green,
      NotificationType.systemAlert => Colors.red,
    };
  }
}
