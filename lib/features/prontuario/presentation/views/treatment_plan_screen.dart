import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/treatment_plan.dart';
import '../viewmodels/treatment_plan_viewmodel.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/viewmodels/auth_viewmodel.dart';

/// Tela de elaboração e acompanhamento do Plano de Tratamento.
class TreatmentPlanScreen extends ConsumerStatefulWidget {
  final String patientId;
  final String patientName;

  const TreatmentPlanScreen({
    super.key,
    required this.patientId,
    required this.patientName,
  });

  @override
  ConsumerState<TreatmentPlanScreen> createState() => _TreatmentPlanScreenState();
}

class _TreatmentPlanScreenState extends ConsumerState<TreatmentPlanScreen> {
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _showAddProcedureDialog() {
    String? selectedProcedure;
    int? toothNumber;
    double value = 0.0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Adicionar Procedimento'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Procedimento'),
                items: const [
                  DropdownMenuItem(value: 'Limpeza', child: Text('Limpeza / Profilaxia')),
                  DropdownMenuItem(value: 'Restauração', child: Text('Restauração')),
                  DropdownMenuItem(value: 'Endodontia', child: Text('Tratamento de Canal')),
                  DropdownMenuItem(value: 'Extração', child: Text('Exodontia')),
                ],
                onChanged: (v) => selectedProcedure = v,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Elemento (Opcional)'),
                keyboardType: TextInputType.number,
                onChanged: (v) => toothNumber = int.tryParse(v),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Valor sugerido (R\$)', prefixText: 'R\$ '),
                keyboardType: TextInputType.number,
                onChanged: (v) => value = double.tryParse(v) ?? 0.0,
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            FilledButton(
              onPressed: () {
                if (selectedProcedure != null) {
                  final newItem = TreatmentItem(
                    id: const Uuid().v4(),
                    procedureId: const Uuid().v4(), // Mock ID
                    procedureName: selectedProcedure!,
                    value: value,
                    toothNumber: toothNumber,
                    status: TreatmentItemStatus.pending,
                  );
                  ref.read(treatmentPlanViewModelProvider(widget.patientId).notifier).addItem(newItem);
                  Navigator.pop(context);
                }
              },
              child: const Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final planAsync = ref.watch(treatmentPlanViewModelProvider(widget.patientId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plano de Tratamento'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_outlined),
            onPressed: () {}, // Gerar PDF do plano
          ),
        ],
      ),
      body: planAsync.when(
        data: (plans) {
          if (plans.isEmpty) {
            return _buildEmptyState();
          }

          // Usa o primeiro plano da lista (mais recente ou ativo)
          final plan = plans.first;

          return Column(
            children: [
              _buildPlanHeader(plan),
              Expanded(child: _buildItemsList(plan.items)),
              _buildFooter(plan),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Erro: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddProcedureDialog,
        label: const Text('Adicionar Procedimento'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.assignment_outlined, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('Nenhum plano de tratamento ativo.', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _createNewPlan,
            child: const Text('Criar Novo Plano'),
          ),
        ],
      ),
    );
  }

  void _createNewPlan() {
    final authState = ref.read(authViewModelProvider);
    final user = authState.user;
    if (user == null) return;

    final newPlan = TreatmentPlan(
      id: const Uuid().v4(),
      patientId: widget.patientId,
      description: 'Plano de tratamento inicial',
      items: [],
      createdByUserId: user.id,
      status: TreatmentPlanStatus.draft,
      createdAt: DateTime.now(),
    );

    ref.read(treatmentPlanViewModelProvider(widget.patientId).notifier).savePlan(newPlan);
  }

  Widget _buildPlanHeader(TreatmentPlan plan) {
    return Container(
      padding: const EdgeInsets.all(24),
      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Status: ${plan.status.name.toUpperCase()}', 
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.blue)),
              const SizedBox(height: 4),
              Text(widget.patientName, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const Spacer(),
          if (plan.status == TreatmentPlanStatus.draft)
            FilledButton.tonal(
              onPressed: () {}, // Aprovar plano
              child: const Text('Aprovar Plano'),
            ),
        ],
      ),
    );
  }

  Widget _buildItemsList(List<TreatmentItem> items) {
    if (items.isEmpty) {
      return const Center(child: Text('Nenhum procedimento adicionado ainda.'));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: _getStatusColor(item.status).withOpacity(0.1),
            child: Icon(Icons.medical_services_outlined, color: _getStatusColor(item.status), size: 20),
          ),
          title: Text(item.procedureName, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(item.toothNumber != null ? 'Elemento ${item.toothNumber}' : 'Geral'),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('R\$ ${item.value.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(item.status.name.toLowerCase(), style: TextStyle(fontSize: 10, color: _getStatusColor(item.status))),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooter(TreatmentPlan plan) {
    final total = plan.items.fold<double>(0, (sum, item) => sum + item.value);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Valor Total Estimado:', style: TextStyle(fontSize: 16)),
          Text('R\$ ${total.toStringAsFixed(2)}', 
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF006494))),
        ],
      ),
    );
  }

  Color _getStatusColor(TreatmentItemStatus status) {
    return switch (status) {
      TreatmentItemStatus.pending => Colors.orange,
      TreatmentItemStatus.inProgress => Colors.blue,
      TreatmentItemStatus.completed => Colors.green,
      TreatmentItemStatus.cancelled => Colors.red,
    };
  }
}
