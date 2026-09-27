import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/presentation/utils/result_number_format.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/card_container_widget.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class FleetCard extends StatelessWidget {
  const FleetCard({super.key, required this.calculation});

  final CalculationHistory calculation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CardContainerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.requiredFleet.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text.rich(
                      TextSpan(
                        text: ResultNumberFormat.count(
                          calculation.suggestedTrucksCount,
                        ),
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                        children: [
                          TextSpan(
                            text: ' ${l10n.dumpTrucks}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              AppSimpleIcon(action: AppIconAction.truck, size: 28),
            ],
          ),
          Row(
            spacing: 8,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 18,
                color: colorScheme.primary,
              ),
              Expanded(
                child: Text(
                  l10n.fleetBalanceHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
