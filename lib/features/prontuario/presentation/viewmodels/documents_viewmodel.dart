import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia documentos (atestados/receitas) gerados para o paciente.
class DocumentsViewModel extends StateNotifier<AsyncValue<List<String>>> {
  DocumentsViewModel(this.ref, String patientId) : super(const AsyncValue.loading()) {
    _fetchDocuments();
  }
  
  final Ref ref;
  
  Future<void> _fetchDocuments() async {
    // Implementar busca de documentos gerados no repositório
    state = const AsyncValue.data([]);
  }

  Future<void> refresh() async => _fetchDocuments();
}

final documentsViewModelProvider = StateNotifierProvider.family<DocumentsViewModel, AsyncValue<List<String>>, String>((ref, patientId) {
  return DocumentsViewModel(ref, patientId);
});
