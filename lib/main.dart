import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:logging/logging.dart';
import 'package:promt/core/router/app_router.dart';
import 'package:promt/core/theme/app_theme.dart';
import 'package:promt/core/theme/theme_viewmodel.dart';

/// Ponto de entrada principal do sistema OdontoClinica Universitária.
void main() async {
  // Garante que o binding do Flutter esteja inicializado.
  WidgetsFlutterBinding.ensureInitialized();

  // Configuração global de Logs
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  // Inicializa a formatação de datas para Português do Brasil.
  await initializeDateFormatting('pt_BR', null);

  runApp(
    const ProviderScope(
      child: OdontoClinicaApp(),
    ),
  );
}

class OdontoClinicaApp extends ConsumerWidget {
  const OdontoClinicaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuta as mudanças no roteador e no tema.
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeViewModelProvider);

    return MaterialApp.router(
      title: 'OdontoClinica Universitária',
      debugShowCheckedModeBanner: false,
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}
