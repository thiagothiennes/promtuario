import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/dashboard/domain/models/dashboard_stats_model.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia o estado do dashboard com estatísticas da clínica.
class DashboardViewModel extends StateNotifier<AsyncValue<DashboardStatsModel>> {
  DashboardViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchStats();
  }

  final Ref ref;

  Future<DashboardStatsModel> _fetchStats() async {
    // Por enquanto retornando dados mockados seguindo a estrutura correta do modelo
    return const DashboardStatsModel(
      totalPatients: 120,
      appointmentsToday: 8,
      proceduresThisMonth: 45,
      pendingAlerts: 2,
      growthData: [
        MonthlyGrowthModel(month: 'Jan', count: 10),
        MonthlyGrowthModel(month: 'Fev', count: 15),
      ],
    );
  }

  /// Recarrega as estatísticas do dashboard.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchStats());
  }
}

/// Provider para criar a instância do DashboardViewModel.
final dashboardViewModelProvider = StateNotifierProvider<DashboardViewModel, AsyncValue<DashboardStatsModel>>((ref) {
  return DashboardViewModel(ref);
});
