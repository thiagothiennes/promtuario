import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/wait_list_entry.dart';
import '../../domain/repositories/i_wait_list_repository.dart';
import '../../../../core/providers/providers.dart';

/// Gerencia a lista de espera de atendimentos.
class WaitListViewModel extends StateNotifier<AsyncValue<List<WaitListEntry>>> {
  WaitListViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchEntries();
  }

  final Ref ref;

  Future<List<WaitListEntry>> _fetchEntries() async {
    final repository = ref.read(waitListRepositoryProvider);
    return await repository.getEntries();
  }

  /// Adiciona um paciente à lista de espera.
  Future<void> addEntry(WaitListEntry entry) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(waitListRepositoryProvider);
      await repository.addEntry(entry);
      return _fetchEntries();
    });
  }

  /// Remove um paciente da lista de espera.
  Future<void> removeEntry(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(waitListRepositoryProvider);
      await repository.removeEntry(id);
      return _fetchEntries();
    });
  }

  /// Converte um entry da lista de espera em agendamento.
  Future<void> convertToAppointment(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(waitListRepositoryProvider);
      await repository.convertToAppointment(id);
      return _fetchEntries();
    });
  }
}

/// Provider para criar a instância do WaitListViewModel.
final waitListViewModelProvider = StateNotifierProvider<WaitListViewModel, AsyncValue<List<WaitListEntry>>>((ref) {
  return WaitListViewModel(ref);
});
