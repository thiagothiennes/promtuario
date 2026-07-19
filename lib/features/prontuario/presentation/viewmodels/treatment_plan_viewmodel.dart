import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/treatment_plan.dart';
import '../../domain/repositories/i_prontuario_repository.dart';
import '../../../../core/providers/providers.dart';
import '../../../../core/network/realtime_service.dart';

part 'treatment_plan_viewmodel.g.dart';

@riverpod
class TreatmentPlanViewModel extends _$TreatmentPlanViewModel {
  @override
  FutureOr<TreatmentPlan?> build(String patientId) async {
    final realtime = ref.read(realtimeServiceProvider);
    await realtime.joinPatientGroup(patientId);

    realtime.on('TreatmentPlanUpdated', (args) {
      ref.invalidateSelf();
    });

    ref.onDispose(() {
      realtime.leavePatientGroup(patientId);
    });

    return _fetchPlan(patientId);
  }

  Future<TreatmentPlan?> _fetchPlan(String patientId) async {
    final repository = ref.read(prontuarioRepositoryProvider);
    return await repository.getTreatmentPlan(patientId);
  }

  /// Adiciona um item com atualização otimista para resposta imediata na UI.
  Future<void> addItem(TreatmentItem item) async {
    final previousState = state.value;
    if (previousState == null) return;

    // Atualização Otimista
    final updatedPlan = previousState.copyWith(
      items: [...previousState.items, item],
      updatedAt: DateTime.now(),
    );
    state = AsyncValue.data(updatedPlan);

    try {
      final repository = ref.read(prontuarioRepositoryProvider);
      await repository.saveTreatmentPlan(updatedPlan);
    } catch (e, st) {
      // Reverte em caso de erro
      state = AsyncValue.error(e, st);
      state = AsyncValue.data(previousState);
    }
  }

  /// Atualiza o status de um item (ex: de pendente para executado).
  Future<void> updateItemStatus(String itemId, TreatmentItemStatus status) async {
    final previousState = state.value;
    if (previousState == null) return;

    final updatedItems = previousState.items.map((item) {
      return item.id == itemId ? item.copyWith(status: status) : item;
    }).toList();

    final updatedPlan = previousState.copyWith(items: updatedItems);
    state = AsyncValue.data(updatedPlan);

    try {
      final repository = ref.read(prontuarioRepositoryProvider);
      await repository.updateTreatmentItemStatus(previousState.id, itemId, status.name);
    } catch (e) {
      state = AsyncValue.data(previousState);
    }
  }

  Future<void> approvePlan() async {
    final currentPlan = state.value;
    if (currentPlan == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(prontuarioRepositoryProvider);
      final updatedPlan = currentPlan.copyWith(
        status: TreatmentPlanStatus.approved,
        updatedAt: DateTime.now(),
      );
      await repository.saveTreatmentPlan(updatedPlan);
      return updatedPlan;
    });
  }
}
