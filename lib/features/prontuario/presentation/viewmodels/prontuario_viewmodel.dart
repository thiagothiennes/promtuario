import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia o prontuário eletrônico do paciente.
class ProntuarioViewModel extends FamilyStateNotifier<AsyncValue<Map<String, dynamic>>, String> {
  ProntuarioViewModel(this.ref) : super(const AsyncValue.loading());

  final Ref ref;
  late String _patientId;

  @override
  AsyncValue<Map<String, dynamic>> build(String arg) {
    _patientId = arg;
    _fetchProntuario();
    return const AsyncValue.loading();
  }

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
  final vm = ProntuarioViewModel(ref);
  vm.build(patientId);
  return vm;
});
