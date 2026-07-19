import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/core/providers/providers.dart';
import 'package:promt/features/prontuario/domain/entities/attachment.dart';

/// Gerencia anexos do prontuário (imagens, exames, etc).
class AttachmentViewModel extends StateNotifier<AsyncValue<List<Attachment>>> {
  AttachmentViewModel(this.ref, this.patientId) : super(const AsyncValue.loading()) {
    _fetchAttachments();
  }

  final Ref ref;
  final String patientId;

  Future<void> _fetchAttachments() async {
    state = await AsyncValue.guard(() => 
      ref.read(attachmentRepositoryProvider).getAttachments(patientId)
    );
  }

  Future<void> refresh() async => _fetchAttachments();

  Future<void> uploadFile(File file, AttachmentType type, {String? description}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(attachmentRepositoryProvider).uploadAttachment(
        patientId, 
        file, 
        type, 
        description: description
      );
      final list = await ref.read(attachmentRepositoryProvider).getAttachments(patientId);
      return list;
    });
  }

  Future<void> removeAttachment(String id) async {
    state = await AsyncValue.guard(() async {
      await ref.read(attachmentRepositoryProvider).deleteAttachment(id);
      final list = await ref.read(attachmentRepositoryProvider).getAttachments(patientId);
      return list;
    });
  }
}

final attachmentViewModelProvider = StateNotifierProvider.family<AttachmentViewModel, AsyncValue<List<Attachment>>, String>((ref, patientId) {
  return AttachmentViewModel(ref, patientId);
});
