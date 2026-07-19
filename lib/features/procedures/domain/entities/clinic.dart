import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic.freezed.dart';
part 'clinic.g.dart';

@freezed
class Clinic with _$Clinic {
  const factory Clinic({
    required String id,
    required String name,
    required String description,
    @Default(true) bool isActive,
  }) = _Clinic;

  factory Clinic.fromJson(Map<String, dynamic> json) => _$ClinicFromJson(json);
}

@freezed
class Procedure with _$Procedure {
  const factory Procedure({
    required String id,
    required String clinicId,
    required String name,
    required double baseValue,
    @Default(true) bool isActive,
  }) = _Procedure;

  factory Procedure.fromJson(Map<String, dynamic> json) => _$ProcedureFromJson(json);
}
