import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('es');

  Locale get locale => _locale;
  bool get isSpanish => _locale.languageCode == 'es';

  void toggleLocale() {
    _locale = isSpanish ? const Locale('en') : const Locale('es');
    notifyListeners();
  }
}
