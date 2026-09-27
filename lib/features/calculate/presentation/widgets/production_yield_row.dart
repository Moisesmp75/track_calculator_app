import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/presentation/utils/result_number_format.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/result_stat_card.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class ProductionYieldRow extends StatelessWidget {
  const ProductionYieldRow({super.key, required this.calculation});

  final CalculationHistory calculation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: ResultStatCard(
            label: l10n.totalProduction,
            icon: Icons.dataset_outlined,
            value: ResultNumberFormat.decimal(
              context,
              calculation.totalVolumeTransportedM3,
            ),
            unit: l10n.unitM3,
            caption: l10n.perShiftHours(
              ResultNumberFormat.decimal(context, calculation.shiftHours),
            ),
          ),
        ),
        Expanded(
          child: ResultStatCard(
            label: l10n.yieldLabel,
            icon: Icons.trending_up_rounded,
            value: ResultNumberFormat.decimal(
              context,
              calculation.hourlyPerformanceM3h,
            ),
            unit: l10n.unitM3h,
            caption: l10n.hourlyCapacity,
          ),
        ),
      ],
    );
  }
}
