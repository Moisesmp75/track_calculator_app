import 'package:flutter/material.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class ResultEmptyState extends StatelessWidget {
  const ResultEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Center(
      child: Text(
        l10n.missingCalculationResult,
        style: theme.textTheme.bodyLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
