import '../entities/odontogram.dart';
import '../entities/prescription.dart';
import '../entities/anamnese.dart';
import '../entities/treatment_plan.dart';
import '../entities/evolution.dart';

/// Contrato para o Repositório de Prontuário.
abstract class IProntuarioRepository {
  Future<Odontogram> getOdontogram(String patientId);
  Future<void> saveOdontogram(Odontogram odontogram);
  
  Future<void> addEvolution(String patientId, String description, String professorId);
  Future<List<Evolution>> getEvolutionHistory(String patientId);
  Future<void> signEvolution(String evolutionId);

  Future<Prescription> createPrescription(Prescription prescription);
  Future<List<Prescription>> getPrescriptionHistory(String patientId);
  Future<MedicalCertificate> createCertificate(MedicalCertificate certificate);

  Future<Anamnese?> getAnamneseByPatientId(String patientId);
  Future<void> saveAnamnese(Anamnese anamnese);
  
  Future<TreatmentPlan?> getTreatmentPlan(String patientId);
  Future<void> saveTreatmentPlan(TreatmentPlan plan);
  Future<void> updateTreatmentItemStatus(String planId, String itemId, String status);

  /// Sincroniza dados de prontuário (Evoluções e Anamnese) salvos offline.
  Future<void> syncPendingData();
}
