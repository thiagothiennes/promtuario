import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    required UserRole role,
    @Default(true) bool isActive,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

enum UserRole {
  @JsonValue('admin') admin,
  @JsonValue('coordenador') coordenador,
  @JsonValue('professor') professor,
  @JsonValue('aluno') aluno,
  @JsonValue('recepcionista') recepcionista,
  @JsonValue('secretaria') secretaria;

  String get displayName {
    return switch (this) {
      admin => 'Administrador',
      coordenador => 'Coordenador',
      professor => 'Professor',
      aluno => 'Aluno',
      recepcionista => 'Recepcionista',
      secretaria => 'Secretaria',
    };
  }
}
