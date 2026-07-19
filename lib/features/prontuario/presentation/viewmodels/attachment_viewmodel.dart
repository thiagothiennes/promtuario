import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/providers.dart';

/// Gerencia anexos do prontuário (imagens, exames, etc).
class AttachmentViewModel extends StateNotifier<AsyncValue<List<String>>> {
  AttachmentViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchAttachments();
  }

  final Ref ref;

  Future<List<String>> _fetchAttachments({String? patientId}) async {
    // TODO: Implementar repositório de anexos
    return [];
  }

  /// Recarrega os anexos.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchAttachments());
  }

  /// Adiciona um anexo.
  Future<void> addAttachment(String path) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar adição de anexo
      return _fetchAttachments();
    });
  }

  /// Remove um anexo.
  Future<void> removeAttachment(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar remoção de anexo
      return _fetchAttachments();
    });
  }
}

/// Provider para criar a instância do AttachmentViewModel.
final attachmentViewModelProvider = StateNotifierProvider<AttachmentViewModel, AsyncValue<List<String>>>((ref) {
  return AttachmentViewModel(ref);
});
