import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/prontuario/domain/entities/treatment_plan.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia os planos de tratamento dos pacientes.
class TreatmentPlanViewModel extends StateNotifier<AsyncValue<List<TreatmentPlan>>> {
  TreatmentPlanViewModel(this.ref, this.patientId) : super(const AsyncValue.loading()) {
    _fetchTreatmentPlans();
  }

  final Ref ref;
  final String patientId;

  Future<void> _fetchTreatmentPlans() async {
    state = await AsyncValue.guard(() => 
      ref.read(prontuarioRepositoryProvider).getTreatmentPlans(patientId)
    );
  }

  /// Recarrega os planos de tratamento.
  Future<void> refresh() async => _fetchTreatmentPlans();

  /// Cria um novo plano de tratamento.
  Future<void> createTreatmentPlan(TreatmentPlan plan) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).saveTreatmentPlan(plan);
      final list = await ref.read(prontuarioRepositoryProvider).getTreatmentPlans(patientId);
      return list;
    });
  }
}

/// Provider para criar a instância do TreatmentPlanViewModel por paciente.
final treatmentPlanViewModelProvider = StateNotifierProvider.family<TreatmentPlanViewModel, AsyncValue<List<TreatmentPlan>>, String>((ref, patientId) {
  return TreatmentPlanViewModel(ref, patientId);
});
