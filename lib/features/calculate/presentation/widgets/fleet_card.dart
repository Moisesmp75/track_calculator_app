import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/presentation/utils/result_number_format.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/result_accent_card.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/result_section_tone.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class FleetCard extends StatelessWidget {
  const FleetCard({super.key, required this.calculation});

  final CalculationHistory calculation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final colors = ResultSectionTone.fleet.colorsOf(theme.brightness);

    return ResultAccentCard(
      tone: ResultSectionTone.fleet,
      header: Row(
        children: [
          Expanded(child: Text(l10n.requiredFleet.toUpperCase())),
          const SizedBox(width: 8),
          const Icon(Icons.local_shipping_outlined, size: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text.rich(
            TextSpan(
              text: ResultNumberFormat.count(calculation.suggestedTrucksCount),
              style: theme.textTheme.displaySmall?.copyWith(
                color: colors.foreground,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
              children: [
                TextSpan(
                  text: ' ${l10n.dumpTrucks}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colors.foreground,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: 8,
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 18,
                color: colors.foreground,
              ),
              Expanded(
                child: Text(
                  l10n.fleetBalanceHint,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.muted,
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
