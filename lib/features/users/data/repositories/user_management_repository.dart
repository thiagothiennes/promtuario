import 'package:drift/drift.dart';
import 'package:promt/core/network/api_client.dart';
import 'package:promt/core/database/local_database.dart';
import 'package:promt/features/auth/data/models/user_model.dart';
import 'package:promt/features/auth/domain/entities/user.dart';
import 'package:promt/features/users/domain/repositories/i_user_management_repository.dart';

/// Implementação do Repositório de Gestão de Usuários com suporte a Cache Offline.
class UserManagementRepository implements IUserManagementRepository {
  final ApiClient _apiClient;
  final AppDatabase _localDb;

  UserManagementRepository(this._apiClient, this._localDb);

  @override
  Future<List<User>> getUsers({UserRole? role, String? query}) async {
    try {
      final response = await _apiClient.instance.get('/users', queryParameters: {
        if (role != null) 'role': role.name,
        if (query != null) 'search': query,
      });

      final data = response.data as List;
      final users = data.map((json) => UserModel.fromJson(json as Map<String, dynamic>).toEntity()).toList();

      // Atualiza o cache local
      _updateLocalCache(users);

      return users;
    } catch (e) {
      // Offline: Busca no banco local
      final localQuery = _localDb.select(_localDb.usersLocal);
      final results = await localQuery.get();
      
      return results.map((row) => User(
        id: row.id,
        name: row.name,
        email: row.email,
        role: UserRole.values.firstWhere((e) => e.name == row.role, orElse: () => UserRole.aluno),
        isActive: row.isActive,
      )).toList();
    }
  }

  @override
  Future<void> createUser(User user, String password) async {
    await _apiClient.instance.post('/users', data: {
      'name': user.name,
      'email': user.email,
      'password': password,
      'role': user.role.name,
    });
  }

  @override
  Future<void> toggleUserStatus(String userId, bool active) async {
    await _apiClient.instance.patch('/users/$userId/status', data: {'active': active});
  }

  @override
  Future<void> updateUserRole(String userId, UserRole role) async {
    await _apiClient.instance.patch('/users/$userId/role', data: {'role': role.name});
  }

  void _updateLocalCache(List<User> users) async {
    for (var user in users) {
      await _localDb.into(_localDb.usersLocal).insertOnConflictUpdate(
        UsersLocalCompanion.insert(
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role.name,
          isActive: Value(user.isActive),
        ),
      );
    }
  }
}
