import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/clinic.dart';
import '../../domain/repositories/i_procedures_repository.dart';
import '../../../../core/providers/providers.dart';

part 'procedures_viewmodel.g.dart';

@riverpod
class ProceduresViewModel extends _$ProceduresViewModel {
  @override
  FutureOr<List<Procedure>> build() async {
    return _fetchAll();
  }

  Future<List<Procedure>> _fetchAll() async {
    final repository = ref.read(proceduresRepositoryProvider);
    return await repository.getAllProcedures();
  }

  /// Filtra procedimentos por clínica selecionada.
  Future<void> filterByClinic(String clinicId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(proceduresRepositoryProvider);
      return await repository.getProceduresByClinic(clinicId);
    });
  }
}
