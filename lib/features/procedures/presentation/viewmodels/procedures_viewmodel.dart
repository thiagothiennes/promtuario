import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/procedures/domain/entities/procedure.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia os procedimentos disponíveis.
class ProceduresViewModel extends StateNotifier<AsyncValue<List<Procedure>>> {
  ProceduresViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchProcedures();
  }

  final Ref ref;

  Future<List<Procedure>> _fetchProcedures() async {
    final repository = ref.read(proceduresRepositoryProvider);
    return await repository.getAllProcedures();
  }

  /// Recarrega a lista de procedimentos.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProcedures());
  }
}

/// Provider para criar a instância do ProceduresViewModel.
final proceduresViewModelProvider = StateNotifierProvider<ProceduresViewModel, AsyncValue<List<Procedure>>>((ref) {
  return ProceduresViewModel(ref);
});
