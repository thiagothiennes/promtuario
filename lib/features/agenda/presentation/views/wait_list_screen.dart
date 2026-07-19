import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:promt/features/agenda/presentation/viewmodels/wait_list_viewmodel.dart';
import 'package:promt/features/agenda/domain/entities/wait_list_entry.dart';
import 'package:promt/features/patients/presentation/viewmodels/patient_viewmodel.dart';

/// Tela de Gestão da Lista de Espera.
class WaitListScreen extends ConsumerWidget {
  final String clinicId;
  final String clinicName;

  const WaitListScreen({
    super.key,
    required this.clinicId,
    required this.clinicName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final waitListAsync = ref.watch(waitListViewModelProvider(clinicId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Fila de Espera: $clinicName'),
      ),
      body: waitListAsync.when(
        data: (entries) => entries.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: entries.length,
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return _WaitListCard(entry: entry, clinicId: clinicId);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Erro ao carregar lista: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEntryDialog(context, ref),
        label: const Text('Adicionar à Fila'),
        icon: const Icon(Icons.person_add_alt_1),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.hourglass_empty, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Nenhum paciente aguardando nesta clínica.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  void _showAddEntryDialog(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.read(patientViewModelProvider);
    String? selectedPatientId;
    String? selectedPatientName;
    String selectedPriority = 'Normal';
    String specialty = 'Clínica Geral';
    final obsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar à Lista de Espera'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              patientsAsync.when(
                data: (patients) => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Paciente'),
                  items: patients.map((p) => DropdownMenuItem(value: p.id, child: Text(p.fullName))).toList(),
                  onChanged: (val) {
                    selectedPatientId = val;
                    selectedPatientName = patients.firstWhere((p) => p.id == val).fullName;
                  },
                ),
                loading: () => const LinearProgressIndicator(),
                error: (_, __) => const Text('Erro ao carregar pacientes'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedPriority,
                decoration: const InputDecoration(labelText: 'Prioridade'),
                items: ['Normal', 'Prioritário', 'Urgente'].map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
                onChanged: (val) => setState(() => selectedPriority = val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Especialidade Necessária'),
                onChanged: (val) => specialty = val,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: obsController,
                decoration: const InputDecoration(labelText: 'Observações'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () {
              if (selectedPatientId != null) {
                final entry = WaitListEntry(
                  id: const Uuid().v4(),
                  patientId: selectedPatientId!,
                  patientName: selectedPatientName!,
                  clinicId: clinicId,
                  specialty: specialty,
                  priority: selectedPriority,
                  observation: obsController.text,
                  createdAt: DateTime.now(),
                );
                ref.read(waitListViewModelProvider(clinicId).notifier).addEntry(entry);
                Navigator.pop(context);
              }
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}

class _WaitListCard extends ConsumerWidget {
  final WaitListEntry entry;
  final String clinicId;

  const _WaitListCard({required this.entry, required this.clinicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getPriorityColor(entry.priority).withOpacity(0.1),
          child: Text(
            entry.patientName.substring(0, 1).toUpperCase(),
            style: TextStyle(color: _getPriorityColor(entry.priority), fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(entry.patientName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Especialidade: ${entry.specialty}'),
            Text('Aguardando desde: ${DateFormat('dd/MM/yyyy HH:mm').format(entry.createdAt)}',
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
        trailing: PopupMenuButton<String>(
          onSelected: (val) {
            if (val == 'resolve') {
              ref.read(waitListViewModelProvider(clinicId).notifier).resolve(entry.id);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'schedule', child: Text('Agendar Agora')),
            const PopupMenuItem(value: 'resolve', child: Text('Marcar como Resolvido')),
            const PopupMenuItem(value: 'remove', child: Text('Remover da Fila', style: TextStyle(color: Colors.red))),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    return switch (priority.toLowerCase()) {
      'urgente' => Colors.red,
      'prioritário' => Colors.orange,
      _ => Colors.blue,
    };
  }
}
