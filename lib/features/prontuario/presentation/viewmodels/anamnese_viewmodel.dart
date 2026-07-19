import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/prontuario/domain/entities/anamnese.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia as anamneses dos pacientes.
class AnamneseViewModel extends FamilyStateNotifier<AsyncValue<List<Anamnese>>, String> {
  AnamneseViewModel(this.ref) : super(const AsyncValue.loading());

  final Ref ref;
  late String _patientId;

  @override
  AsyncValue<List<Anamnese>> build(String arg) {
    _patientId = arg;
    _fetchAnamneses();
    return const AsyncValue.loading();
  }

  Future<void> _fetchAnamneses() async {
    state = await AsyncValue.guard(() => 
      ref.read(prontuarioRepositoryProvider).getAnamneses(_patientId)
    );
  }

  Future<void> refresh() async => _fetchAnamneses();

  Future<void> saveAnamnese(Map<String, dynamic> responses) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).saveAnamnese(_patientId, responses);
      final list = await ref.read(prontuarioRepositoryProvider).getAnamneses(_patientId);
      return list;
    });
  }
}

final anamneseViewModelProvider = StateNotifierProvider.family<AnamneseViewModel, AsyncValue<List<Anamnese>>, String>((ref, patientId) {
  final vm = AnamneseViewModel(ref);
  vm.build(patientId);
  return vm;
});
