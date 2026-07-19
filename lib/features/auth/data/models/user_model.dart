import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    required String role,
    @Default(true) bool isActive,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}

extension UserModelExtension on UserModel {
  /// Converte o model da camada de dados para a entidade da camada de domínio.
  User toEntity() {
    return User(
      id: id,
      name: name,
      email: email,
      role: UserRole.values.firstWhere(
        (e) => e.name == role.toLowerCase(),
        orElse: () => UserRole.aluno,
      ),
      isActive: isActive,
    );
  }
}
