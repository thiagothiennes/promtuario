import 'package:freezed_annotation/freezed_annotation.dart';

part 'appointment.freezed.dart';
part 'appointment.g.dart';

@freezed
class Appointment with _$Appointment {
  const factory Appointment({
    required String id,
    required String patientId,
    required String patientName,
    required String doctorId,
    required String doctorName,
    required DateTime startTime,
    required DateTime endTime,
    required AppointmentStatus status,
    String? procedureName,
    String? notes,
    required String clinicId,
  }) = _Appointment;

  factory Appointment.fromJson(Map<String, dynamic> json) => _$AppointmentFromJson(json);

  // Adicionado para permitir a conversão do objeto para JSON no repositório
  Map<String, dynamic> toJson() => _$$AppointmentImplToJson(this as _$AppointmentImpl);
}

enum AppointmentStatus {
  scheduled,
  confirmed,
  inProgress,
  completed,
  cancelled,
  missed;

  String get displayName {
    return switch (this) {
      scheduled => 'Agendado',
      confirmed => 'Confirmado',
      inProgress => 'Em Atendimento',
      completed => 'Finalizado',
      cancelled => 'Cancelado',
      missed => 'Faltou',
    };
  }
}
