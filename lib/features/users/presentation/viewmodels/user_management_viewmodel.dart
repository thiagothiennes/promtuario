import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/providers.dart';
import '../../domain/entities/user.dart';

/// Gerencia o cadastro e administração de usuários.
class UserManagementViewModel extends StateNotifier<AsyncValue<List<User>>> {
  UserManagementViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchUsers();
  }

  final Ref ref;

  Future<List<User>> _fetchUsers() async {
    final repository = ref.read(authRepositoryProvider);
    // TODO: Implementar método para listar todos os usuários
    return [];
  }

  /// Recarrega a lista de usuários.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchUsers());
  }

  /// Cria um novo usuário.
  Future<void> createUser(User user) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar criação de usuário
      return _fetchUsers();
    });
  }

  /// Atualiza um usuário existente.
  Future<void> updateUser(User user) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar atualização de usuário
      return _fetchUsers();
    });
  }

  /// Remove um usuário.
  Future<void> deleteUser(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar remoção de usuário
      return _fetchUsers();
    });
  }
}

/// Provider para criar a instância do UserManagementViewModel.
final userManagementViewModelProvider = StateNotifierProvider<UserManagementViewModel, AsyncValue<List<User>>>((ref) {
  return UserManagementViewModel(ref);
});
