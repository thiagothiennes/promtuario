import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/auth_viewmodel.dart';

/// Tela inicial de carregamento que decide o fluxo inicial do usuário.
/// A navegação é controlada exclusivamente pelo redirect do GoRouter.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    // Aguarda o primeiro frame para garantir que o widget está montado
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !_initialized) {
        _initApp();
      }
    });
  }

  Future<void> _initApp() async {
    if (_initialized) return;
    _initialized = true;

    try {
      // Tenta recuperar a sessão do usuário
      await ref.read(authViewModelProvider.notifier).checkAuth();
      
      // A navegação agora é feita exclusivamente pelo redirect do GoRouter
      // Não precisamos chamar context.go() aqui
    } catch (e, stackTrace) {
      debugPrint('Erro na inicialização: $e\n$stackTrace');
      // Em caso de erro crítico, marca como inicializado para o router lidar
      if (mounted) {
        ref.read(authViewModelProvider.notifier).state = 
          ref.read(authViewModelProvider).copyWith(isInitialized: true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.health_and_safety, size: 80, color: Colors.blue),
            SizedBox(height: 24),
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'OdontoClinica Universitária',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
