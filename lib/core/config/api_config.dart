import 'package:vehicle_calculator/core/config/app_config.dart';

class ApiConfig {
  static const baseUrl = AppConfig.apiBaseUrl;

  static const signUp = '/v1/authentication/sign-up';
  static const signIn = '/v1/authentication/sign-in';
  static const refreshToken = '/v1/authentication/refresh-token';
  static const validateRefreshToken = '/v1/authentication/refresh-token/validate';
  static const me = '/v1/authentication/me';
  static const materials = '/v1/materials';
  static const dumpTruckTypes = '/v1/dump-truck-types';
  static const calculationHistories = '/v1/calculation-histories';

  static String calculationHistory(String id) => '$calculationHistories/$id';
  static String user(String id) => '/v1/users/$id';
}
