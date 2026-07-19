import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia o prontuário eletrônico do paciente.
class ProntuarioViewModel extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  ProntuarioViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchProntuario();
  }

  final Ref ref;

  Future<Map<String, dynamic>> _fetchProntuario({String? patientId}) async {
    // Implementar lógica de busca se necessário
    return {};
  }

  /// Recarrega o prontuário.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProntuario());
  }

  /// Atualiza o prontuário.
  Future<void> updateProntuario(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return _fetchProntuario();
    });
  }
}

/// Provider para criar a instância do ProntuarioViewModel.
final prontuarioViewModelProvider = StateNotifierProvider<ProntuarioViewModel, AsyncValue<Map<String, dynamic>>>((ref) {
  return ProntuarioViewModel(ref);
});
