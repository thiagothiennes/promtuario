import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/prontuario/domain/entities/anamnese.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia as anamneses dos pacientes.
class AnamneseViewModel extends StateNotifier<AsyncValue<List<Anamnese>>> {
  AnamneseViewModel(this.ref, this.patientId) : super(const AsyncValue.loading()) {
    _fetchAnamneses();
  }

  final Ref ref;
  final String patientId;

  Future<void> _fetchAnamneses() async {
    state = await AsyncValue.guard(() => 
      ref.read(prontuarioRepositoryProvider).getAnamneses(patientId)
    );
  }

  Future<void> refresh() async => _fetchAnamneses();

  Future<void> saveAnamnese(Map<String, dynamic> responses) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).saveAnamnese(patientId, responses);
      final list = await ref.read(prontuarioRepositoryProvider).getAnamneses(patientId);
      return list;
    });
  }
}

final anamneseViewModelProvider = StateNotifierProvider.family<AnamneseViewModel, AsyncValue<List<Anamnese>>, String>((ref, patientId) {
  return AnamneseViewModel(ref, patientId);
});
