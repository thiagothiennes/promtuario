import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/patient_viewmodel.dart';
import 'package:intl/intl.dart';

/// Tela de Listagem de Pacientes com busca e feedback visual de sincronização.
class PatientListScreen extends ConsumerWidget {
  const PatientListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientsAsync = ref.watch(patientViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Pacientes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () => ref.refresh(patientViewModelProvider),
            tooltip: 'Sincronizar manual',
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchBar(
              hintText: 'Buscar por nome ou CPF...',
              leading: const Icon(Icons.search),
              onChanged: (value) => ref.read(patientViewModelProvider.notifier).searchPatients(value),
            ),
          ),
          Expanded(
            child: patientsAsync.when(
              data: (patients) => patients.isEmpty 
                ? _buildEmptyState()
                : ListView.separated(
                    itemCount: patients.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final patient = patients[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                          child: Text(patient.fullName.substring(0, 1).toUpperCase()),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                patient.fullName,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (!patient.isSynced)
                              const Tooltip(
                                message: 'Aguardando sincronização (Offline)',
                                child: Icon(Icons.cloud_off, size: 16, color: Colors.orange),
                              ),
                          ],
                        ),
                        subtitle: Text('CPF: ${patient.cpf} • Nasc: ${DateFormat('dd/MM/yyyy').format(patient.birthDate)}'),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => context.push('/dashboard/patients/prontuario', extra: patient),
                      );
                    },
                  ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => _buildErrorState(ref, err.toString()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/dashboard/patients/add'),
        label: const Text('Novo Paciente'),
        icon: const Icon(Icons.person_add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_search, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('Nenhum paciente encontrado.', style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildErrorState(WidgetRef ref, String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('Erro ao carregar pacientes: $error', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref.invalidate(patientViewModelProvider),
              child: const Text('Tentar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
