import 'package:flutter/material.dart';

enum AppIconAction {
  truck,
  geology,
  cycleTime,
  delete,
  edit,
  lock,
  back,
  profile,
  check,
  allRoute,
  map,
  apartment,
  precisionManufacturing,
  localShipping,
  expandMore,
  payments,
  info,
  speed,
  arrowForward,
  checkCircle,
  calculate,
  history,
  tune,
  school,
  verified,
  badge,
  chevronRight,
  language,
  translate,
  lightMode,
  darkMode,
  schedule,
  lockReset,
  logout,
  warning,
  refresh
}

IconData _getIconData(AppIconAction action) {
  switch (action) {
    case AppIconAction.truck:
      return Icons.local_shipping_outlined;
    case AppIconAction.geology:
      return Icons.layers_outlined;
    case AppIconAction.cycleTime:
      return Icons.timer_outlined;
    case AppIconAction.delete:
      return Icons.delete_outline;
    case AppIconAction.edit:
      return Icons.edit_outlined;
    case AppIconAction.lock:
      return Icons.lock_outline;
    case AppIconAction.back:
      return Icons.arrow_back;
    case AppIconAction.profile:
      return Icons.person_outline;
    case AppIconAction.check:
      return Icons.check_circle_outline;
    case AppIconAction.allRoute:
      return Icons.route_outlined;
    case AppIconAction.map:
      return Icons.map_outlined;
    case AppIconAction.apartment:
      return Icons.apartment_outlined;
    case AppIconAction.precisionManufacturing:
      return Icons.precision_manufacturing_outlined;
    case AppIconAction.localShipping:
      return Icons.local_shipping_outlined;
    case AppIconAction.expandMore:
      return Icons.expand_more_outlined;
    case AppIconAction.payments:
      return Icons.payments_outlined;
    case AppIconAction.info:
      return Icons.info_outline;
    case AppIconAction.speed:
      return Icons.speed_outlined;
    case AppIconAction.arrowForward:
      return Icons.arrow_forward_outlined;
    case AppIconAction.checkCircle:
      return Icons.check_circle_outline;
    case AppIconAction.calculate:
      return Icons.calculate_outlined;
    case AppIconAction.history:
      return Icons.history_outlined;
    case AppIconAction.tune:
      return Icons.tune_outlined;
    case AppIconAction.school:
      return Icons.school_outlined;
    case AppIconAction.verified:
      return Icons.verified_outlined;
    case AppIconAction.badge:
      return Icons.badge_outlined;
    case AppIconAction.chevronRight:
      return Icons.chevron_right_outlined;
    case AppIconAction.language:
      return Icons.language_outlined;
    case AppIconAction.translate:
      return Icons.translate_outlined;
    case AppIconAction.lightMode:
      return Icons.light_mode_outlined;
    case AppIconAction.darkMode:
      return Icons.dark_mode_outlined;
    case AppIconAction.schedule:
      return Icons.schedule_outlined;
    case AppIconAction.lockReset:
      return Icons.lock_reset_outlined;
    case AppIconAction.logout:
      return Icons.logout_outlined;
    case AppIconAction.warning:
      return Icons.warning_amber_outlined;
    case AppIconAction.refresh:
      return Icons.refresh;
  }
}

class AppIconWidget extends StatelessWidget {
  final AppIconAction action;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final VoidCallback? onTap;

  const AppIconWidget({
    super.key,
    required this.action,
    this.backgroundColor,
    this.iconColor,
    this.size = 48.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveBgColor = backgroundColor ?? colorScheme.primaryContainer;
    final effectiveIconColor = iconColor ?? colorScheme.onPrimary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: effectiveBgColor,
          shape: BoxShape.circle,
        ),
        child: Icon(
          _getIconData(action),
          color: effectiveIconColor,
          size: size * 0.5,
        ),
      ),
    );
  }
}

class AppSimpleIcon extends StatelessWidget {
  final AppIconAction action;
  final Color? color;
  final double size;
  final VoidCallback? onTap;

  const AppSimpleIcon({
    super.key,
    required this.action,
    this.color,
    this.size = 24.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveColor = color ?? colorScheme.primary;

    return Icon(
      _getIconData(action),
      color: effectiveColor,
      size: size,
    );
  }
}