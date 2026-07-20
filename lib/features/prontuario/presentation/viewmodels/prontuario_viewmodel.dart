import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/core/providers/providers.dart';
import 'package:promt/features/prontuario/domain/entities/odontogram.dart';

/// Gerencia o prontuário eletrônico do paciente com odontograma.
class ProntuarioViewModel extends StateNotifier<AsyncValue<Odontogram?>> {
  final Ref ref;
  final String patientId;

  ProntuarioViewModel(this.ref, this.patientId) : super(const AsyncValue.loading()) {
    _fetchOdontogram();
  }

  Future<void> _fetchOdontogram() async {
    state = await AsyncValue.guard(() => 
      ref.read(prontuarioRepositoryProvider).getOdontogram(patientId)
    );
  }

  Future<void> refresh() async => _fetchOdontogram();

  /// Atualiza a condição de um dente no odontograma.
  Future<void> updateToothCondition(ToothCondition condition) async {
    final current = state.value;
    if (current == null) return;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final updatedTeeth = current.teeth.where((t) => t.toothNumber != condition.toothNumber).toList();
      updatedTeeth.add(condition);

      final updated = current.copyWith(
        teeth: updatedTeeth,
        updatedAt: DateTime.now(),
      );

      await ref.read(prontuarioRepositoryProvider).saveOdontogram(updated);
      return updated;
    });
  }
}

final prontuarioViewModelProvider = StateNotifierProvider.family<ProntuarioViewModel, AsyncValue<Odontogram?>, String>((ref, patientId) {
  return ProntuarioViewModel(ref, patientId);
});
