import '../../../../core/network/api_client.dart';
import '../../domain/entities/report_data.dart';
import '../../domain/repositories/i_reports_repository.dart';

/// Implementação do repositório de relatórios.
/// Centraliza a busca de métricas e indicadores de produção da clínica.
class ReportsRepository implements IReportsRepository {
  final ApiClient _apiClient;

  ReportsRepository(this._apiClient);

  @override
  Future<List<SpecialtyProduction>> getProductionBySpecialty({
    required DateTime start,
    required DateTime end,
  }) async {
    final response = await _apiClient.instance.get('/reports/production', queryParameters: {
      'startDate': start.toIso8601String(),
      'endDate': end.toIso8601String(),
    });

    final List<dynamic> data = response.data;
    return data.map((json) => SpecialtyProduction.fromJson(json)).toList();
  }

  @override
  Future<ClinicPerformanceMetrics> getClinicMetrics({
    required DateTime start,
    required DateTime end,
  }) async {
    final response = await _apiClient.instance.get('/reports/metrics', queryParameters: {
      'startDate': start.toIso8601String(),
      'endDate': end.toIso8601String(),
    });

    return ClinicPerformanceMetrics.fromJson(response.data);
  }
}
