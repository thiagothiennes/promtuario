import '../domain/entities/report_data.dart';

/// Contrato para o Repositório de Relatórios e Indicadores.
abstract class IReportsRepository {
  /// Recupera dados consolidados de produção por especialidade.
  Future<List<SpecialtyProduction>> getProductionBySpecialty({
    required DateTime start,
    required DateTime end,
  });

  /// Recupera indicadores de eficiência (taxa de ocupação, faltas, etc).
  Future<ClinicPerformanceMetrics> getClinicMetrics({
    required DateTime start,
    required DateTime end,
  });
}
