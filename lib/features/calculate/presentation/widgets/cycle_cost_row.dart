import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/presentation/utils/result_number_format.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/result_stat_card.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class CycleCostRow extends StatelessWidget {
  const CycleCostRow({super.key, required this.calculation});

  final CalculationHistory calculation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: ResultStatCard(
            label: l10n.cycleTime,
            icon: Icons.schedule_outlined,
            value: ResultNumberFormat.decimal(
              context,
              calculation.cycleTimeMinutes,
              maxDecimals: 2,
            ),
            unit: l10n.unitMinutes,
            caption: l10n.cycleTimeCaption,
          ),
        ),
        Expanded(
          child: ResultStatCard(
            label: l10n.unitCost,
            icon: Icons.payments_outlined,
            value: calculation.hasUnitCost
                ? ResultNumberFormat.decimal(
                    context,
                    calculation.unitCostPerM3!,
                    maxDecimals: 2,
                  )
                : '—',
            caption: l10n.perM3Hauled,
          ),
        ),
      ],
    );
  }
}
