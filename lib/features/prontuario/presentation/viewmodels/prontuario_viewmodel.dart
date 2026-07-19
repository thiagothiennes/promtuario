import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/providers.dart';

/// Gerencia o prontuário eletrônico do paciente.
class ProntuarioViewModel extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  ProntuarioViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchProntuario();
  }

  final Ref ref;

  Future<Map<String, dynamic>> _fetchProntuario({String? patientId}) async {
    // TODO: Implementar repositório de prontuários
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
      // TODO: Implementar atualização de prontuário
      return _fetchProntuario();
    });
  }
}

/// Provider para criar a instância do ProntuarioViewModel.
final prontuarioViewModelProvider = StateNotifierProvider<ProntuarioViewModel, AsyncValue<Map<String, dynamic>>>((ref) {
  return ProntuarioViewModel(ref);
});
