import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'realtime_service.dart';
import '../router/app_router.dart';

/// Serviço global para gerenciar notificações recebidas via SignalR.
/// Permite exibir alertas visuais em qualquer tela do aplicativo.
class NotificationHandler {
  final Ref _ref;

  NotificationHandler(this._ref);

  void init() {
    final realtime = _ref.read(realtimeServiceProvider);

    realtime.on('ReceiveNotification', (args) {
      if (args != null && args.isNotEmpty) {
        final message = args[0] as String;
        _showTopSnackBar(message);
      }
    });
  }

  void _showTopSnackBar(String message) {
    // Obtém o contexto global através do roteador (GoRouter)
    final context = _ref.read(routerProvider).configuration.navigatorKey.currentContext;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: const Color(0xFF006494),
        action: SnackBarAction(
          label: 'Ver',
          textColor: Colors.white,
          onPressed: () {
            // Lógica para navegar até a central de notificações
          },
        ),
      ),
    );
  }
}

final notificationHandlerProvider = Provider((ref) => NotificationHandler(ref));
