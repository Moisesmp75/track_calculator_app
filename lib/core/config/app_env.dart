import 'package:vehicle_calculator/core/config/app_config.dart';

class AppEnv {
  static AppEnvironment get flavor => AppConfig.environment;

  static bool get isProd => AppConfig.isProd;

  /// HTTP logs include bodies and headers (tokens, passwords). Never in prod.
  static bool get enableHttpLogs => AppConfig.enableHttpLogs;
}
