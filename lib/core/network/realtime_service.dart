import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../security/storage_service.dart';

/// Serviço responsável pela comunicação em tempo real via SignalR.
/// Gerencia atualizações globais como notificações e mudanças no prontuário.
class RealtimeService {
  final StorageService _storage;
  HubConnection? _hubConnection;
  final _logger = Logger('RealtimeService');

  RealtimeService(this._storage);

  /// Inicializa a conexão com o Hub do SignalR.
  Future<void> init() async {
    // Se já estiver conectado ou conectando, não faz nada
    if (_hubConnection?.state == HubConnectionState.Connected || 
        _hubConnection?.state == HubConnectionState.Connecting) {
      return;
    }

    final token = await _storage.getAccessToken();
    if (token == null) {
      _logger.warning('Token não encontrado. SignalR não será inicializado.');
      return;
    }

    final httpOptions = HttpConnectionOptions(
      accessTokenFactory: () async => token,
      logMessageContent: true,
    );

    _hubConnection = HubConnectionBuilder()
        .withUrl('https://api.odontoclinica.edu.br/hubs/clinic', options: httpOptions)
        .withAutomaticReconnect()
        .build();

    _hubConnection?.onclose(({error}) => _logger.warning('Conexão SignalR fechada: $error'));
    
    _hubConnection?.on('ReceiveNotification', (arguments) {
      _logger.info('Nova notificação recebida em tempo real.');
    });

    try {
      await _hubConnection?.start();
      _logger.info('Conexão SignalR estabelecida com sucesso.');
    } catch (e) {
      _logger.severe('Erro ao iniciar conexão SignalR: $e');
    }
  }

  /// Entra no grupo de monitoramento de um paciente específico (Prontuário).
  Future<void> joinPatientGroup(String patientId) async {
    if (_hubConnection?.state == HubConnectionState.Connected) {
      try {
        await _hubConnection?.invoke('JoinPatientGroup', args: [patientId]);
        _logger.info('Entrou no grupo do paciente: $patientId');
      } catch (e) {
        _logger.severe('Erro ao entrar no grupo do paciente: $e');
      }
    }
  }

  /// Sai do grupo de monitoramento de um paciente.
  Future<void> leavePatientGroup(String patientId) async {
    if (_hubConnection?.state == HubConnectionState.Connected) {
      try {
        await _hubConnection?.invoke('LeavePatientGroup', args: [patientId]);
      } catch (e) {
        _logger.severe('Erro ao sair do grupo do paciente: $e');
      }
    }
  }

  void on(String methodName, void Function(List<Object?>?) callback) {
    _hubConnection?.on(methodName, callback);
  }

  Future<void> stop() async {
    await _hubConnection?.stop();
    _hubConnection = null;
  }
}

final realtimeServiceProvider = Provider((ref) {
  final storage = ref.watch(storageServiceProvider);
  return RealtimeService(storage);
});
