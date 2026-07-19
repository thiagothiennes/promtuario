import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:promt/features/reports/domain/entities/report_data.dart';
import 'package:promt/core/providers/providers.dart';

/// Gerencia relatórios e estatísticas da clínica.
class ReportsViewModel extends StateNotifier<AsyncValue<ClinicPerformanceMetrics?>> {
  ReportsViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchReports();
  }

  final Ref ref;

  Future<void> _fetchReports({DateTime? start, DateTime? end}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(reportsRepositoryProvider);
      final now = DateTime.now();
      return await repo.getClinicMetrics(
        start: start ?? DateTime(now.year, now.month, 1),
        end: end ?? now,
      );
    });
  }

  /// Recarrega os relatórios.
  Future<void> refresh() async => _fetchReports();

  /// Gera relatório por período.
  Future<void> generateByPeriod(DateTime start, DateTime end) async {
    await _fetchReports(start: start, end: end);
  }
}

/// Provider para criar a instância do ReportsViewModel.
final reportsViewModelProvider = StateNotifierProvider<ReportsViewModel, AsyncValue<ClinicPerformanceMetrics?>>((ref) {
  return ReportsViewModel(ref);
});
