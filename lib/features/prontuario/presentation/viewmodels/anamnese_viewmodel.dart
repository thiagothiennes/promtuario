import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/anamnese.dart';
import '../../../core/providers/providers.dart';

/// Gerencia as anamneses dos pacientes.
class AnamneseViewModel extends StateNotifier<AsyncValue<List<Anamnese>>> {
  AnamneseViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchAnamneses();
  }

  final Ref ref;

  Future<List<Anamnese>> _fetchAnamneses({String? patientId}) async {
    // TODO: Implementar repositório de anamneses
    return [];
  }

  /// Recarrega as anamneses.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchAnamneses());
  }

  /// Cria uma nova anamnese.
  Future<void> createAnamnese(Anamnese anamnese) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar criação de anamnese
      return _fetchAnamneses();
    });
  }

  /// Atualiza uma anamnese existente.
  Future<void> updateAnamnese(Anamnese anamnese) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar atualização de anamnese
      return _fetchAnamneses();
    });
  }
}

/// Provider para criar a instância do AnamneseViewModel.
final anamneseViewModelProvider = StateNotifierProvider<AnamneseViewModel, AsyncValue<List<Anamnese>>>((ref) {
  return AnamneseViewModel(ref);
});
