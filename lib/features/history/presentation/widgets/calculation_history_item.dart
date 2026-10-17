import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/presentation/utils/result_number_format.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/result_section_tone.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class CalculationHistoryItem extends StatelessWidget {
  const CalculationHistoryItem({
    super.key,
    required this.calculation,
    required this.onTap,
    required this.onDelete,
  });

  final CalculationHistory calculation;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final colorScheme = theme.colorScheme;
    final fleet = ResultSectionTone.fleet.colorsOf(theme.brightness);
    final title = calculation.projectName?.trim().isNotEmpty == true
        ? calculation.projectName!
        : l10n.untitledCalculation;
    final details = [
      if (calculation.section?.trim().isNotEmpty == true) calculation.section,
      DateFormat.yMMMd(Localizations.localeOf(context).toString())
          .add_Hm()
          .format(calculation.createdAt.toLocal()),
    ].join(' • ');

    return Slidable(
      key: ValueKey(calculation.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.28,
        children: [
          SlidableAction(
            onPressed: (_) => onDelete(),
            backgroundColor: colorScheme.error,
            foregroundColor: colorScheme.onError,
            icon: Icons.delete_outline,
            borderRadius: BorderRadius.circular(16),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 14,
              children: [
                Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: fleet.header,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.local_shipping_outlined,
                        color: fleet.onHeader,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
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
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8,
                    children: [
                      Expanded(
                        child: _HistoryMetric(
                          tone: ResultSectionTone.fleet,
                          label: l10n.dumpTrucks,
                          value: ResultNumberFormat.count(
                            calculation.suggestedTrucksCount,
                          ),
                        ),
                      ),
                      Expanded(
                        child: _HistoryMetric(
                          tone: ResultSectionTone.production,
                          label: l10n.totalProduction,
                          value: ResultNumberFormat.decimal(
                            context,
                            calculation.totalVolumeTransportedM3,
                          ),
                          unit: l10n.unitM3,
                        ),
                      ),
                      Expanded(
                        child: _HistoryMetric(
                          tone: ResultSectionTone.cycle,
                          label: l10n.cycleTime,
                          value: ResultNumberFormat.decimal(
                            context,
                            calculation.cycleTimeMinutes,
                            maxDecimals: 2,
                          ),
                          unit: l10n.unitMinutes,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HistoryMetric extends StatelessWidget {
  const _HistoryMetric({
    required this.tone,
    required this.label,
    required this.value,
    this.unit,
  });

  final ResultSectionTone tone;
  final String label;
  final String value;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = tone.colorsOf(theme.brightness);

    return Container(
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              constraints: const BoxConstraints(minHeight: 42),
              color: colors.header,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
              alignment: Alignment.center,
              child: Text(
                label.toUpperCase(),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: colors.onHeader,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 10, 6, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      value,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colors.foreground,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                    if (unit != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        unit!,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colors.muted,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
