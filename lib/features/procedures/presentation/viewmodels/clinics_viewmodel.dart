import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/procedures/domain/entities/clinic.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia as clínicas/unidades de atendimento.
class ClinicsViewModel extends StateNotifier<AsyncValue<List<Clinic>>> {
  ClinicsViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchClinics();
  }

  final Ref ref;

  Future<List<Clinic>> _fetchClinics() async {
    final repository = ref.read(proceduresRepositoryProvider);
    return await repository.getClinics();
  }

  /// Recarrega a lista de clínicas.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchClinics());
  }
}

/// Provider para criar a instância do ClinicsViewModel.
final clinicsViewModelProvider = StateNotifierProvider<ClinicsViewModel, AsyncValue<List<Clinic>>>((ref) {
  return ClinicsViewModel(ref);
});
