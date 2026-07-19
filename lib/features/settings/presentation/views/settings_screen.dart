import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../../../core/theme/theme_viewmodel.dart';

/// Tela de Configurações do Sistema e Perfil.
/// Agora integrada ao ThemeViewModel para controle real de aparência.
class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    final user = authState.user;
    final themeMode = ref.watch(themeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSectionHeader('Meu Perfil'),
          Card(
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                child: Text(user?.name.substring(0, 1).toUpperCase() ?? 'U', 
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ),
              title: Text(user?.name ?? 'Usuário', style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(user?.email ?? 'email@instituicao.edu.br'),
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('Sistema'),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: const Text('Tema do Aplicativo'),
                  subtitle: Text(_getThemeName(themeMode)),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showThemeDialog(context, ref),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.notifications_active_outlined),
                  title: const Text('Notificações Push'),
                  subtitle: const Text('Gerenciar alertas de agenda e assinaturas'),
                  trailing: Switch(value: true, onChanged: (v) {}),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('Privacidade (LGPD)'),
          Card(
            child: ListTile(
              leading: const Icon(Icons.history_toggle_off),
              title: const Text('Logs de Acesso'),
              subtitle: const Text('Ver registros de quem acessou seus dados'),
              onTap: () => Navigator.pushNamed(context, '/dashboard/audit-logs'),
            ),
          ),
          const SizedBox(height: 48),
          OutlinedButton.icon(
            onPressed: () => ref.read(authViewModelProvider.notifier).logout(),
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text('Encerrar Sessão', style: TextStyle(color: Colors.red)),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.all(16),
              side: const BorderSide(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  String _getThemeName(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.system => 'Acompanhar Sistema',
      ThemeMode.light => 'Modo Claro',
      ThemeMode.dark => 'Modo Escuro',
    };
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escolha o Tema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('Claro'),
              value: ThemeMode.light,
              groupValue: ref.watch(themeViewModelProvider),
              onChanged: (val) {
                ref.read(themeViewModelProvider.notifier).setThemeMode(val!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Escuro'),
              value: ThemeMode.dark,
              groupValue: ref.watch(themeViewModelProvider),
              onChanged: (val) {
                ref.read(themeViewModelProvider.notifier).setThemeMode(val!);
                Navigator.pop(context);
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Padrão do Sistema'),
              value: ThemeMode.system,
              groupValue: ref.watch(themeViewModelProvider),
              onChanged: (val) {
                ref.read(themeViewModelProvider.notifier).setThemeMode(val!);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }
}
