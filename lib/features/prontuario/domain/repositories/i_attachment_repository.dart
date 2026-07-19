import '../entities/attachment.dart';
import 'dart:io';

/// Contrato para gestão de anexos (Radiografias, Fotos, Documentos).
abstract class IAttachmentRepository {
  /// Faz o upload de um arquivo associado a um paciente.
  Future<Attachment> uploadAttachment(
      String patientId, File file, AttachmentType type,
      {String? description});

  /// Reenvia um anexo pendente sem adicionar uma entrada duplicada Ã  fila local.
  Future<bool> syncPendingAttachment(String attachmentId);

  /// Recupera a lista de anexos de um paciente.
  Future<List<Attachment>> getAttachments(String patientId);

  /// Remove um anexo.
  Future<void> deleteAttachment(String attachmentId);
}
