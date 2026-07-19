import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notifier responsável pelo gerenciamento do tema da aplicação.
class ThemeViewModel extends StateNotifier<ThemeMode> {
  ThemeViewModel() : super(ThemeMode.system);

  void toggleTheme(bool isDark) {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}

/// Provider para criar a instância do ThemeViewModel.
final themeViewModelProvider = StateNotifierProvider<ThemeViewModel, ThemeMode>((ref) {
  return ThemeViewModel();
});
