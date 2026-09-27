import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/presentation/utils/result_number_format.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/card_container_widget.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class CalculationHistoryItem extends StatelessWidget {
  const CalculationHistoryItem({
    super.key,
    required this.calculation,
    required this.onTap,
  });

  final CalculationHistory calculation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final colorScheme = theme.colorScheme;
    final title = calculation.projectName?.trim().isNotEmpty == true
        ? calculation.projectName!
        : l10n.untitledCalculation;
    final details = [
      if (calculation.section?.trim().isNotEmpty == true) calculation.section,
      DateFormat.yMMMd(Localizations.localeOf(context).toString())
          .add_Hm()
          .format(calculation.createdAt.toLocal()),
    ].join(' • ');

    return GestureDetector(
      onTap: onTap,
      child: CardContainerWidget(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Row(
              children: [
                AppSimpleIcon(action: AppIconAction.history, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        details,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.outline,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _HistoryMetric(
                    label: l10n.dumpTrucks,
                    value: ResultNumberFormat.count(
                      calculation.suggestedTrucksCount,
                    ),
                  ),
                ),
                Expanded(
                  child: _HistoryMetric(
                    label: l10n.unitM3,
                    value: ResultNumberFormat.decimal(
                      context,
                      calculation.totalVolumeTransportedM3,
                    ),
                  ),
                ),
                Expanded(
                  child: _HistoryMetric(
                    label: l10n.unitMinutes,
                    value: ResultNumberFormat.decimal(
                      context,
                      calculation.cycleTimeMinutes,
                      maxDecimals: 2,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryMetric extends StatelessWidget {
  const _HistoryMetric({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
