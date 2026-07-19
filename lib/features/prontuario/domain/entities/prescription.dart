import 'package:freezed_annotation/freezed_annotation.dart';

part 'prescription.freezed.dart';
part 'prescription.g.dart';

@freezed
class Prescription with _$Prescription {
  const factory Prescription({
    required String id,
    required String patientId,
    required String doctorId,
    required String doctorName,
    required DateTime date,
    required List<PrescriptionItem> items,
    String? observations,
    required String clinicId,
  }) = _Prescription;

  factory Prescription.fromJson(Map<String, dynamic> json) => _$PrescriptionFromJson(json);
}

@freezed
class PrescriptionItem with _$PrescriptionItem {
  const factory PrescriptionItem({
    required String medicineName,
    required String dosage,
    required String instructions,
  }) = _PrescriptionItem;

  factory PrescriptionItem.fromJson(Map<String, dynamic> json) => _$PrescriptionItemFromJson(json);
}

@freezed
class MedicalCertificate with _$MedicalCertificate {
  const factory MedicalCertificate({
    required String id,
    required String patientId,
    required String doctorId,
    required String doctorName,
    required DateTime date,
    required String content,
    required int daysOfRest,
    required String cid,
    required String clinicId,
  }) = _MedicalCertificate;

  factory MedicalCertificate.fromJson(Map<String, dynamic> json) => _$MedicalCertificateFromJson(json);
}
