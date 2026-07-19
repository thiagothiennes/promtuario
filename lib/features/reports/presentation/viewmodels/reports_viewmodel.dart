import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/report_data.dart';
import '../../../core/providers/providers.dart';

/// Gerencia relatórios e estatísticas da clínica.
class ReportsViewModel extends StateNotifier<AsyncValue<List<ReportData>>> {
  ReportsViewModel(this.ref) : super(const AsyncValue.loading()) {
    _fetchReports();
  }

  final Ref ref;

  Future<List<ReportData>> _fetchReports({DateTime? start, DateTime? end}) async {
    // TODO: Implementar repositório de relatórios
    return [];
  }

  /// Recarrega os relatórios.
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchReports());
  }

  /// Gera relatório por período.
  Future<void> generateByPeriod(DateTime start, DateTime end) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchReports(start: start, end: end));
  }
}

/// Provider para criar a instância do ReportsViewModel.
final reportsViewModelProvider = StateNotifierProvider<ReportsViewModel, AsyncValue<List<ReportData>>>((ref) {
  return ReportsViewModel(ref);
});
