import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/evolution.dart';
import '../../../core/providers/providers.dart';

/// Gerencia as evoluções dos pacientes.
class EvolutionViewModel extends StateNotifier<AsyncValue<List<Evolution>>> {
  EvolutionViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchEvolutions();
  }

  final Ref ref;

  Future<List<Evolution>> _fetchEvolutions({String? patientId}) async {
    // TODO: Implementar repositório de evoluções
    return [];
  }

  /// Recarrega as evoluções.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchEvolutions());
  }

  /// Cria uma nova evolução.
  Future<void> createEvolution(Evolution evolution) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar criação de evolução
      return _fetchEvolutions();
    });
  }
}

/// Provider para criar a instância do EvolutionViewModel.
final evolutionViewModelProvider = StateNotifierProvider<EvolutionViewModel, AsyncValue<List<Evolution>>>((ref) {
  return EvolutionViewModel(ref);
});
