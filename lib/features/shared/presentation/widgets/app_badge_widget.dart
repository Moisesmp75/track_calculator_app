import 'package:flutter/material.dart';

enum AppBadgeStatus { active, info, role, neutral, inactive, highlight }

class AppBadgeWidget extends StatelessWidget {
  final String label;
  final AppBadgeStatus status;
  final bool showDot;

  const AppBadgeWidget({
    super.key,
    required this.label,
    this.status = AppBadgeStatus.neutral,
    this.showDot = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color bgColor;
    Color fgColor;

    switch (status) {
      case AppBadgeStatus.active:
        bgColor = colorScheme.primaryContainer;
        fgColor = colorScheme.onPrimary;
        break;
      case AppBadgeStatus.info:
        bgColor = colorScheme.onInverseSurface;
        fgColor = colorScheme.primary;
        break;
      case AppBadgeStatus.role:
        bgColor = colorScheme.secondaryContainer;
        fgColor = colorScheme.primary;
        break;
      case AppBadgeStatus.inactive:
        bgColor = colorScheme.surfaceContainerHigh;
        fgColor = colorScheme.outline;
        break;
      case AppBadgeStatus.highlight:
        bgColor = colorScheme.errorContainer;
        fgColor = colorScheme.error;
        break;
      case AppBadgeStatus.neutral:
        bgColor = colorScheme.surfaceContainerLow;
        fgColor = colorScheme.onSurfaceVariant;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showDot) ...[
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(color: fgColor, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: fgColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
