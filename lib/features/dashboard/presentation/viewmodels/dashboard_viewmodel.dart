import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/dashboard_stats_model.dart';
import '../../../core/providers/providers.dart';

/// Gerencia o estado do dashboard com estatísticas da clínica.
class DashboardViewModel extends StateNotifier<AsyncValue<DashboardStatsModel>> {
  DashboardViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchStats();
  }

  final Ref ref;

  Future<DashboardStatsModel> _fetchStats() async {
    // TODO: Implementar repositório de dashboard
    return DashboardStatsModel(
      totalPatients: 0,
      appointmentsToday: 0,
      pendingTreatments: 0,
      revenue: 0.0,
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
