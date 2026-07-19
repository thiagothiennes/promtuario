import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/prescription.dart';
import '../../domain/repositories/i_prontuario_repository.dart';
import '../../../../core/providers/providers.dart';

part 'documents_viewmodel.g.dart';

/// Gerencia o histórico e emissão de documentos (Receitas e Atestados).
@riverpod
class DocumentsViewModel extends _$DocumentsViewModel {
  @override
  FutureOr<List<dynamic>> build(String patientId) async {
    return _fetchHistory(patientId);
  }

  Future<List<dynamic>> _fetchHistory(String patientId) async {
    final repository = ref.read(prontuarioRepositoryProvider);
    
    // Busca o histórico de receitas
    final prescriptions = await repository.getPrescriptionHistory(patientId);
    
    // Aqui poderíamos unificar com o histórico de atestados se houvesse um endpoint separado,
    // ou filtrar uma lista genérica de documentos.
    // Por enquanto, ordenamos por data decrescente.
    prescriptions.sort((a, b) => b.date.compareTo(a.date));
    
    return prescriptions;
  }

  /// Emite uma nova receita.
  Future<void> emitPrescription(Prescription prescription) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(prontuarioRepositoryProvider);
      await repository.createPrescription(prescription);
      return _fetchHistory(arg);
    });
  }

  /// Emite um novo atestado.
  Future<void> emitCertificate(MedicalCertificate certificate) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(prontuarioRepositoryProvider);
      await repository.createCertificate(certificate);
      return _fetchHistory(arg);
    });
  }
}
