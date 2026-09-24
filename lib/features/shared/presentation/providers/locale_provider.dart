import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  static const _key = 'locale_code';

  LocaleProvider(this._prefs) {
    final raw = _prefs.getString(_key);
    _locale = raw == 'en' ? const Locale('en') : const Locale('es');
  }

  final SharedPreferences _prefs;
  late Locale _locale;

  Locale get locale => _locale;
  bool get isSpanish => _locale.languageCode == 'es';

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    _prefs.setString(_key, locale.languageCode);
    notifyListeners();
  }

  void toggleLocale() {
    setLocale(isSpanish ? const Locale('en') : const Locale('es'));
  }
}
