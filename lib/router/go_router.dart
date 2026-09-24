import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/login_screen.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/register_screen.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/restore_password.dart';
import 'package:vehicle_calculator/features/shared/presentation/screens/splash_screen.dart';

final goRouter = GoRouter(
  routes: [
    GoRoute(
      name: SplashScreen.screenName,
      path: SplashScreen.screenName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      name: LoginScreen.screenName,
      // path: LoginScreen.screenName,
      path: '/',
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
  ],
);
