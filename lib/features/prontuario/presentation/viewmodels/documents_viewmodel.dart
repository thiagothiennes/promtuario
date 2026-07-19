import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/prontuario/domain/entities/prescription.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia documentos (atestados/receitas) gerados para o paciente.
class DocumentsViewModel extends StateNotifier<AsyncValue<List<String>>> {
  DocumentsViewModel(this.ref, this.patientId) : super(const AsyncValue.loading()) {
    _fetchDocuments();
  }
  
  final Ref ref;
  final String patientId;
  
  Future<void> _fetchDocuments() async {
    // Implementar busca de documentos gerados no repositório
    state = const AsyncValue.data([]);
  }

  Future<void> refresh() async => _fetchDocuments();

  /// Emite uma nova receita médica/odontológica.
  Future<void> emitPrescription(Prescription prescription) async {
    state = const AsyncValue.loading();
    await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).createPrescription(prescription);
      await refresh();
    });
  }

  /// Emite um novo atestado médico/odontológico.
  Future<void> emitCertificate(MedicalCertificate certificate) async {
    state = const AsyncValue.loading();
    await AsyncValue.guard(() async {
      await ref.read(prontuarioRepositoryProvider).createCertificate(certificate);
      await refresh();
    });
  }
}

final documentsViewModelProvider = StateNotifierProvider.family<DocumentsViewModel, AsyncValue<List<String>>, String>((ref, patientId) {
  return DocumentsViewModel(ref, patientId);
});
