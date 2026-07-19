import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/models/dashboard_stats_model.dart';
import '../../../../core/providers/providers.dart';
import '../../../../core/network/realtime_service.dart';

part 'dashboard_viewmodel.g.dart';

@riverpod
class DashboardViewModel extends _$DashboardViewModel {
  @override
  FutureOr<DashboardStatsModel> build() async {
    final realtime = ref.read(realtimeServiceProvider);
    
    // Escuta eventos que podem alterar as estatísticas globais
    realtime.on('ReceiveNotification', (_) => ref.invalidateSelf());
    realtime.on('AppointmentUpdated', (_) => ref.invalidateSelf());
    realtime.on('PatientUpdated', (_) => ref.invalidateSelf());

    return _fetchStats();
  }

  Future<DashboardStatsModel> _fetchStats() async {
    final repository = ref.read(dashboardRepositoryProvider);
    return await repository.getStats();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchStats());
  }
}
