import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/providers.dart';

/// Gerencia documentos anexados ao prontuário.
class DocumentsViewModel extends StateNotifier<AsyncValue<List<String>>> {
  DocumentsViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchDocuments();
  }

  final Ref ref;

  Future<List<String>> _fetchDocuments({String? patientId}) async {
    // TODO: Implementar repositório de documentos
    return [];
  }

  /// Recarrega os documentos.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchDocuments());
  }

  /// Adiciona um documento.
  Future<void> addDocument(String path) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar adição de documento
      return _fetchDocuments();
    });
  }
}

/// Provider para criar a instância do DocumentsViewModel.
final documentsViewModelProvider = StateNotifierProvider<DocumentsViewModel, AsyncValue<List<String>>>((ref) {
  return DocumentsViewModel(ref);
});
