import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/auth/presentation/views/login_screen.dart';
import '../../features/auth/presentation/views/splash_screen.dart';
import '../../features/dashboard/presentation/views/dashboard_screen.dart';
import '../../features/auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../features/patients/presentation/views/patient_list_screen.dart';
import '../../features/patients/presentation/views/add_patient_screen.dart';
import '../../features/prontuario/presentation/views/prontuario_screen.dart';
import '../../features/patients/domain/entities/patient.dart';
import '../../features/users/presentation/views/user_list_screen.dart';
import '../../features/users/presentation/views/add_user_screen.dart';
import '../../features/agenda/presentation/views/agenda_screen.dart';
import '../../features/agenda/presentation/views/add_appointment_screen.dart';
import '../../features/agenda/presentation/views/wait_list_screen.dart';
import '../../features/prontuario/presentation/views/prescription_screen.dart';
import '../../features/prontuario/presentation/views/certificate_screen.dart';
import '../../features/prontuario/presentation/views/anamnese_screen.dart';
import '../../features/prontuario/presentation/views/treatment_plan_screen.dart';
import '../../features/reports/presentation/views/reports_screen.dart';
import '../../features/settings/presentation/views/settings_screen.dart';
import '../../features/notifications/presentation/views/notification_list_screen.dart';
import '../../features/audit/presentation/views/audit_log_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: _RouterRefreshStream(ref.watch(authViewModelProvider.notifier).stream),
    redirect: (context, state) {
      final isSplash = state.matchedLocation == '/splash';
      final isLoggingIn = state.matchedLocation == '/login';
      final isLoggedIn = authState.user != null;
      final isInitialized = authState.isInitialized;

      // Se ainda não foi inicializado, permanece na splash
      if (!isInitialized) {
        return null;
      }

      // Se está na splash e já foi inicializado, redireciona
      if (isSplash) {
        return isLoggedIn ? '/dashboard' : '/login';
      }

      // Se não está logado e tenta acessar outra rota, vai para login
      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }

      // Se está logado e tenta acessar login, vai para dashboard
      if (isLoggedIn && isLoggingIn) {
        return '/dashboard';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
        routes: [
          GoRoute(
            path: 'patients',
            builder: (context, state) => const PatientListScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const AddPatientScreen(),
              ),
              GoRoute(
                path: 'prontuario',
                builder: (context, state) {
                  final patient = state.extra as Patient;
                  return ProntuarioScreen(patient: patient);
                },
                routes: [
                  GoRoute(
                    path: 'prescription',
                    builder: (context, state) {
                      final patientId = state.uri.queryParameters['patientId']!;
                      return PrescriptionScreen(patientId: patientId);
                    },
                  ),
                  GoRoute(
                    path: 'certificate',
                    builder: (context, state) {
                      final patientId = state.uri.queryParameters['patientId']!;
                      final patientName = state.uri.queryParameters['patientName']!;
                      return CertificateScreen(patientId: patientId, patientName: patientName);
                    },
                  ),
                  GoRoute(
                    path: 'anamnese',
                    builder: (context, state) {
                      final patientId = state.uri.queryParameters['patientId']!;
                      final patientName = state.uri.queryParameters['patientName']!;
                      return AnamneseScreen(patientId: patientId, patientName: patientName);
                    },
                  ),
                  GoRoute(
                    path: 'treatment-plan',
                    builder: (context, state) {
                      final patientId = state.uri.queryParameters['patientId']!;
                      final patientName = state.uri.queryParameters['patientName']!;
                      return TreatmentPlanScreen(patientId: patientId, patientName: patientName);
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: 'users',
            builder: (context, state) => const UserListScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const AddUserScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'agenda',
            builder: (context, state) => const AgendaScreen(),
            routes: [
              GoRoute(
                path: 'add',
                builder: (context, state) => const AddAppointmentScreen(),
              ),
              GoRoute(
                path: 'wait-list',
                builder: (context, state) {
                  final clinicId = state.uri.queryParameters['clinicId']!;
                  final clinicName = state.uri.queryParameters['clinicName']!;
                  return WaitListScreen(clinicId: clinicId, clinicName: clinicName);
                },
              ),
            ],
          ),
          GoRoute(
            path: 'reports',
            builder: (context, state) => const ReportsScreen(),
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: 'notifications',
            builder: (context, state) => const NotificationListScreen(),
          ),
          GoRoute(
            path: 'audit-logs',
            builder: (context, state) => const AuditLogScreen(),
          ),
        ],
      ),
    ],
  );
});

class _RouterRefreshStream extends ChangeNotifier {
  _RouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.asBroadcastStream().listen((_) => notifyListeners());
  }

  late final dynamic _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
