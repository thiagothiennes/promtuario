import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/prontuario/domain/entities/treatment_plan.dart';
import 'package:promt/core/providers/providers.dart';
import 'package:promt/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:uuid/uuid.dart';

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

  /// Adiciona um item ao plano de tratamento.
  Future<void> addItem(TreatmentItem item) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final currentPlans = await ref.read(prontuarioRepositoryProvider).getTreatmentPlans(patientId);
      
      TreatmentPlan plan;
      if (currentPlans.isEmpty) {
        // Cria um novo plano se não existir
        final authState = ref.read(authViewModelProvider);
        final user = authState.user;
        
        plan = TreatmentPlan(
          id: const Uuid().v4(),
          patientId: patientId,
          description: 'Plano de tratamento inicial',
          items: [item],
          createdByUserId: user?.id ?? 'unknown',
          status: TreatmentPlanStatus.draft,
          createdAt: DateTime.now(),
        );
        await ref.read(prontuarioRepositoryProvider).saveTreatmentPlan(plan);
      } else {
        // Adiciona ao primeiro plano existente
        plan = currentPlans.first;
        final updatedItems = [...plan.items, item];
        final updatedPlan = plan.copyWith(items: updatedItems);
        await ref.read(prontuarioRepositoryProvider).saveTreatmentPlan(updatedPlan);
      }
      
      return await ref.read(prontuarioRepositoryProvider).getTreatmentPlans(patientId);
    });
  }

  /// Salva um plano completo.
  Future<void> savePlan(TreatmentPlan plan) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).saveTreatmentPlan(plan);
      return await ref.read(prontuarioRepositoryProvider).getTreatmentPlans(patientId);
    });
  }

  /// Atualiza o status de um item do plano.
  Future<void> updateItemStatus(String planId, String itemId, String status) async {
    state = await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).updateTreatmentItemStatus(planId, itemId, status);
      return await ref.read(prontuarioRepositoryProvider).getTreatmentPlans(patientId);
    });
  }
}

/// Provider para criar a instância do TreatmentPlanViewModel por paciente.
final treatmentPlanViewModelProvider = StateNotifierProvider.family<TreatmentPlanViewModel, AsyncValue<List<TreatmentPlan>>, String>((ref, patientId) {
  return TreatmentPlanViewModel(ref, patientId);
});
