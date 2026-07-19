import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/agenda/domain/entities/wait_list_entry.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia a lista de espera de atendimentos filtrada por clínica.
class WaitListViewModel extends StateNotifier<AsyncValue<List<WaitListEntry>>> {
  WaitListViewModel(this.ref, this.clinicId) : super(const AsyncValue.loading()) {
    _fetchEntries();
  }

  final Ref ref;
  final String clinicId;

  Future<void> _fetchEntries() async {
    state = await AsyncValue.guard(() => 
      ref.read(waitListRepositoryProvider).getWaitListByClinic(clinicId)
    );
  }

  /// Adiciona um paciente à lista de espera.
  Future<void> addEntry(WaitListEntry entry) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(waitListRepositoryProvider).addToWaitList(entry);
      final list = await ref.read(waitListRepositoryProvider).getWaitListByClinic(clinicId);
      return list;
    });
  }

  /// Resolve uma entrada (marcar como concluído/atendido).
  Future<void> resolve(String id) async {
    state = await AsyncValue.guard(() async {
      await ref.read(waitListRepositoryProvider).resolveEntry(id);
      final list = await ref.read(waitListRepositoryProvider).getWaitListByClinic(clinicId);
      return list;
    });
  }
}

/// Provider para criar a instância do WaitListViewModel por clínica.
final waitListViewModelProvider = StateNotifierProvider.family<WaitListViewModel, AsyncValue<List<WaitListEntry>>, String>((ref, clinicId) {
  return WaitListViewModel(ref, clinicId);
});
