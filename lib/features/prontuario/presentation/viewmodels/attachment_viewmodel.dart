import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/core/providers/providers.dart';
import 'package:promt/features/prontuario/domain/entities/attachment.dart';

/// Gerencia anexos do prontuário (imagens, exames, etc).
class AttachmentViewModel extends FamilyStateNotifier<AsyncValue<List<Attachment>>, String> {
  AttachmentViewModel(this.ref) : super(const AsyncValue.loading());

  final Ref ref;
  late String _patientId;

  @override
  AsyncValue<List<Attachment>> build(String arg) {
    _patientId = arg;
    _fetchAttachments();
    return const AsyncValue.loading();
  }

  Future<void> _fetchAttachments() async {
    state = await AsyncValue.guard(() => 
      ref.read(attachmentRepositoryProvider).getAttachments(_patientId)
    );
  }

  Future<void> refresh() async => _fetchAttachments();

  Future<void> uploadFile(File file, AttachmentType type, {String? description}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(attachmentRepositoryProvider).uploadAttachment(
        _patientId, 
        file, 
        type, 
        description: description
      );
      final list = await ref.read(attachmentRepositoryProvider).getAttachments(_patientId);
      return list;
    });
  }

  Future<void> removeAttachment(String id) async {
    state = await AsyncValue.guard(() async {
      await ref.read(attachmentRepositoryProvider).deleteAttachment(id);
      final list = await ref.read(attachmentRepositoryProvider).getAttachments(_patientId);
      return list;
    });
  }
}

final attachmentViewModelProvider = StateNotifierProvider.family<AttachmentViewModel, AsyncValue<List<Attachment>>, String>((ref, patientId) {
  final vm = AttachmentViewModel(ref);
  vm.build(patientId);
  return vm;
});
