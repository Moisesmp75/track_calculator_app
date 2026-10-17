import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class ResultHeader extends StatelessWidget {
  const ResultHeader({super.key, required this.calculation});

  final CalculationHistory calculation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final location = [
      if (calculation.projectName?.isNotEmpty == true) calculation.projectName,
      if (calculation.section?.isNotEmpty == true) calculation.section,
    ].join(' • ');

    return Row(
      children: [
        AppBadgeWidget(
          label: l10n.simulationCompleted,
          status: AppBadgeStatus.active,
        ),
        if (location.isNotEmpty) ...[
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              location,
              textAlign: TextAlign.end,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
