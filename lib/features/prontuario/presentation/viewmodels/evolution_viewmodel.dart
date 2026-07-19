import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/prontuario/domain/entities/evolution.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia as evoluções clínicas dos pacientes.
class EvolutionViewModel extends FamilyStateNotifier<AsyncValue<List<Evolution>>, String> {
  EvolutionViewModel(this.ref) : super(const AsyncValue.loading());

  final Ref ref;
  late String _patientId;

  @override
  AsyncValue<List<Evolution>> build(String arg) {
    _patientId = arg;
    _fetchEvolutions();
    return const AsyncValue.loading();
  }

  Future<void> _fetchEvolutions() async {
    state = await AsyncValue.guard(() => 
      ref.read(prontuarioRepositoryProvider).getEvolutions(_patientId)
    );
  }

  Future<void> refresh() async => _fetchEvolutions();

  /// Adiciona uma nova evolução clínica.
  Future<void> addEvolution(String description, String professorId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).addEvolution(_patientId, description, professorId);
      final list = await ref.read(prontuarioRepositoryProvider).getEvolutions(_patientId);
      return list;
    });
  }

  /// Assina uma evolução (Ação exclusiva do professor).
  Future<void> signEvolution(String evolutionId) async {
    state = await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).signEvolution(evolutionId);
      final list = await ref.read(prontuarioRepositoryProvider).getEvolutions(_patientId);
      return list;
    });
  }
}

/// Provider para criar a instância do EvolutionViewModel por paciente.
final evolutionViewModelProvider = StateNotifierProvider.family<EvolutionViewModel, AsyncValue<List<Evolution>>, String>((ref, patientId) {
  final vm = EvolutionViewModel(ref);
  vm.build(patientId);
  return vm;
});
