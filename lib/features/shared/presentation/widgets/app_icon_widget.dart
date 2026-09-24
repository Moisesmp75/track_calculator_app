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

  IconData _getIconData() {
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
    }
  }

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
          _getIconData(),
          color: effectiveIconColor,
          size: size * 0.5,
        ),
      ),
    );
  }
}
