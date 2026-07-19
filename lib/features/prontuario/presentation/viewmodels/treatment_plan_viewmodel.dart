import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/treatment_plan.dart';
import '../../../core/providers/providers.dart';

/// Gerencia os planos de tratamento dos pacientes.
class TreatmentPlanViewModel extends StateNotifier<AsyncValue<List<TreatmentPlan>>> {
  TreatmentPlanViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchTreatmentPlans();
  }

  final Ref ref;

  Future<List<TreatmentPlan>> _fetchTreatmentPlans({String? patientId}) async {
    // TODO: Implementar repositório de planos de tratamento
    return [];
  }

  /// Recarrega os planos de tratamento.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchTreatmentPlans());
  }

  /// Cria um novo plano de tratamento.
  Future<void> createTreatmentPlan(TreatmentPlan plan) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar criação de plano de tratamento
      return _fetchTreatmentPlans();
    });
  }

  /// Atualiza um plano de tratamento existente.
  Future<void> updateTreatmentPlan(TreatmentPlan plan) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar atualização de plano de tratamento
      return _fetchTreatmentPlans();
    });
  }
}

/// Provider para criar a instância do TreatmentPlanViewModel.
final treatmentPlanViewModelProvider = StateNotifierProvider<TreatmentPlanViewModel, AsyncValue<List<TreatmentPlan>>>((ref) {
  return TreatmentPlanViewModel(ref);
});
