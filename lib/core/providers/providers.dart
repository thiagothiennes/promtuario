import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../network/api_client.dart';
import '../security/storage_service.dart';
import '../database/local_database.dart';
export '../network/api_client.dart' show apiClientProvider;
export '../security/storage_service.dart' show storageServiceProvider;
export '../database/local_database.dart' show databaseProvider;
import '../../features/auth/domain/repositories/i_auth_repository.dart';
import '../../features/auth/data/repositories/auth_repository.dart';
import '../../features/patients/domain/repositories/i_patient_repository.dart';
import '../../features/patients/data/repositories/patient_repository.dart';
import '../../features/agenda/domain/repositories/i_appointment_repository.dart';
import '../../features/agenda/data/repositories/appointment_repository.dart';
import '../../features/prontuario/domain/repositories/i_prontuario_repository.dart';
import '../../features/prontuario/data/repositories/prontuario_repository.dart';
import '../../features/users/domain/repositories/i_user_management_repository.dart';
import '../../features/users/data/repositories/user_management_repository.dart';
import '../../features/dashboard/domain/repositories/i_dashboard_repository.dart';
import '../../features/dashboard/data/repositories/dashboard_repository.dart';
import '../../features/prontuario/domain/repositories/i_attachment_repository.dart';
import '../../features/prontuario/data/repositories/attachment_repository.dart';
import '../../features/notifications/domain/repositories/i_notification_repository.dart';
import '../../features/notifications/data/repositories/notification_repository.dart';
import '../../features/audit/domain/repositories/i_audit_repository.dart';
import '../../features/audit/data/repositories/audit_repository.dart';
import '../../features/agenda/domain/repositories/i_wait_list_repository.dart';
import '../../features/agenda/data/repositories/wait_list_repository.dart';
import '../../features/procedures/domain/repositories/i_procedures_repository.dart';
import '../../features/procedures/data/repositories/procedures_repository.dart';
import '../../features/reports/domain/repositories/i_reports_repository.dart';
import '../../features/reports/data/repositories/reports_repository.dart';

/// Centralização de Provedores de Repositório (Injeção de Dependência).

final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final storage = ref.watch(storageServiceProvider);
  return AuthRepository(apiClient, storage);
});

final patientRepositoryProvider = Provider<IPatientRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final localDb = ref.watch(databaseProvider);
  return PatientRepository(apiClient, localDb);
});

final appointmentRepositoryProvider = Provider<IAppointmentRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final localDb = ref.watch(databaseProvider);
  return AppointmentRepository(apiClient, localDb);
});

final prontuarioRepositoryProvider = Provider<IProntuarioRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final localDb = ref.watch(databaseProvider);
  return ProntuarioRepository(apiClient, localDb);
});

final userManagementRepositoryProvider = Provider<IUserManagementRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final localDb = ref.watch(databaseProvider);
  return UserManagementRepository(apiClient, localDb);
});

final dashboardRepositoryProvider = Provider<IDashboardRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return DashboardRepository(apiClient);
});

final attachmentRepositoryProvider = Provider<IAttachmentRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final localDb = ref.watch(databaseProvider);
  return AttachmentRepository(apiClient, localDb);
});

final notificationRepositoryProvider = Provider<INotificationRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return NotificationRepository(apiClient);
});

final auditRepositoryProvider = Provider<IAuditRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final localDb = ref.watch(databaseProvider);
  return AuditRepository(apiClient, localDb);
});

final waitListRepositoryProvider = Provider<IWaitListRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  final localDb = ref.watch(databaseProvider);
  return WaitListRepository(apiClient, localDb);
});

final proceduresRepositoryProvider = Provider<IProceduresRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ProceduresRepository(apiClient);
});

final reportsRepositoryProvider = Provider<IReportsRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ReportsRepository(apiClient);
});
