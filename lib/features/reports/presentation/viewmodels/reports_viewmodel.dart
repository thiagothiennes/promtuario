import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/report_data.dart';
import '../../domain/repositories/i_reports_repository.dart';
import '../../../../core/providers/providers.dart';

part 'reports_viewmodel.g.dart';

class ReportsState {
  final DateTime startDate;
  final DateTime endDate;
  final bool isLoading;
  final List<SpecialtyProduction> production;
  final ClinicPerformanceMetrics? metrics;
  final String? errorMessage;

  ReportsState({
    required this.startDate,
    required this.endDate,
    this.isLoading = false,
    this.production = const [],
    this.metrics,
    this.errorMessage,
  });

  ReportsState copyWith({
    DateTime? startDate,
    DateTime? endDate,
    bool? isLoading,
    List<SpecialtyProduction>? production,
    ClinicPerformanceMetrics? metrics,
    String? errorMessage,
  }) {
    return ReportsState(
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isLoading: isLoading ?? this.isLoading,
      production: production ?? this.production,
      metrics: metrics ?? this.metrics,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

@riverpod
class ReportsViewModel extends _$ReportsViewModel {
  @override
  FutureOr<ReportsState> build() async {
    final now = DateTime.now();
    final start = DateTime(now.year, now.month, 1); // Início do mês atual
    final end = now;

    return _fetchData(start, end);
  }

  Future<ReportsState> _fetchData(DateTime start, DateTime end) async {
    final repository = ref.read(reportsRepositoryProvider);
    
    try {
      final production = await repository.getProductionBySpecialty(start: start, end: end);
      final metrics = await repository.getClinicMetrics(start: start, end: end);
      
      return ReportsState(
        startDate: start,
        endDate: end,
        production: production,
        metrics: metrics,
        isLoading: false,
      );
    } catch (e) {
      return ReportsState(
        startDate: start,
        endDate: end,
        errorMessage: e.toString(),
        isLoading: false,
      );
    }
  }

  Future<void> updatePeriod(DateTime start, DateTime end) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchData(start, end));
  }

  Future<void> refresh() async {
    if (state.hasValue) {
      final current = state.value!;
      await updatePeriod(current.startDate, current.endDate);
    }
  }
}
