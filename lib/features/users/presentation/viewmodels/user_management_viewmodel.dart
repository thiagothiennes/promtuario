import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/core/providers/providers.dart';
import 'package:promt/features/auth/domain/entities/user.dart';

/// Gerencia o cadastro e administração de usuários.
class UserManagementViewModel extends StateNotifier<AsyncValue<List<User>>> {
  UserManagementViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchUsers();
  }

  final Ref ref;

  Future<List<User>> _fetchUsers() async {
    final repository = ref.read(userManagementRepositoryProvider);
    return await repository.getAllUsers();
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
      await ref.read(userManagementRepositoryProvider).createUser(user);
      return _fetchUsers();
    });
  }

  /// Atualiza um usuário existente.
  Future<void> updateUser(User user) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(userManagementRepositoryProvider).updateUser(user);
      return _fetchUsers();
    });
  }
}

/// Provider para criar a instância do UserManagementViewModel.
final userManagementViewModelProvider = StateNotifierProvider<UserManagementViewModel, AsyncValue<List<User>>>((ref) {
  return UserManagementViewModel(ref);
});
