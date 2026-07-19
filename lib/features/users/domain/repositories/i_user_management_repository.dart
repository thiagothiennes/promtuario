import '../../../auth/domain/entities/user.dart';

/// Contrato para o Repositório de Gestão de Usuários.
/// Define operações administrativas de controle de acesso (RBAC).
abstract class IUserManagementRepository {
  /// Recupera a lista de usuários com suporte a filtros por perfil e busca.
  Future<List<User>> getUsers({UserRole? role, String? query});

  /// Cria um novo colaborador no sistema.
  Future<void> createUser(User user, String password);

  /// Ativa ou desativa um usuário (Bloqueio de acesso).
  Future<void> toggleUserStatus(String userId, bool active);

  /// Altera o nível de permissão de um usuário.
  Future<void> updateUserRole(String userId, UserRole role);
}
