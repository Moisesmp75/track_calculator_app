import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/card_container_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/custom_app_bar.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class ResultDetailScreen extends StatelessWidget {
  static const screenName = '/result-detail';

  const ResultDetailScreen({super.key, this.result});

  final CalculationHistory? result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final calculation = result;

    return AppScaffold(
      appBar: CustomAppBar(title: l10n.resultDetail),
      body: calculation == null
          ? Center(
              child: Text(
                l10n.missingCalculationResult,
                style: theme.textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  _ResultHeader(calculation: calculation),
                  _FleetCard(calculation: calculation),
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: l10n.totalProduction,
                          icon: Icons.dataset_outlined,
                          value: _formatNumber(
                            context,
                            calculation.totalVolumeTransportedM3,
                          ),
                          unit: l10n.unitM3,
                          caption: l10n.perShiftHours(
                            _formatNumber(context, calculation.shiftHours),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _StatCard(
                          label: l10n.yieldLabel,
                          icon: Icons.trending_up_rounded,
                          value: _formatNumber(
                            context,
                            calculation.hourlyPerformanceM3h,
                          ),
                          unit: l10n.unitM3h,
                          caption: l10n.hourlyCapacity,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: _StatCard(
                          label: l10n.cycleTime,
                          icon: Icons.schedule_outlined,
                          value: _formatNumber(
                            context,
                            calculation.cycleTimeMinutes,
                            maxDecimals: 2,
                          ),
                          unit: l10n.unitMinutes,
                          caption: l10n.cycleTimeCaption,
                        ),
                      ),
                      Expanded(
                        child: _StatCard(
                          label: l10n.unitCost,
                          icon: Icons.payments_outlined,
                          value: calculation.hasUnitCost
                              ? _formatNumber(
                                  context,
                                  calculation.unitCostPerM3!,
                                  maxDecimals: 2,
                                )
                              : '—',
                          caption: l10n.perM3Hauled,
                        ),
                      ),
                    ],
                  ),
                  _BreakdownCard(calculation: calculation),
                  AppButtonWidget(
                    label: l10n.modifyParameters,
                    variant: AppButtonVariant.outline,
                    trailingIcon: Icons.edit_outlined,
                    onPressed: () => context.pop(),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
    );
  }
}

class _ResultHeader extends StatelessWidget {
  const _ResultHeader({required this.calculation});

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

class _FleetCard extends StatelessWidget {
  const _FleetCard({required this.calculation});

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
                        text: _formatCount(calculation.suggestedTrucksCount),
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

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.icon,
    required this.value,
    required this.caption,
    this.unit,
  });

  final String label;
  final IconData icon;
  final String value;
  final String caption;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return CardContainerWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 18, color: colorScheme.outline),
            ],
          ),
          Text.rich(
            TextSpan(
              text: value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              children: [
                if (unit != null)
                  TextSpan(
                    text: ' $unit',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            caption,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _BreakdownCard extends StatefulWidget {
  const _BreakdownCard({required this.calculation});

  final CalculationHistory calculation;

  @override
  State<_BreakdownCard> createState() => _BreakdownCardState();
}

class _BreakdownCardState extends State<_BreakdownCard> {
  var _isExpanded = true;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final calculation = widget.calculation;
    final swellPercent =
        ((calculation.calculatedSwellFactor - 1) * 100).clamp(0, 999);

    return CardContainerWidget(
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Row(
              children: [
                AppSimpleIcon(action: AppIconAction.tune, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    l10n.operationalBreakdown,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Icon(
                  _isExpanded
                      ? Icons.expand_less_rounded
                      : Icons.expand_more_rounded,
                  color: theme.colorScheme.outline,
                ),
              ],
            ),
          ),
          if (_isExpanded) ...[
            const SizedBox(height: 4),
            _BreakdownRow(
              icon: Icons.layers_outlined,
              label: l10n.swellFactorLabel,
              value: l10n.swellFactorValue(
                _formatNumber(
                  context,
                  calculation.calculatedSwellFactor,
                  maxDecimals: 3,
                ),
                _formatNumber(context, swellPercent.toDouble(), maxDecimals: 0),
              ),
            ),
            _BreakdownRow(
              icon: Icons.inventory_2_outlined,
              label: l10n.effectiveHopperCapacity,
              value:
                  '${_formatNumber(context, calculation.effectiveCapacityM3)} ${l10n.unitM3}',
            ),
            _BreakdownRow(
              icon: Icons.sync_outlined,
              label: l10n.tripsPerUnit,
              value:
                  '${_formatNumber(context, calculation.tripsPerShiftPerTruck)} ${l10n.tripsUnit}',
            ),
          ],
        ],
      ),
    );
  }
}

class _BreakdownRow extends StatelessWidget {
  const _BreakdownRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 18, color: colorScheme.outline),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label, style: theme.textTheme.bodyMedium),
          ),
          Text(
            value,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

String _formatNumber(
  BuildContext context,
  double value, {
  int maxDecimals = 1,
}) {
  final format = NumberFormat.decimalPattern(
    Localizations.localeOf(context).toString(),
  )..maximumFractionDigits = maxDecimals;
  return format.format(value);
}

String _formatCount(double value) {
  if (value == value.roundToDouble()) {
    return value.toStringAsFixed(0);
  }
  return value.toStringAsFixed(1);
}
