class ApiConfig {
  /// Override with `--dart-define=API_BASE_URL=http://10.0.2.2:3000/api`
  /// on the Android emulator.
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:3000/api',
  );

  static const signUp = '/v1/authentication/sign-up';
  static const signIn = '/v1/authentication/sign-in';
  static const refreshToken = '/v1/authentication/refresh-token';
  static const validateRefreshToken = '/v1/authentication/refresh-token/validate';
  static const me = '/v1/authentication/me';
  static const materials = '/v1/materials';
  static const dumpTruckTypes = '/v1/dump-truck-types';
  static const calculationHistories = '/v1/calculation-histories';

  static String calculationHistory(String id) => '$calculationHistories/$id';
}
