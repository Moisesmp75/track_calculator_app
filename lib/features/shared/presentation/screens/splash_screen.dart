import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/core/di/core_providers.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/login_screen.dart';
import 'package:vehicle_calculator/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:vehicle_calculator/features/calculate/presentation/screens/calculator_screen.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_logo.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const screenName = '/splash-screen';

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _restore());
  }

  Future<void> _restore() async {
    unawaited(ref.read(interstitialAdControllerProvider).preload());
    final isAuthenticated =
        await ref.read(authViewModelProvider.notifier).restoreSession();
    if (!mounted) return;

    context.goNamed(
      isAuthenticated ? CalculatorScreen.screenName : LoginScreen.screenName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 24,
          children: [
            const AppLogo(),
            CircularProgressIndicator(color: colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
