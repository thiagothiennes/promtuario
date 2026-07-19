import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/clinic.dart';
import '../../../core/providers/providers.dart';

/// Gerencia as clínicas/unidades de atendimento.
class ClinicsViewModel extends StateNotifier<AsyncValue<List<Clinic>>> {
  ClinicsViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchClinics();
  }

  final Ref ref;

  Future<List<Clinic>> _fetchClinics() async {
    // TODO: Implementar repositório de clínicas
    return [];
  }

  /// Recarrega a lista de clínicas.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchClinics());
  }

  /// Adiciona uma nova clínica.
  Future<void> addClinic(Clinic clinic) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar adição de clínica
      return _fetchClinics();
    });
  }

  /// Atualiza uma clínica existente.
  Future<void> updateClinic(Clinic clinic) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar atualização de clínica
      return _fetchClinics();
    });
  }
}

/// Provider para criar a instância do ClinicsViewModel.
final clinicsViewModelProvider = StateNotifierProvider<ClinicsViewModel, AsyncValue<List<Clinic>>>((ref) {
  return ClinicsViewModel(ref);
});
