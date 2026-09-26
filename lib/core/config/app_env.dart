import 'package:flutter/foundation.dart';

class AppEnv {
  static const flavor = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  static bool get isProd => flavor == 'prod' || kReleaseMode;

  /// HTTP logs include bodies and headers (tokens, passwords). Never in prod.
  static bool get enableHttpLogs => !isProd;
}
