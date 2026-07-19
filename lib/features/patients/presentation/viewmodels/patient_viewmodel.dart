import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/patients/domain/entities/patient.dart';
import 'package:promt/features/patients/domain/repositories/i_patient_repository.dart';
import 'package:promt/core/providers/providers.dart';

/// Notifier responsável pela gestão de pacientes.
class PatientViewModel extends StateNotifier<AsyncValue<List<Patient>>> {
  PatientViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchPatients();
  }

  final Ref ref;

  Future<List<Patient>> _fetchPatients({String? query}) async {
    final repository = ref.read(patientRepositoryProvider);
    return await repository.getPatients(query: query);
  }

  Future<void> searchPatients(String query) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchPatients(query: query));
  }

  Future<void> addPatient(Patient patient) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(patientRepositoryProvider);
      await repository.createPatient(patient);
      return _fetchPatients();
    });
  }

  Future<void> updatePatient(Patient patient) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(patientRepositoryProvider);
      await repository.updatePatient(patient);
      return _fetchPatients();
    });
  }

  Future<void> anonymizePatient(String id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repository = ref.read(patientRepositoryProvider);
      // Implementar chamada de anonimização no repositório se necessário
      return _fetchPatients();
    });
  }
}

final patientViewModelProvider = StateNotifierProvider<PatientViewModel, AsyncValue<List<Patient>>>((ref) {
  return PatientViewModel(ref);
});
