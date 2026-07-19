import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/prontuario/domain/entities/evolution.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia as evoluções clínicas dos pacientes.
class EvolutionViewModel extends StateNotifier<AsyncValue<List<Evolution>>> {
  EvolutionViewModel(this.ref, this.patientId) : super(const AsyncValue.loading()) {
    _fetchEvolutions();
  }

  final Ref ref;
  final String patientId;

  Future<void> _fetchEvolutions() async {
    state = await AsyncValue.guard(() => 
      ref.read(prontuarioRepositoryProvider).getEvolutions(patientId)
    );
  }

  Future<void> refresh() async => _fetchEvolutions();

  /// Adiciona uma nova evolução clínica.
  Future<void> addEvolution(String description, String professorId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).addEvolution(patientId, description, professorId);
      final list = await ref.read(prontuarioRepositoryProvider).getEvolutions(patientId);
      return list;
    });
  }

  /// Assina uma evolução (Ação exclusiva do professor).
  Future<void> signEvolution(String evolutionId) async {
    state = await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).signEvolution(evolutionId);
      final list = await ref.read(prontuarioRepositoryProvider).getEvolutions(patientId);
      return list;
    });
  }
}

/// Provider para criar a instância do EvolutionViewModel por paciente.
final evolutionViewModelProvider = StateNotifierProvider.family<EvolutionViewModel, AsyncValue<List<Evolution>>, String>((ref, patientId) {
  return EvolutionViewModel(ref, patientId);
});
