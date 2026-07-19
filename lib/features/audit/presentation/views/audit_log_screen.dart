import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:promt/features/audit/presentation/viewmodels/audit_viewmodel.dart';
import 'package:promt/features/audit/domain/entities/audit_log.dart';

/// Tela de Logs de Auditoria e Transparência (LGPD).
class AuditLogScreen extends ConsumerWidget {
  const AuditLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(auditViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs de Auditoria (LGPD)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(auditViewModelProvider.notifier).refresh(),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: logsAsync.when(
        data: (logs) => Column(
          children: [
            _buildAuditStats(logs),
            const Divider(height: 1),
            Expanded(
              child: logs.isEmpty
                  ? const Center(child: Text('Nenhum registro encontrado.'))
                  : ListView.builder(
                      itemCount: logs.length,
                      padding: const EdgeInsets.all(16),
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        return _AuditLogTile(log: log);
                      },
                    ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Erro ao carregar logs: $err')),
      ),
    );
  }

  Widget _buildAuditStats(List<AuditLog> logs) {
    final agora = DateTime.now();
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.withOpacity(0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Total de Registros', logs.length.toString()),
          _buildStatItem('Acessos Hoje', logs.where((l) => l.dataHora.day == agora.day && l.dataHora.month == agora.month && l.dataHora.year == agora.year).length.toString()),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF006494))),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}

class _AuditLogTile extends StatelessWidget {
  final AuditLog log;
  const _AuditLogTile({required this.log});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getActionColor(log.acao).withOpacity(0.1),
          child: Icon(_getActionIcon(log.acao), color: _getActionColor(log.acao), size: 20),
        ),
        title: Text(
          log.acao,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        subtitle: Text(
          '${DateFormat('dd/MM/yyyy HH:mm:ss').format(log.dataHora)} • IP: ${log.ipAddress}',
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Detalhes do Evento:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    log.detalhes ?? 'Sem detalhes adicionais.',
                    style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                  ),
                ),
                const SizedBox(height: 8),
                Text('Usuário ID: ${log.usuarioId}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData _getActionIcon(String action) {
    if (action.contains('LOGIN')) return Icons.login;
    if (action.contains('GET')) return Icons.visibility_outlined;
    if (action.contains('POST')) return Icons.add_circle_outline;
    if (action.contains('PUT') || action.contains('PATCH')) return Icons.edit_note;
    if (action.contains('DELETE')) return Icons.delete_forever_outlined;
    return Icons.info_outline;
  }

  Color _getActionColor(String action) {
    if (action.contains('DELETE')) return Colors.red;
    if (action.contains('POST')) return Colors.green;
    if (action.contains('PUT') || action.contains('PATCH')) return Colors.orange;
    if (action.contains('LOGIN')) return Colors.blue;
    return Colors.blueGrey;
  }
}
