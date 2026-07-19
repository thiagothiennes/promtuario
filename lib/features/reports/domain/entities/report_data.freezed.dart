// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SpecialtyProduction _$SpecialtyProductionFromJson(Map<String, dynamic> json) {
  return _SpecialtyProduction.fromJson(json);
}

/// @nodoc
mixin _$SpecialtyProduction {
  String get specialty => throw _privateConstructorUsedError;
  int get appointmentCount => throw _privateConstructorUsedError;
  double get totalValue => throw _privateConstructorUsedError;
  double get efficiencyRate => throw _privateConstructorUsedError;

  /// Serializes this SpecialtyProduction to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SpecialtyProduction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SpecialtyProductionCopyWith<SpecialtyProduction> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SpecialtyProductionCopyWith<$Res> {
  factory $SpecialtyProductionCopyWith(
          SpecialtyProduction value, $Res Function(SpecialtyProduction) then) =
      _$SpecialtyProductionCopyWithImpl<$Res, SpecialtyProduction>;
  @useResult
  $Res call(
      {String specialty,
      int appointmentCount,
      double totalValue,
      double efficiencyRate});
}

/// @nodoc
class _$SpecialtyProductionCopyWithImpl<$Res, $Val extends SpecialtyProduction>
    implements $SpecialtyProductionCopyWith<$Res> {
  _$SpecialtyProductionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SpecialtyProduction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? specialty = null,
    Object? appointmentCount = null,
    Object? totalValue = null,
    Object? efficiencyRate = null,
  }) {
    return _then(_value.copyWith(
      specialty: null == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentCount: null == appointmentCount
          ? _value.appointmentCount
          : appointmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      efficiencyRate: null == efficiencyRate
          ? _value.efficiencyRate
          : efficiencyRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SpecialtyProductionImplCopyWith<$Res>
    implements $SpecialtyProductionCopyWith<$Res> {
  factory _$$SpecialtyProductionImplCopyWith(_$SpecialtyProductionImpl value,
          $Res Function(_$SpecialtyProductionImpl) then) =
      __$$SpecialtyProductionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String specialty,
      int appointmentCount,
      double totalValue,
      double efficiencyRate});
}

/// @nodoc
class __$$SpecialtyProductionImplCopyWithImpl<$Res>
    extends _$SpecialtyProductionCopyWithImpl<$Res, _$SpecialtyProductionImpl>
    implements _$$SpecialtyProductionImplCopyWith<$Res> {
  __$$SpecialtyProductionImplCopyWithImpl(_$SpecialtyProductionImpl _value,
      $Res Function(_$SpecialtyProductionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SpecialtyProduction
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? specialty = null,
    Object? appointmentCount = null,
    Object? totalValue = null,
    Object? efficiencyRate = null,
  }) {
    return _then(_$SpecialtyProductionImpl(
      specialty: null == specialty
          ? _value.specialty
          : specialty // ignore: cast_nullable_to_non_nullable
              as String,
      appointmentCount: null == appointmentCount
          ? _value.appointmentCount
          : appointmentCount // ignore: cast_nullable_to_non_nullable
              as int,
      totalValue: null == totalValue
          ? _value.totalValue
          : totalValue // ignore: cast_nullable_to_non_nullable
              as double,
      efficiencyRate: null == efficiencyRate
          ? _value.efficiencyRate
          : efficiencyRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SpecialtyProductionImpl implements _SpecialtyProduction {
  const _$SpecialtyProductionImpl(
      {required this.specialty,
      required this.appointmentCount,
      required this.totalValue,
      required this.efficiencyRate});

  factory _$SpecialtyProductionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SpecialtyProductionImplFromJson(json);

  @override
  final String specialty;
  @override
  final int appointmentCount;
  @override
  final double totalValue;
  @override
  final double efficiencyRate;

  @override
  String toString() {
    return 'SpecialtyProduction(specialty: $specialty, appointmentCount: $appointmentCount, totalValue: $totalValue, efficiencyRate: $efficiencyRate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SpecialtyProductionImpl &&
            (identical(other.specialty, specialty) ||
                other.specialty == specialty) &&
            (identical(other.appointmentCount, appointmentCount) ||
                other.appointmentCount == appointmentCount) &&
            (identical(other.totalValue, totalValue) ||
                other.totalValue == totalValue) &&
            (identical(other.efficiencyRate, efficiencyRate) ||
                other.efficiencyRate == efficiencyRate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, specialty, appointmentCount, totalValue, efficiencyRate);

  /// Create a copy of SpecialtyProduction
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SpecialtyProductionImplCopyWith<_$SpecialtyProductionImpl> get copyWith =>
      __$$SpecialtyProductionImplCopyWithImpl<_$SpecialtyProductionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SpecialtyProductionImplToJson(
      this,
    );
  }
}

abstract class _SpecialtyProduction implements SpecialtyProduction {
  const factory _SpecialtyProduction(
      {required final String specialty,
      required final int appointmentCount,
      required final double totalValue,
      required final double efficiencyRate}) = _$SpecialtyProductionImpl;

  factory _SpecialtyProduction.fromJson(Map<String, dynamic> json) =
      _$SpecialtyProductionImpl.fromJson;

  @override
  String get specialty;
  @override
  int get appointmentCount;
  @override
  double get totalValue;
  @override
  double get efficiencyRate;

  /// Create a copy of SpecialtyProduction
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SpecialtyProductionImplCopyWith<_$SpecialtyProductionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ClinicPerformanceMetrics _$ClinicPerformanceMetricsFromJson(
    Map<String, dynamic> json) {
  return _ClinicPerformanceMetrics.fromJson(json);
}

/// @nodoc
mixin _$ClinicPerformanceMetrics {
  double get occupancyRate => throw _privateConstructorUsedError;
  double get absenceRate => throw _privateConstructorUsedError;
  int get totalProceduresThisMonth => throw _privateConstructorUsedError;
  List<MonthlyGrowth> get growthHistory => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;

  /// Serializes this ClinicPerformanceMetrics to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ClinicPerformanceMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicPerformanceMetricsCopyWith<ClinicPerformanceMetrics> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicPerformanceMetricsCopyWith<$Res> {
  factory $ClinicPerformanceMetricsCopyWith(ClinicPerformanceMetrics value,
          $Res Function(ClinicPerformanceMetrics) then) =
      _$ClinicPerformanceMetricsCopyWithImpl<$Res, ClinicPerformanceMetrics>;
  @useResult
  $Res call(
      {double occupancyRate,
      double absenceRate,
      int totalProceduresThisMonth,
      List<MonthlyGrowth> growthHistory,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class _$ClinicPerformanceMetricsCopyWithImpl<$Res,
        $Val extends ClinicPerformanceMetrics>
    implements $ClinicPerformanceMetricsCopyWith<$Res> {
  _$ClinicPerformanceMetricsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicPerformanceMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? occupancyRate = null,
    Object? absenceRate = null,
    Object? totalProceduresThisMonth = null,
    Object? growthHistory = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_value.copyWith(
      occupancyRate: null == occupancyRate
          ? _value.occupancyRate
          : occupancyRate // ignore: cast_nullable_to_non_nullable
              as double,
      absenceRate: null == absenceRate
          ? _value.absenceRate
          : absenceRate // ignore: cast_nullable_to_non_nullable
              as double,
      totalProceduresThisMonth: null == totalProceduresThisMonth
          ? _value.totalProceduresThisMonth
          : totalProceduresThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      growthHistory: null == growthHistory
          ? _value.growthHistory
          : growthHistory // ignore: cast_nullable_to_non_nullable
              as List<MonthlyGrowth>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClinicPerformanceMetricsImplCopyWith<$Res>
    implements $ClinicPerformanceMetricsCopyWith<$Res> {
  factory _$$ClinicPerformanceMetricsImplCopyWith(
          _$ClinicPerformanceMetricsImpl value,
          $Res Function(_$ClinicPerformanceMetricsImpl) then) =
      __$$ClinicPerformanceMetricsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double occupancyRate,
      double absenceRate,
      int totalProceduresThisMonth,
      List<MonthlyGrowth> growthHistory,
      DateTime startDate,
      DateTime endDate});
}

/// @nodoc
class __$$ClinicPerformanceMetricsImplCopyWithImpl<$Res>
    extends _$ClinicPerformanceMetricsCopyWithImpl<$Res,
        _$ClinicPerformanceMetricsImpl>
    implements _$$ClinicPerformanceMetricsImplCopyWith<$Res> {
  __$$ClinicPerformanceMetricsImplCopyWithImpl(
      _$ClinicPerformanceMetricsImpl _value,
      $Res Function(_$ClinicPerformanceMetricsImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicPerformanceMetrics
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? occupancyRate = null,
    Object? absenceRate = null,
    Object? totalProceduresThisMonth = null,
    Object? growthHistory = null,
    Object? startDate = null,
    Object? endDate = null,
  }) {
    return _then(_$ClinicPerformanceMetricsImpl(
      occupancyRate: null == occupancyRate
          ? _value.occupancyRate
          : occupancyRate // ignore: cast_nullable_to_non_nullable
              as double,
      absenceRate: null == absenceRate
          ? _value.absenceRate
          : absenceRate // ignore: cast_nullable_to_non_nullable
              as double,
      totalProceduresThisMonth: null == totalProceduresThisMonth
          ? _value.totalProceduresThisMonth
          : totalProceduresThisMonth // ignore: cast_nullable_to_non_nullable
              as int,
      growthHistory: null == growthHistory
          ? _value._growthHistory
          : growthHistory // ignore: cast_nullable_to_non_nullable
              as List<MonthlyGrowth>,
      startDate: null == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endDate: null == endDate
          ? _value.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ClinicPerformanceMetricsImpl implements _ClinicPerformanceMetrics {
  const _$ClinicPerformanceMetricsImpl(
      {required this.occupancyRate,
      required this.absenceRate,
      required this.totalProceduresThisMonth,
      required final List<MonthlyGrowth> growthHistory,
      required this.startDate,
      required this.endDate})
      : _growthHistory = growthHistory;

  factory _$ClinicPerformanceMetricsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ClinicPerformanceMetricsImplFromJson(json);

  @override
  final double occupancyRate;
  @override
  final double absenceRate;
  @override
  final int totalProceduresThisMonth;
  final List<MonthlyGrowth> _growthHistory;
  @override
  List<MonthlyGrowth> get growthHistory {
    if (_growthHistory is EqualUnmodifiableListView) return _growthHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_growthHistory);
  }

  @override
  final DateTime startDate;
  @override
  final DateTime endDate;

  @override
  String toString() {
    return 'ClinicPerformanceMetrics(occupancyRate: $occupancyRate, absenceRate: $absenceRate, totalProceduresThisMonth: $totalProceduresThisMonth, growthHistory: $growthHistory, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicPerformanceMetricsImpl &&
            (identical(other.occupancyRate, occupancyRate) ||
                other.occupancyRate == occupancyRate) &&
            (identical(other.absenceRate, absenceRate) ||
                other.absenceRate == absenceRate) &&
            (identical(
                    other.totalProceduresThisMonth, totalProceduresThisMonth) ||
                other.totalProceduresThisMonth == totalProceduresThisMonth) &&
            const DeepCollectionEquality()
                .equals(other._growthHistory, _growthHistory) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      occupancyRate,
      absenceRate,
      totalProceduresThisMonth,
      const DeepCollectionEquality().hash(_growthHistory),
      startDate,
      endDate);

  /// Create a copy of ClinicPerformanceMetrics
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicPerformanceMetricsImplCopyWith<_$ClinicPerformanceMetricsImpl>
      get copyWith => __$$ClinicPerformanceMetricsImplCopyWithImpl<
          _$ClinicPerformanceMetricsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ClinicPerformanceMetricsImplToJson(
      this,
    );
  }
}

abstract class _ClinicPerformanceMetrics implements ClinicPerformanceMetrics {
  const factory _ClinicPerformanceMetrics(
      {required final double occupancyRate,
      required final double absenceRate,
      required final int totalProceduresThisMonth,
      required final List<MonthlyGrowth> growthHistory,
      required final DateTime startDate,
      required final DateTime endDate}) = _$ClinicPerformanceMetricsImpl;

  factory _ClinicPerformanceMetrics.fromJson(Map<String, dynamic> json) =
      _$ClinicPerformanceMetricsImpl.fromJson;

  @override
  double get occupancyRate;
  @override
  double get absenceRate;
  @override
  int get totalProceduresThisMonth;
  @override
  List<MonthlyGrowth> get growthHistory;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;

  /// Create a copy of ClinicPerformanceMetrics
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicPerformanceMetricsImplCopyWith<_$ClinicPerformanceMetricsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

MonthlyGrowth _$MonthlyGrowthFromJson(Map<String, dynamic> json) {
  return _MonthlyGrowth.fromJson(json);
}

/// @nodoc
mixin _$MonthlyGrowth {
  String get month => throw _privateConstructorUsedError;
  int get count => throw _privateConstructorUsedError;

  /// Serializes this MonthlyGrowth to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyGrowth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyGrowthCopyWith<MonthlyGrowth> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyGrowthCopyWith<$Res> {
  factory $MonthlyGrowthCopyWith(
          MonthlyGrowth value, $Res Function(MonthlyGrowth) then) =
      _$MonthlyGrowthCopyWithImpl<$Res, MonthlyGrowth>;
  @useResult
  $Res call({String month, int count});
}

/// @nodoc
class _$MonthlyGrowthCopyWithImpl<$Res, $Val extends MonthlyGrowth>
    implements $MonthlyGrowthCopyWith<$Res> {
  _$MonthlyGrowthCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyGrowth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? count = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyGrowthImplCopyWith<$Res>
    implements $MonthlyGrowthCopyWith<$Res> {
  factory _$$MonthlyGrowthImplCopyWith(
          _$MonthlyGrowthImpl value, $Res Function(_$MonthlyGrowthImpl) then) =
      __$$MonthlyGrowthImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String month, int count});
}

/// @nodoc
class __$$MonthlyGrowthImplCopyWithImpl<$Res>
    extends _$MonthlyGrowthCopyWithImpl<$Res, _$MonthlyGrowthImpl>
    implements _$$MonthlyGrowthImplCopyWith<$Res> {
  __$$MonthlyGrowthImplCopyWithImpl(
      _$MonthlyGrowthImpl _value, $Res Function(_$MonthlyGrowthImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonthlyGrowth
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? count = null,
  }) {
    return _then(_$MonthlyGrowthImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyGrowthImpl implements _MonthlyGrowth {
  const _$MonthlyGrowthImpl({required this.month, required this.count});

  factory _$MonthlyGrowthImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyGrowthImplFromJson(json);

  @override
  final String month;
  @override
  final int count;

  @override
  String toString() {
    return 'MonthlyGrowth(month: $month, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyGrowthImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, month, count);

  /// Create a copy of MonthlyGrowth
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyGrowthImplCopyWith<_$MonthlyGrowthImpl> get copyWith =>
      __$$MonthlyGrowthImplCopyWithImpl<_$MonthlyGrowthImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyGrowthImplToJson(
      this,
    );
  }
}

abstract class _MonthlyGrowth implements MonthlyGrowth {
  const factory _MonthlyGrowth(
      {required final String month,
      required final int count}) = _$MonthlyGrowthImpl;

  factory _MonthlyGrowth.fromJson(Map<String, dynamic> json) =
      _$MonthlyGrowthImpl.fromJson;

  @override
  String get month;
  @override
  int get count;

  /// Create a copy of MonthlyGrowth
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyGrowthImplCopyWith<_$MonthlyGrowthImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
