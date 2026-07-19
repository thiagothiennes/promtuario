import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/user.dart';
import '../../../core/providers/providers.dart';
import '../../../../core/network/realtime_service.dart';

part 'auth_viewmodel.g.dart';

/// Estado da autenticação.
class AuthState {
  final User? user;
  final bool isLoading;
  final String? errorMessage;
  final bool isInitialized;

  AuthState({
    this.user, 
    this.isLoading = false, 
    this.errorMessage,
    this.isInitialized = false,
  });

  AuthState copyWith({
    User? user, 
    bool? isLoading, 
    String? errorMessage,
    bool? isInitialized,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AuthState build() => AuthState();

  /// Verifica se existe uma sessão ativa (Token salvo).
  Future<void> checkAuth() async {
    final repository = ref.read(authRepositoryProvider);
    final user = await repository.getCurrentUser();
    
    if (user != null) {
      state = state.copyWith(user: user, isInitialized: true);
      await ref.read(realtimeServiceProvider).init();
    } else {
      state = state.copyWith(isInitialized: true);
    }
  }

  /// Realiza o login e registra o evento na auditoria.
  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.login(email, password);
      
      // Inicializa o tempo real
      await ref.read(realtimeServiceProvider).init();
      
      // Registra o evento de login para auditoria (LGPD)
      ref.read(auditRepositoryProvider).registerAccess(user.id, 'USER_LOGIN');
      
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false, 
        errorMessage: 'Falha na autenticação. Verifique suas credenciais.'
      );
    }
  }

  /// Realiza o logout e encerra os serviços de fundo.
  Future<void> logout() async {
    final user = state.user;
    if (user != null) {
      // Tenta registrar o logout antes de limpar a sessão
      await ref.read(auditRepositoryProvider).registerAccess(user.id, 'USER_LOGOUT');
    }

    final repository = ref.read(authRepositoryProvider);
    await ref.read(realtimeServiceProvider).stop();
    await repository.logout();

    state = AuthState(isInitialized: true);
  }
}
