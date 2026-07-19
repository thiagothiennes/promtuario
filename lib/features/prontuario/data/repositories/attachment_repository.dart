import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drift/drift.dart';
import 'package:promt/core/database/local_database.dart';
import 'package:promt/core/network/api_client.dart';
import 'package:promt/features/prontuario/domain/entities/attachment.dart';
import 'package:promt/features/prontuario/domain/repositories/i_attachment_repository.dart';

/// RepositÃ³rio de anexos com fila local para operaÃ§Ãµes offline-first.
class AttachmentRepository implements IAttachmentRepository {
  AttachmentRepository(this._apiClient, this._localDb);

  final ApiClient _apiClient;
  final AppDatabase _localDb;

  @override
  Future<Attachment> uploadAttachment(
    String patientId,
    File file,
    AttachmentType type, {
    String? description,
  }) async {
    try {
      return await _upload(patientId, file, type, description: description);
    } on DioException {
      return _enqueue(patientId, file, type, description);
    }
  }

  @override
  Future<bool> syncPendingAttachment(String attachmentId) async {
    final queued = await (_localDb.select(_localDb.attachmentsLocal)
          ..where((table) => table.id.equals(attachmentId)))
        .getSingleOrNull();
    if (queued == null) return true;

    final file = File(queued.localPath);
    if (!await file.exists()) return false;

    try {
      final type = AttachmentType.values.byName(queued.type);
      await _upload(queued.patientId, file, type,
          description: queued.description);
      await (_localDb.delete(_localDb.attachmentsLocal)
            ..where((table) => table.id.equals(attachmentId)))
          .go();
      return true;
    } on ArgumentError {
      return false;
    } on DioException {
      return false;
    }
  }

  @override
  Future<List<Attachment>> getAttachments(String patientId) async {
    try {
      final response =
          await _apiClient.instance.get('/anexos/paciente/$patientId');
      final data = response.data as List<dynamic>? ?? const <dynamic>[];
      final remote = data
          .map((json) =>
              _mapJsonToEntity(Map<String, dynamic>.from(json as Map)))
          .toList();
      return [...remote, ...await _getPendingAttachments(patientId)];
    } on DioException {
      return _getPendingAttachments(patientId);
    }
  }

  @override
  Future<void> deleteAttachment(String attachmentId) async {
    try {
      await _apiClient.instance.delete('/anexos/$attachmentId');
    } finally {
      await (_localDb.delete(_localDb.attachmentsLocal)
            ..where((table) => table.id.equals(attachmentId)))
          .go();
    }
  }

  Future<Attachment> _upload(
    String patientId,
    File file,
    AttachmentType type, {
    String? description,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: file.uri.pathSegments.last),
      'tipo': type.name,
      if (description != null) 'description': description,
    });
    final response = await _apiClient.instance
        .post('/anexos/upload/$patientId', data: formData);
    return _mapJsonToEntity(Map<String, dynamic>.from(response.data as Map));
  }

  Future<Attachment> _enqueue(
    String patientId,
    File file,
    AttachmentType type,
    String? description,
  ) async {
    final id = DateTime.now().microsecondsSinceEpoch.toString();
    final createdAt = DateTime.now();
    await _localDb.into(_localDb.attachmentsLocal).insert(
          AttachmentsLocalCompanion.insert(
            id: id,
            patientId: patientId,
            localPath: file.path,
            type: type.name,
            description: Value(description),
            createdAt: createdAt,
            isSynced: const Value(false),
          ),
        );
    return Attachment(
      id: id,
      patientId: patientId,
      name: file.uri.pathSegments.last,
      type: type,
      url: file.path,
      date: createdAt,
      uploadedBy: 'local-pending-upload',
      description: description,
    );
  }

  Future<List<Attachment>> _getPendingAttachments(String patientId) async {
    final rows = await (_localDb.select(_localDb.attachmentsLocal)
          ..where((table) => table.patientId.equals(patientId)))
        .get();
    return rows
        .map((row) => Attachment(
              id: row.id,
              patientId: row.patientId,
              name: File(row.localPath).uri.pathSegments.last,
              type: AttachmentType.values.byName(row.type),
              url: row.localPath,
              date: row.createdAt,
              uploadedBy: 'local-pending-upload',
              description: row.description,
            ))
        .toList();
  }

  Attachment _mapJsonToEntity(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'].toString(),
      patientId: (json['pacienteId'] ?? json['patientId']).toString(),
      name: (json['nome'] ?? json['name']).toString(),
      type: AttachmentType.values.firstWhere(
        (value) =>
            value.name ==
            (json['tipo'] ?? json['type']).toString().toLowerCase(),
        orElse: () => AttachmentType.document,
      ),
      url: json['url'].toString(),
      date: DateTime.parse((json['criadoEm'] ?? json['date']).toString()),
      uploadedBy: (json['criadoPorId'] ?? json['uploadedBy']).toString(),
      description: (json['descricao'] ?? json['description'])?.toString(),
    );
  }
}
