import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/core/di/core_providers.dart';

final localeViewModelProvider =
    NotifierProvider<LocaleViewModel, Locale>(LocaleViewModel.new);

class LocaleViewModel extends Notifier<Locale> {
  static const _key = 'locale_code';

  @override
  Locale build() {
    final raw = ref.read(sharedPreferencesProvider).getString(_key);
    return raw == 'en' ? const Locale('en') : const Locale('es');
  }

  bool get isSpanish => state.languageCode == 'es';

  void setLocale(Locale locale) {
    if (state == locale) return;
    state = locale;
    ref.read(sharedPreferencesProvider).setString(_key, locale.languageCode);
  }

  void toggleLocale() {
    setLocale(isSpanish ? const Locale('en') : const Locale('es'));
  }
}
