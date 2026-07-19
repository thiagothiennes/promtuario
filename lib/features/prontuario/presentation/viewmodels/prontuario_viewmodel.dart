import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/odontogram.dart';
import '../../domain/repositories/i_prontuario_repository.dart';
import '../../../../core/providers/providers.dart';
import '../../../../core/network/realtime_service.dart';
import '../../../audit/domain/repositories/i_audit_repository.dart';

part 'prontuario_viewmodel.g.dart';

@riverpod
class ProntuarioViewModel extends _$ProntuarioViewModel {
  @override
  FutureOr<Odontogram?> build(String patientId) async {
    final realtime = ref.read(realtimeServiceProvider);
    
    // Registra o acesso ao prontuário para fins de conformidade LGPD
    _logAccess(patientId);

    // Entra no grupo do paciente para atualizações em tempo real
    await realtime.joinPatientGroup(patientId);

    // Escuta atualizações do Odontograma via SignalR
    realtime.on('OdontogramUpdated', (args) {
      if (args != null && args.isNotEmpty) {
        ref.invalidateSelf(); 
      }
    });

    ref.onDispose(() {
      realtime.leavePatientGroup(patientId);
    });

    return _fetchOdontogram(patientId);
  }

  Future<Odontogram?> _fetchOdontogram(String patientId) async {
    final repository = ref.read(prontuarioRepositoryProvider);
    try {
      return await repository.getOdontogram(patientId);
    } catch (e) {
      return null;
    }
  }

  /// Registra que o usuário atual visualizou os dados deste paciente.
  Future<void> _logAccess(String patientId) async {
    try {
      final auditRepo = ref.read(auditRepositoryProvider);
      // Registra a visualização do prontuário sensível
      await auditRepo.registerAccess(patientId, 'VIEW_PRONTUARIO');
    } catch (_) {
      // Falha no log de auditoria não deve travar a UI.
    }
  }

  Future<void> updateToothCondition(ToothCondition condition) async {
    final currentOdontogram = state.value;
    if (currentOdontogram == null) return;

    final updatedTeeth = List<ToothCondition>.from(currentOdontogram.teeth);
    final index = updatedTeeth.indexWhere((t) => t.toothNumber == condition.toothNumber);

    if (index != -1) {
      updatedTeeth[index] = condition;
    } else {
      updatedTeeth.add(condition);
    }

    final updatedOdontogram = currentOdontogram.copyWith(
      teeth: updatedTeeth,
      updatedAt: DateTime.now(),
    );

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(prontuarioRepositoryProvider);
      await repository.saveOdontogram(updatedOdontogram);
      // Registra a alteração clínica
      ref.read(auditRepositoryProvider).registerAccess(arg, 'UPDATE_ODONTOGRAM');
      return updatedOdontogram;
    });
  }
}
