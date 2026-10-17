import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/core/di/core_providers.dart';

final themeViewModelProvider =
    NotifierProvider<ThemeViewModel, ThemeMode>(ThemeViewModel.new);

class ThemeViewModel extends Notifier<ThemeMode> {
  static const _key = 'theme_mode';

  @override
  ThemeMode build() {
    final raw = ref.read(sharedPreferencesProvider).getString(_key);
    return raw == ThemeMode.dark.name ? ThemeMode.dark : ThemeMode.light;
  }

  bool get isDark => state == ThemeMode.dark;

  void setThemeMode(ThemeMode mode) {
    if (state == mode) return;
    state = mode;
    ref.read(sharedPreferencesProvider).setString(_key, mode.name);
  }

  void toggleTheme() {
    setThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
  }
}
