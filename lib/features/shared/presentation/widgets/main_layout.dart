import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/shared/presentation/viewmodels/locale_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/viewmodels/theme_view_model.dart';
import 'package:vehicle_calculator/core/config/app_config.dart';
import 'package:vehicle_calculator/features/ads/presentation/widgets/app_adaptive_banner.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_nav_bottom_bar.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';

class MainLayout extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;

  const MainLayout({
    super.key,
    required this.navigationShell,
  });

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localeViewModelProvider);
    ref.watch(themeViewModelProvider);

    final showBanner =
        AppConfig.adsEnabled && navigationShell.currentIndex != 2;

    return AppScaffold(
      body: navigationShell,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showBanner) const AppAdaptiveBanner(),
          AppNavBottomBar(
            currentIndex: navigationShell.currentIndex,
            onTap: _onTap,
          ),
        ],
      ),
    );
  }
}
