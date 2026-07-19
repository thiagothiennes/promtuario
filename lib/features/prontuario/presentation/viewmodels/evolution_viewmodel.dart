import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/evolution.dart';
import '../../domain/repositories/i_prontuario_repository.dart';
import '../../../../core/providers/providers.dart';
import '../../../../core/network/realtime_service.dart';

part 'evolution_viewmodel.g.dart';

@riverpod
class EvolutionViewModel extends _$EvolutionViewModel {
  @override
  FutureOr<List<Evolution>> build(String patientId) async {
    final realtime = ref.read(realtimeServiceProvider);
    
    // Escuta novas evoluções ou assinaturas de professores em tempo real
    realtime.on('EvolutionUpdated', (args) {
      ref.invalidateSelf();
    });

    return _fetchHistory(patientId);
  }

  Future<List<Evolution>> _fetchHistory(String patientId) async {
    final repository = ref.read(prontuarioRepositoryProvider);
    return await repository.getEvolutionHistory(patientId);
  }

  /// Adiciona uma nova nota clínica (Evolução).
  Future<void> addEvolution(String description, String professorId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(prontuarioRepositoryProvider);
      await repository.addEvolution(arg, description, professorId);
      return _fetchHistory(arg);
    });
  }

  /// Assina uma evolução (Ação exclusiva do Professor).
  Future<void> signEvolution(String evolutionId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(prontuarioRepositoryProvider);
      await repository.signEvolution(evolutionId);
      return _fetchHistory(arg);
    });
  }
}
