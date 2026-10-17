import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_calculator/core/ads/interstitial_ad_controller.dart';
import 'package:vehicle_calculator/core/config/api_config.dart';
import 'package:vehicle_calculator/core/config/app_env.dart';
import 'package:vehicle_calculator/core/network/api_client.dart';
import 'package:vehicle_calculator/core/storage/token_storage.dart';
import 'package:vehicle_calculator/features/shared/presentation/viewmodels/locale_view_model.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Override sharedPreferencesProvider in main.');
});

final packageInfoProvider = Provider<PackageInfo>((ref) {
  throw UnimplementedError('Override packageInfoProvider in main.');
});

final interstitialAdControllerProvider = Provider<InterstitialAdController>((
  ref,
) {
  final controller = InterstitialAdController();
  ref.onDispose(controller.dispose);
  return controller;
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage(ref.watch(sharedPreferencesProvider));
});

final dioLogInterceptorProvider = Provider<PrettyDioLogger>((ref) {
  return PrettyDioLogger(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: false,
    responseBody: true,
    error: true,
    compact: true,
    maxWidth: 90,
  );
});

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: const {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
    ),
  );
});

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    languageCode: () => ref.read(localeViewModelProvider).languageCode,
    tokenStorage: ref.watch(tokenStorageProvider),
    dio: ref.watch(dioProvider),
    logInterceptor: AppEnv.enableHttpLogs
        ? ref.watch(dioLogInterceptorProvider)
        : null,
  );
});
