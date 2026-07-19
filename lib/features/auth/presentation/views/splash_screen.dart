import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/auth_viewmodel.dart';

/// Tela inicial de carregamento que decide o fluxo inicial do usuário.
/// Agora integrada ao AuthViewModel para verificação real de sessão.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    // Tenta recuperar a sessão do usuário
    await ref.read(authViewModelProvider.notifier).checkAuth();
    
    if (!mounted) return;

    final authState = ref.read(authViewModelProvider);
    
    // Pequeno delay apenas para não "piscar" a logo
    await Future.delayed(const Duration(milliseconds: 500));

    if (authState.user != null) {
      context.go('/dashboard');
    } else {
      context.go('/login');
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
