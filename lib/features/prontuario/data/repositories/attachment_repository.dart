import 'dart:io';
import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import '../../../core/network/api_client.dart';
import '../../../core/database/local_database.dart';
import '../../domain/entities/attachment.dart';
import '../../domain/repositories/i_attachment_repository.dart';

/// Implementação do repositório de anexos com suporte offline.
class AttachmentRepository implements IAttachmentRepository {
  final ApiClient _apiClient;
  final AppDatabase _localDb;

  AttachmentRepository(this._apiClient, this._localDb);

  @override
  Future<Attachment> uploadAttachment(
    String patientId,
    File file,
    AttachmentType type, {
    String? description,
  }) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path, filename: file.path.split('/').last),
        'tipo': type.name,
        if (description != null) 'description': description,
      });

      final response = await _apiClient.instance.post(
        '/anexos/upload/$patientId',
        data: formData,
      );

      final attachment = _mapJsonToEntity(response.data);
      return attachment;
    } catch (e) {
      // Falha na rede: Registra na fila local para o SyncService tentar depois
      final id = DateTime.now().millisecondsSinceEpoch.toString();
      await _localDb.into(_localDb.attachmentsLocal).insert(
            AttachmentsLocalCompanion.insert(
              id: id,
              patientId: patientId,
              localPath: file.path,
              type: type.name,
              description: Value(description),
              createdAt: DateTime.now(),
              isSynced: const Value(false),
            ),
          );
      
      // Retorna um objeto temporário para a UI
      return Attachment(
        id: id,
        patientId: patientId,
        name: file.path.split('/').last,
        type: type,
        url: '', // Sem URL pois ainda não subiu
        date: DateTime.now(),
        uploadedBy: 'me',
        description: description,
      );
    }
  }

  @override
  Future<List<Attachment>> getAttachments(String patientId) async {
    try {
      final response = await _apiClient.instance.get('/anexos/paciente/$patientId');
      final List<dynamic> data = response.data ?? [];
      return data.map((json) => _mapJsonToEntity(json)).toList();
    } catch (e) {
      // Offline: Busca anexos que foram salvos localmente e ainda não subiram
      final results = await (_localDb.select(_localDb.attachmentsLocal)
            ..where((t) => t.patientId.equals(patientId)))
          .get();
      
      return results.map((row) => Attachment(
        id: row.id,
        patientId: row.patientId,
        name: row.localPath.split('/').last,
        type: AttachmentType.values.firstWhere((e) => e.name == row.type),
        url: row.localPath, // Usa o path local como URL temporária
        date: row.createdAt,
        uploadedBy: 'me',
        description: row.description,
      )).toList();
    }
  }

  @override
  Future<void> deleteAttachment(String attachmentId) async {
    try {
      await _apiClient.instance.delete('/anexos/$attachmentId');
    } finally {
      // Tenta remover do banco local também
      await (_localDb.delete(_localDb.attachmentsLocal)..where((t) => t.id.equals(attachmentId))).go();
    }
  }

  Attachment _mapJsonToEntity(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      patientId: json['pacienteId'],
      name: json['nome'],
      type: AttachmentType.values.firstWhere(
        (e) => e.name == json['tipo'].toString().toLowerCase(),
        orElse: () => AttachmentType.document,
      ),
      url: json['url'],
      date: DateTime.parse(json['criadoEm'] ?? json['data'] ?? DateTime.now().toIso8601String()),
      uploadedBy: json['criadoPorId'],
      description: json['descricao'],
    );
  }
}
