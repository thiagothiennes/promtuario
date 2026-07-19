import 'package:freezed_annotation/freezed_annotation.dart';

part 'wait_list_entry.freezed.dart';
part 'wait_list_entry.g.dart';

@freezed
class WaitListEntry with _$WaitListEntry {
  const factory WaitListEntry({
    required String id,
    required String patientId,
    required String patientName,
    required String clinicId,
    required String specialty,
    required String priority,
    String? observation,
    required DateTime createdAt,
  }) = _WaitListEntry;

  factory WaitListEntry.fromJson(Map<String, dynamic> json) => _$WaitListEntryFromJson(json);
}
