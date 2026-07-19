import '../../../../core/network/api_client.dart';
import '../../domain/entities/clinic.dart';
import '../../domain/entities/procedure.dart';
import '../../domain/repositories/i_procedures_repository.dart';

/// Implementação do repositório de Clínicas e Procedimentos.
/// Centraliza a definição das clínicas escola autorizadas na instituição.
class ProceduresRepository implements IProceduresRepository {
  final ApiClient _apiClient;

  ProceduresRepository(this._apiClient);

  /// Lista oficial e exclusiva de clínicas conforme requisitos institucionais.
  /// Nota: "Clinica I" mantido sem acento conforme solicitado.
  final List<Clinic> _fixedClinics = [
    const Clinic(id: 'c1', name: 'Clinica I', description: 'Atendimento Clínico I'),
    const Clinic(id: 'c2', name: 'Clínica II', description: 'Atendimento Clínico II'),
    const Clinic(id: 'c3', name: 'Clínica III', description: 'Atendimento Clínico III'),
    const Clinic(id: 'c4', name: 'Clínica IV', description: 'Atendimento Clínico IV'),
    const Clinic(id: 'c5', name: 'Clínica V', description: 'Atendimento Clínico V'),
    const Clinic(id: 'ia1', name: 'Integrada Adulto I', description: 'Clínica Integrada Adulto I'),
    const Clinic(id: 'ia2', name: 'Integrada Adulto II', description: 'Clínica Integrada Adulto II'),
    const Clinic(id: 'ii', name: 'Integrada Infantil', description: 'Clínica Integrada Infantil'),
    const Clinic(id: 'dtm', name: 'DTM', description: 'Disfunção Temporomandibular'),
  ];

  @override
  Future<List<Clinic>> getClinics() async {
    // Retorna a lista fixa oficial.
    return Future.value(_fixedClinics);
  }

  @override
  Future<List<Procedure>> getProceduresByClinic(String clinicId) async {
    // Busca procedimentos na API filtrando pela clínica.
    try {
      final response = await _apiClient.instance.get('/clinics/$clinicId/procedures');
      final List<dynamic> data = response.data ?? [];
      return data.map((json) => Procedure.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<Procedure>> getAllProcedures() async {
    try {
      final response = await _apiClient.instance.get('/procedures');
      final List<dynamic> data = response.data ?? [];
      return data.map((json) => Procedure.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }
}
