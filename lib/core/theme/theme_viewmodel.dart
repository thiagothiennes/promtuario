import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_viewmodel.g.dart';

@riverpod
class ThemeViewModel extends _$ThemeViewModel {
  @override
  ThemeMode build() => ThemeMode.system;

  void toggleTheme(bool isDark) {
    state = isDark ? ThemeMode.dark : ThemeMode.light;
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
  }
}
