import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/prontuario/domain/entities/treatment_plan.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia os planos de tratamento dos pacientes.
class TreatmentPlanViewModel extends FamilyStateNotifier<AsyncValue<List<TreatmentPlan>>, String> {
  TreatmentPlanViewModel(this.ref) : super(const AsyncValue.loading());

  final Ref ref;
  late String _patientId;

  @override
  AsyncValue<List<TreatmentPlan>> build(String arg) {
    _patientId = arg;
    _fetchTreatmentPlans();
    return const AsyncValue.loading();
  }

  Future<void> _fetchTreatmentPlans() async {
    state = await AsyncValue.guard(() => 
      ref.read(prontuarioRepositoryProvider).getTreatmentPlans(_patientId)
    );
  }

  /// Recarrega os planos de tratamento.
  Future<void> refresh() async => _fetchTreatmentPlans();

  /// Cria um novo plano de tratamento.
  Future<void> createTreatmentPlan(TreatmentPlan plan) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).saveTreatmentPlan(plan);
      final list = await ref.read(prontuarioRepositoryProvider).getTreatmentPlans(_patientId);
      return list;
    });
  }
}

/// Provider para criar a instância do TreatmentPlanViewModel por paciente.
final treatmentPlanViewModelProvider = StateNotifierProvider.family<TreatmentPlanViewModel, AsyncValue<List<TreatmentPlan>>, String>((ref, patientId) {
  final vm = TreatmentPlanViewModel(ref);
  vm.build(patientId);
  return vm;
});
