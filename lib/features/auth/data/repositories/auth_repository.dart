import 'package:promt/core/network/api_client.dart';
import 'package:promt/core/security/storage_service.dart';
import 'package:promt/features/auth/domain/entities/user.dart';
import 'package:promt/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:promt/features/auth/data/models/user_model.dart';

/// Implementação concreta do repositório de autenticação.
class AuthRepository implements IAuthRepository {
  final ApiClient _apiClient;
  final StorageService _storage;

  AuthRepository(this._apiClient, this._storage);

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await _apiClient.instance.post('/auth/login', data: {
        'email': email,
        'password': password,
      });

      final accessToken = response.data['accessToken'];
      final refreshToken = response.data['refreshToken'];
      final userModel = UserModel.fromJson(response.data['user']);

      await _storage.saveTokens(access: accessToken, refresh: refreshToken);

      return userModel.toEntity();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _apiClient.instance.post('/auth/logout');
    } finally {
      await _storage.clearSession();
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    final token = await _storage.getAccessToken();
    if (token == null) return null;

    try {
      final response = await _apiClient.instance.get('/auth/me');
      return UserModel.fromJson(response.data).toEntity();
    } catch (_) {
      return null;
    }
  }

  @override
  Future<String?> refreshToken() async {
    final refresh = await _storage.getRefreshToken();
    if (refresh == null) return null;

    try {
      final response = await _apiClient.instance.post('/auth/refresh', data: {
        'refreshToken': refresh,
      });
      
      final newAccess = response.data['accessToken'];
      final newRefresh = response.data['refreshToken'];
      
      await _storage.saveTokens(access: newAccess, refresh: newRefresh);
      return newAccess;
    } catch (e) {
      await _storage.clearSession();
      return null;
    }
  }
}
