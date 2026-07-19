import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../viewmodels/prontuario_viewmodel.dart';
import '../viewmodels/documents_viewmodel.dart';
import '../viewmodels/attachment_viewmodel.dart';
import '../viewmodels/evolution_viewmodel.dart';
import '../../users/presentation/viewmodels/user_management_viewmodel.dart';
import '../widgets/odontogram_widget.dart';
import '../../patients/domain/entities/patient.dart';
import '../domain/entities/attachment.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:intl/intl.dart';

/// Tela de Prontuário Eletrônico.
/// Centraliza Odontograma, Evolução Clínica, Anamnese e Exames.
class ProntuarioScreen extends ConsumerStatefulWidget {
  final Patient patient;

  const ProntuarioScreen({super.key, required this.patient});

  @override
  ConsumerState<ProntuarioScreen> createState() => _ProntuarioScreenState();
}

class _ProntuarioScreenState extends ConsumerState<ProntuarioScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.patient.fullName),
            Text(
              'CPF: ${widget.patient.cpf} • ID: ${widget.patient.id.substring(0, 8)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Ações do Prontuário',
            onSelected: (value) => _handleAction(value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'anamnese', child: ListTile(leading: Icon(Icons.history_outlined), title: Text('Ficha de Anamnese'))),
              const PopupMenuItem(value: 'plano', child: ListTile(leading: Icon(Icons.assignment_outlined), title: Text('Plano de Tratamento'))),
              const PopupMenuDivider(),
              const PopupMenuItem(value: 'receita', child: ListTile(leading: Icon(Icons.description_outlined), title: Text('Emitir Receita'))),
              const PopupMenuItem(value: 'atestado', child: ListTile(leading: Icon(Icons.assignment_outlined), title: Text('Emitir Atestado'))),
            ],
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Odontograma', icon: Icon(Icons.tooth_outlined)),
            Tab(text: 'Evolução Clínica', icon: Icon(Icons.history_edu)),
            Tab(text: 'Exames & Fotos', icon: Icon(Icons.photo_library_outlined)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          OdontogramWidget(patientId: widget.patient.id),
          _buildEvolutionTab(),
          _buildExamsTab(),
        ],
      ),
    );
  }

  void _handleAction(String action) {
    switch (action) {
      case 'anamnese':
        context.push('/dashboard/patients/prontuario/anamnese?patientId=${widget.patient.id}&patientName=${widget.patient.fullName}');
        break;
      case 'plano':
        context.push('/dashboard/patients/prontuario/treatment-plan?patientId=${widget.patient.id}&patientName=${widget.patient.fullName}');
        break;
      case 'receita':
        context.push('/dashboard/patients/prontuario/prescription?patientId=${widget.patient.id}');
        break;
      case 'atestado':
        context.push('/dashboard/patients/prontuario/certificate?patientId=${widget.patient.id}&patientName=${widget.patient.fullName}');
        break;
    }
  }

  Widget _buildEvolutionTab() {
    final evolutionsAsync = ref.watch(evolutionViewModelProvider(widget.patient.id));
    final currentUser = ref.watch(authViewModelProvider).user;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: evolutionsAsync.when(
              data: (evolutions) => evolutions.isEmpty 
                  ? const Center(child: Text('Nenhuma evolução clínica registrada.'))
                  : ListView.builder(
                      itemCount: evolutions.length,
                      itemBuilder: (context, index) {
                        final evolution = evolutions[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${DateFormat('dd/MM/yyyy HH:mm').format(evolution.createdAt)} - ${evolution.clinicName ?? "Clínica Geral"}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    _buildStatusTag(evolution.isSignedByProfessor),
                                  ],
                                ),
                                const Divider(),
                                Text(evolution.description),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.person_outline, size: 14, color: Colors.blueGrey),
                                    const SizedBox(width: 4),
                                    Text('Prof: ${evolution.professorName}', style: const TextStyle(fontSize: 12, color: Colors.blueGrey)),
                                    const Spacer(),
                                    Text('Aluno: ${evolution.studentName}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                                  ],
                                ),
                                if (!evolution.isSignedByProfessor && currentUser?.role == UserRole.professor)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12.0),
                                    child: FilledButton.icon(
                                      onPressed: () => ref.read(evolutionViewModelProvider(widget.patient.id).notifier).signEvolution(evolution.id),
                                      icon: const Icon(Icons.verified_user_outlined),
                                      label: const Text('Assinar Evolução'),
                                      style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 40)),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Erro ao carregar histórico: $err')),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => _showAddEvolutionDialog(),
              icon: const Icon(Icons.add),
              label: const Text('Nova Evolução Clínica'),
              style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusTag(bool signed) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: signed ? Colors.green.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        signed ? 'Assinado' : 'Pendente',
        style: TextStyle(color: signed ? Colors.green : Colors.orange, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildExamsTab() {
    final attachmentsAsync = ref.watch(attachmentViewModelProvider(widget.patient.id));

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showUploadOptions(),
        label: const Text('Anexar Exame'),
        icon: const Icon(Icons.upload_file),
      ),
      body: attachmentsAsync.when(
        data: (attachments) => attachments.isEmpty
            ? const Center(child: Text('Nenhuma radiografia ou foto disponível.'))
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.8,
                ),
                itemCount: attachments.length,
                itemBuilder: (context, index) {
                  final attachment = attachments[index];
                  return _buildAttachmentCard(attachment);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erro: $err')),
      ),
    );
  }

  Widget _buildAttachmentCard(Attachment attachment) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _showAttachmentFullScreen(attachment),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                attachment.url,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    attachment.type.name.toUpperCase(),
                    style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                  Text(
                    DateFormat('dd/MM/yy').format(attachment.date),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddEvolutionDialog() {
    final controller = TextEditingController();
    String? selectedProfessorId;
    final professorsAsync = ref.read(userManagementViewModelProvider);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nova Evolução Clínica'),
        content: StatefulBuilder(
          builder: (context, setState) => SizedBox(
            width: 600,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                professorsAsync.when(
                  data: (users) {
                    final professors = users.where((u) => u.role == UserRole.professor).toList();
                    return DropdownButtonFormField<String>(
                      decoration: const InputDecoration(labelText: 'Professor Supervisor'),
                      items: professors.map((p) => DropdownMenuItem(value: p.id, child: Text(p.name))).toList(),
                      onChanged: (val) => setState(() => selectedProfessorId = val),
                    );
                  },
                  loading: () => const LinearProgressIndicator(),
                  error: (_, __) => const Text('Erro ao carregar supervisores'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: controller,
                  maxLines: 10,
                  decoration: const InputDecoration(
                    hintText: 'Descreva detalhadamente o atendimento...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          FilledButton(
            onPressed: () async {
              if (controller.text.isNotEmpty && selectedProfessorId != null) {
                await ref.read(evolutionViewModelProvider(widget.patient.id).notifier)
                    .addEvolution(controller.text, selectedProfessorId!);
                if (mounted) Navigator.pop(context);
              }
            },
            child: const Text('Salvar Evolução'),
          ),
        ],
      ),
    );
  }

  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Tirar Foto Clínica'),
              onTap: () {
                Navigator.pop(context);
                _handleImageUpload(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Carregar da Galeria'),
              onTap: () {
                Navigator.pop(context);
                _handleImageUpload(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleImageUpload(ImageSource source) async {
    final XFile? photo = await _picker.pickImage(
      source: source,
      imageQuality: 70, // Comprime para economizar banda e armazenamento
      maxWidth: 1920,
    );

    if (photo != null) {
      final type = await _selectAttachmentType();
      if (type != null && mounted) {
        await ref.read(attachmentViewModelProvider(widget.patient.id).notifier)
            .uploadFile(File(photo.path), type);
      }
    }
  }

  Future<AttachmentType?> _selectAttachmentType() async {
    return showDialog<AttachmentType>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Tipo de Anexo'),
        children: AttachmentType.values.map((type) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(context, type),
            child: Text(type.name.toUpperCase()),
          );
        }).toList(),
      ),
    );
  }

  void _showAttachmentFullScreen(Attachment attachment) {
    showDialog(
      context: context,
      builder: (context) => Dialog.fullscreen(
        child: Scaffold(
          appBar: AppBar(
            title: Text('${attachment.name} - ${DateFormat('dd/MM/yyyy').format(attachment.date)}'),
            actions: [
              IconButton(icon: const Icon(Icons.download), onPressed: () {}),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  ref.read(attachmentViewModelProvider(widget.patient.id).notifier).removeAttachment(attachment.id);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: InteractiveViewer(
            child: Center(
              child: Image.network(
                attachment.url,
                errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image, size: 64)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
