import 'package:freezed_annotation/freezed_annotation.dart';

part 'patient.freezed.dart';

@freezed
class Patient with _$Patient {
  const factory Patient({
    required String id,
    required String fullName,
    required String cpf,
    required DateTime birthDate,
    String? email,
    String? phone,
    String? gender,
    PatientAddress? address,
    required DateTime createdAt,
    DateTime? updatedAt,
    @Default(false) bool lgpdConsent,
    @Default(true) bool isSynced, // Adicionado para feedback visual de sincronização
  }) = _Patient;
}

@freezed
class PatientAddress with _$PatientAddress {
  const factory PatientAddress({
    required String street,
    required String number,
    String? complement,
    required String neighborhood,
    required String city,
    required String state,
    required String zipCode,
  }) = _PatientAddress;
}
