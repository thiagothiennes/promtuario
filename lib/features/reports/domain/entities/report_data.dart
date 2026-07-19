import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_data.freezed.dart';
part 'report_data.g.dart';

@freezed
class SpecialtyProduction with _$SpecialtyProduction {
  const factory SpecialtyProduction({
    required String specialty,
    required int appointmentCount,
    required double totalValue,
    required double efficiencyRate,
  }) = _SpecialtyProduction;

  factory SpecialtyProduction.fromJson(Map<String, dynamic> json) => _$SpecialtyProductionFromJson(json);
}

@freezed
class ClinicPerformanceMetrics with _$ClinicPerformanceMetrics {
  const factory ClinicPerformanceMetrics({
    required double occupancyRate,
    required double absenceRate,
    required int totalProceduresThisMonth,
    required List<MonthlyGrowth> growthHistory,
  }) = _ClinicPerformanceMetrics;

  factory ClinicPerformanceMetrics.fromJson(Map<String, dynamic> json) => _$ClinicPerformanceMetricsFromJson(json);
}

@freezed
class MonthlyGrowth with _$MonthlyGrowth {
  const factory MonthlyGrowth({
    required String month,
    required int count,
  }) = _MonthlyGrowth;

  factory MonthlyGrowth.fromJson(Map<String, dynamic> json) => _$MonthlyGrowthFromJson(json);
}
