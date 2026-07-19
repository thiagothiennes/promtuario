import 'package:promt/core/network/api_client.dart';
import 'package:promt/features/dashboard/domain/models/dashboard_stats_model.dart';
import 'package:promt/features/dashboard/domain/repositories/i_dashboard_repository.dart';

/// Implementação do Repositório do Dashboard.
class DashboardRepository implements IDashboardRepository {
  final ApiClient _apiClient;

  DashboardRepository(this._apiClient);

  @override
  Future<DashboardStatsModel> getStats() async {
    try {
      final response = await _apiClient.instance.get('/dashboard/stats');
      return DashboardStatsModel.fromJson(response.data);
    } catch (e) {
      // Retorna dados zerados em caso de erro para não quebrar a UI
      return const DashboardStatsModel(
        totalPatients: 0,
        appointmentsToday: 0,
        proceduresThisMonth: 0,
        pendingAlerts: 0,
        growthData: [],
      );
    }
  }
}
