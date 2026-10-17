import 'package:flutter/material.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class CalculatorViewHeader extends StatelessWidget {
  const CalculatorViewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(l10n.haulageSimulation, style: theme.textTheme.bodyMedium),
        Text(
          l10n.newCalculation,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
