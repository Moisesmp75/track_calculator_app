import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, outline, danger }

class AppButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final AppButtonVariant variant;
  final IconData? icon;
  final IconData? trailingIcon;
  final double height;
  final bool isLoading;
  final bool enabled;

  const AppButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.trailingIcon,
    this.height = 56.0,
    this.isLoading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color bgColor;
    Color fgColor;
    BorderSide borderSide = BorderSide.none;

    switch (variant) {
      case AppButtonVariant.primary:
        bgColor = colorScheme.primary;
        fgColor = colorScheme.onPrimary;
        break;
      case AppButtonVariant.secondary:
        bgColor = colorScheme.secondaryContainer;
        fgColor = colorScheme.onSecondaryContainer;
        break;
      case AppButtonVariant.outline:
        bgColor = colorScheme.surface;
        fgColor = colorScheme.onSurface;
        borderSide = BorderSide(color: colorScheme.outline);
        break;
      case AppButtonVariant.danger:
        bgColor = colorScheme.errorContainer;
        fgColor = colorScheme.onErrorContainer;
        break;
    }

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: variant == AppButtonVariant.primary ? 2 : 0,
          side: borderSide,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: (isLoading || !enabled) ? null : onPressed,
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  color: fgColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (trailingIcon != null) ...[
                    Icon(trailingIcon, size: 20, color: fgColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: fgColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(icon, size: 20, color: fgColor),
                  ],
                ],
              ),
      ),
    );
  }
}
