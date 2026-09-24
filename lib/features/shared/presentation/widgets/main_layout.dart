import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_calculator/features/shared/presentation/providers/locale_provider.dart';
import 'package:vehicle_calculator/features/shared/presentation/providers/theme_provider.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_nav_bottom_bar.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';

class MainLayout extends StatelessWidget {
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
  Widget build(BuildContext context) {
    context.watch<LocaleProvider>();
    context.watch<ThemeProvider>();

    return AppScaffold(
      body: navigationShell,
      bodyPadding: EdgeInsets.zero,
      bottomNavigationBar: AppNavBottomBar(
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }
}
