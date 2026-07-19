import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/anamnese_viewmodel.dart';

/// Tela de Ficha de Anamnese.
/// Exibe um questionário de saúde dinâmico e salva as respostas no prontuário.
class AnamneseScreen extends ConsumerStatefulWidget {
  final String patientId;
  final String patientName;

  const AnamneseScreen({
    super.key,
    required this.patientId,
    required this.patientName,
  });

  @override
  ConsumerState<AnamneseScreen> createState() => _AnamneseScreenState();
}

class _AnamneseScreenState extends ConsumerState<AnamneseScreen> {
  final Map<String, dynamic> _responses = {};
  bool _isSaving = false;

  final List<Map<String, dynamic>> _questions = [
    {'id': 'hist_doenca', 'label': 'Tem alguma doença? Quais?', 'type': 'text'},
    {'id': 'trat_medico', 'label': 'Está sob tratamento médico atualmente?', 'type': 'bool'},
    {'id': 'medicamentos', 'label': 'Toma algum medicamento? Quais?', 'type': 'text'},
    {'id': 'alergia', 'label': 'Possui alergia a medicamentos ou anestésicos?', 'type': 'text'},
    {'id': 'cirurgia', 'label': 'Já passou por alguma cirurgia?', 'type': 'text'},
    {'id': 'cardiaco', 'label': 'Possui problemas cardíacos?', 'type': 'bool'},
    {'id': 'diabetes', 'label': 'É diabético?', 'type': 'bool'},
    {'id': 'gravidez', 'label': 'Está grávida? (Se aplicável)', 'type': 'bool'},
    {'id': 'fumante', 'label': 'É fumante?', 'type': 'bool'},
    {'id': 'obs', 'label': 'Observações adicionais de saúde', 'type': 'text'},
  ];

  @override
  Widget build(BuildContext context) {
    final anamneseAsync = ref.watch(anamneseViewModelProvider(widget.patientId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ficha de Anamnese'),
        actions: [
          if (!_isSaving)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: _saveAnamnese,
            ),
        ],
      ),
      body: Stack(
        children: [
          anamneseAsync.when(
            data: (anamneses) {
              // Pega a anamnese mais recente da lista
              final latestAnamnese = anamneses.isNotEmpty ? anamneses.first : null;
              if (latestAnamnese != null && _responses.isEmpty) {
                _responses.addAll(latestAnamnese.responses);
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paciente: ${widget.patientName}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Por favor, preencha o histórico de saúde do paciente com atenção.',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 32),
                    ..._questions.map((q) => _buildQuestion(q)),
                    const SizedBox(height: 48),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: FilledButton.icon(
                        onPressed: _isSaving ? null : _saveAnamnese,
                        icon: _isSaving 
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Icon(Icons.check),
                        label: Text(_isSaving ? 'Salvando...' : 'Salvar Anamnese', style: const TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Erro ao carregar anamnese: $err')),
          ),
          if (_isSaving)
            const ModalBarrier(dismissible: false, color: Colors.black12),
        ],
      ),
    );
  }

  Widget _buildQuestion(Map<String, dynamic> q) {
    final String id = q['id'];
    final String label = q['label'];
    final String type = q['type'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          const SizedBox(height: 8),
          if (type == 'bool')
            SegmentedButton<bool>(
              segments: const [
                ButtonSegment(value: true, label: Text('Sim')),
                ButtonSegment(value: false, label: Text('Não')),
              ],
              selected: {_responses[id] ?? false},
              onSelectionChanged: (Set<bool> selection) {
                setState(() => _responses[id] = selection.first);
              },
            )
          else
            TextFormField(
              initialValue: _responses[id]?.toString() ?? '',
              maxLines: 2,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite aqui...',
              ),
              onChanged: (val) => _responses[id] = val,
            ),
        ],
      ),
    );
  }

  Future<void> _saveAnamnese() async {
    setState(() => _isSaving = true);
    try {
      await ref.read(anamneseViewModelProvider(widget.patientId).notifier).saveAnamnese(_responses);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Anamnese salva com sucesso!'), backgroundColor: Colors.green),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
}
