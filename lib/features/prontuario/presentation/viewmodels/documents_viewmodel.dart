import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia documentos (atestados/receitas) gerados para o paciente.
class DocumentsViewModel extends FamilyStateNotifier<AsyncValue<List<String>>, String> {
  DocumentsViewModel(this.ref) : super(const AsyncValue.loading());

  final Ref ref;
  late String _patientId;

  @override
  AsyncValue<List<String>> build(String arg) {
    _patientId = arg;
    _fetchDocuments();
    return const AsyncValue.loading();
  }

  Future<void> _fetchDocuments() async {
    // Implementar busca de documentos gerados no repositório
    state = const AsyncValue.data([]);
  }

  Future<void> refresh() async => _fetchDocuments();
}

final documentsViewModelProvider = StateNotifierProvider.family<DocumentsViewModel, AsyncValue<List<String>>, String>((ref, patientId) {
  final vm = DocumentsViewModel(ref);
  vm.build(patientId);
  return vm;
});
