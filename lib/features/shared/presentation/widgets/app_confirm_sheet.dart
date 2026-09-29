import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';

Future<bool> showAppConfirmSheet({
  required BuildContext context,
  required String title,
  required String message,
  required String confirmLabel,
  required String cancelLabel,
}) async {
  final confirmed = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (sheetContext) {
      return _AppConfirmSheet(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
      );
    },
  );
  return confirmed == true;
}

class _AppConfirmSheet extends StatelessWidget {
  const _AppConfirmSheet({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Center(
                  child: Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                Row(
                  spacing: 12,
                  children: [
                    AppSimpleIcon(
                      action: AppIconAction.warning,
                      color: colorScheme.error,
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  message,
                  style: theme.textTheme.bodyMedium,
                ),
                AppButtonWidget(
                  label: confirmLabel,
                  variant: AppButtonVariant.danger,
                  trailingIcon: Icons.delete_outline,
                  onPressed: () => Navigator.of(context).pop(true),
                ),
                AppButtonWidget(
                  label: cancelLabel,
                  variant: AppButtonVariant.outline,
                  onPressed: () => Navigator.of(context).pop(false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
