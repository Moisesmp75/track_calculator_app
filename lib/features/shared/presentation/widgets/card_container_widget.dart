import 'package:flutter/material.dart';

class CardContainerWidget extends StatelessWidget {
  const CardContainerWidget({super.key, required this.child, this.color});
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? theme.colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color ?? theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: child,
    );
  }
}
