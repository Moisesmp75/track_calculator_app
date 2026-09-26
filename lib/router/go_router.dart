import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/login_screen.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/register_screen.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/restore_password.dart';
import 'package:vehicle_calculator/features/calculate/presentation/screens/calculator_screen.dart';
import 'package:vehicle_calculator/features/history/presentation/screens/calculation_history_screen.dart';
import 'package:vehicle_calculator/features/settings/presentation/screens/profile_settings_screen.dart';
import 'package:vehicle_calculator/features/shared/presentation/screens/splash_screen.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/main_layout.dart';

final goRouter = GoRouter(
  initialLocation: SplashScreen.screenName,
  routes: [
    GoRoute(
      name: SplashScreen.screenName,
      path: SplashScreen.screenName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: LoginScreen.screenName,
      path: LoginScreen.screenName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: RegisterScreen.screenName,
      path: RegisterScreen.screenName,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: RestorePassword.screenName,
      path: RestorePassword.screenName,
      builder: (context, state) => const RestorePassword(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainLayout(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: CalculatorScreen.screenName,
              name: CalculatorScreen.screenName,
              builder: (context, state) => const CalculatorScreen(),
            )
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: CalculationHistoryScreen.screenName,
              name: CalculationHistoryScreen.screenName,
              builder: (context, state) => const CalculationHistoryScreen(),
            )
          ]
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: ProfileSettingsScreen.screenName,
              name: ProfileSettingsScreen.screenName,
              builder: (context, state) => const ProfileSettingsScreen(),
            )
          ]
        )
      ],
    )
  ],
);
