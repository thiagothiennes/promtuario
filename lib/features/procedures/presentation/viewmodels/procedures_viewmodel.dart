import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/procedure.dart';
import '../../../core/providers/providers.dart';

/// Gerencia os procedimentos disponíveis.
class ProceduresViewModel extends StateNotifier<AsyncValue<List<Procedure>>> {
  ProceduresViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchProcedures();
  }

  final Ref ref;

  Future<List<Procedure>> _fetchProcedures() async {
    // TODO: Implementar repositório de procedimentos
    return [];
  }

  /// Recarrega a lista de procedimentos.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchProcedures());
  }

  /// Adiciona um novo procedimento.
  Future<void> addProcedure(Procedure procedure) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar adição de procedimento
      return _fetchProcedures();
    });
  }

  /// Atualiza um procedimento existente.
  Future<void> updateProcedure(Procedure procedure) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // TODO: Implementar atualização de procedimento
      return _fetchProcedures();
    });
  }
}

/// Provider para criar a instância do ProceduresViewModel.
final proceduresViewModelProvider = StateNotifierProvider<ProceduresViewModel, AsyncValue<List<Procedure>>>((ref) {
  return ProceduresViewModel(ref);
});
