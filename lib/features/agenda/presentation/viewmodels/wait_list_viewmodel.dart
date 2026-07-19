import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/agenda/domain/entities/wait_list_entry.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia a lista de espera de atendimentos filtrada por clínica.
class WaitListViewModel extends FamilyStateNotifier<AsyncValue<List<WaitListEntry>>, String> {
  WaitListViewModel(this.ref) : super(const AsyncValue.loading());

  final Ref ref;
  late String _clinicId;

  @override
  AsyncValue<List<WaitListEntry>> build(String arg) {
    _clinicId = arg;
    _fetchEntries();
    return const AsyncValue.loading();
  }

  Future<void> _fetchEntries() async {
    state = await AsyncValue.guard(() => 
      ref.read(waitListRepositoryProvider).getWaitListByClinic(_clinicId)
    );
  }

  /// Adiciona um paciente à lista de espera.
  Future<void> addEntry(WaitListEntry entry) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(waitListRepositoryProvider).addToWaitList(entry);
      final list = await ref.read(waitListRepositoryProvider).getWaitListByClinic(_clinicId);
      return list;
    });
  }

  /// Resolve uma entrada (marcar como concluído/atendido).
  Future<void> resolve(String id) async {
    state = await AsyncValue.guard(() async {
      await ref.read(waitListRepositoryProvider).resolveEntry(id);
      final list = await ref.read(waitListRepositoryProvider).getWaitListByClinic(_clinicId);
      return list;
    });
  }
}

/// Provider para criar a instância do WaitListViewModel por clínica.
final waitListViewModelProvider = StateNotifierProvider.family<WaitListViewModel, AsyncValue<List<WaitListEntry>>, String>((ref, clinicId) {
  final vm = WaitListViewModel(ref);
  vm.build(clinicId);
  return vm;
});
