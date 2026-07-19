import '../entities/clinic.dart';

/// Contrato para o Repositório de Clínicas e Procedimentos.
abstract class IProceduresRepository {
  /// Recupera todas as clínicas ativas da instituição.
  Future<List<Clinic>> getClinics();

  /// Recupera os procedimentos disponíveis para uma clínica específica.
  Future<List<Procedure>> getProceduresByClinic(String clinicId);

  /// Recupera todos os procedimentos disponíveis no sistema.
  Future<List<Procedure>> getAllProcedures();
}
