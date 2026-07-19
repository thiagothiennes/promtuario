import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinic.freezed.dart';
part 'clinic.g.dart';

// Nota: Procedure foi removido desta entidade para evitar dependência circular.
// Se precisar associar procedimentos a clínicas, faça isso via repositório ou serviço.

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
