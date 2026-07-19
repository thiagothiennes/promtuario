import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia o prontuário eletrônico do paciente.
class ProntuarioViewModel extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  ProntuarioViewModel(this.ref, this.patientId) : super(const AsyncValue.loading()) {
    _fetchProntuario();
  }

  final Ref ref;
  final String patientId;

  Future<void> _fetchProntuario() async {
    // Implementar busca se necessário
    state = const AsyncValue.data({});
  }

  Future<void> refresh() async => _fetchProntuario();

  Future<void> updateProntuario(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return {};
    });
  }
}

final prontuarioViewModelProvider = StateNotifierProvider.family<ProntuarioViewModel, AsyncValue<Map<String, dynamic>>, String>((ref, patientId) {
  return ProntuarioViewModel(ref, patientId);
});
