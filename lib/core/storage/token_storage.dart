import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  TokenStorage(this._prefs) {
    accessToken = _prefs.getString(_accessKey);
    refreshToken = _prefs.getString(_refreshKey);
  }

  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';

  final SharedPreferences _prefs;

  String? accessToken;
  String? refreshToken;

  Future<void> save({
    required String accessToken,
    required String refreshToken,
  }) async {
    this.accessToken = accessToken;
    this.refreshToken = refreshToken;
    await _prefs.setString(_accessKey, accessToken);
    await _prefs.setString(_refreshKey, refreshToken);
  }

  Future<void> clear() async {
    accessToken = null;
    refreshToken = null;
    await _prefs.remove(_accessKey);
    await _prefs.remove(_refreshKey);
  }
}
