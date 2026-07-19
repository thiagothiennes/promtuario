import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment.freezed.dart';
part 'attachment.g.dart';

@freezed
class Attachment with _$Attachment {
  const factory Attachment({
    required String id,
    required String patientId,
    required String name,
    required AttachmentType type,
    required String url,
    required DateTime date,
    required String uploadedBy,
    String? description,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) => _$AttachmentFromJson(json);
}

enum AttachmentType {
  @JsonValue('radiography') radiography,
  @JsonValue('photo') photo,
  @JsonValue('document') document,
  @JsonValue('exam') exam,
}
