import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_calculator/core/di/core_providers.dart';
import 'package:vehicle_calculator/features/shared/presentation/viewmodels/locale_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/viewmodels/theme_view_model.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';
import 'package:vehicle_calculator/router/go_router.dart';
import 'package:vehicle_calculator/theme/dark_theme.dart';
import 'package:vehicle_calculator/theme/light_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final packageInfo = await PackageInfo.fromPlatform();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
        packageInfoProvider.overrideWithValue(packageInfo),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeViewModelProvider);
    final locale = ref.watch(localeViewModelProvider);

    return MaterialApp.router(
      title: 'SmartHaul',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
