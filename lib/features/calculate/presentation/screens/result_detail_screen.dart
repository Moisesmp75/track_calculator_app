import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/presentation/models/result_detail_args.dart';
import 'package:vehicle_calculator/features/calculate/presentation/utils/result_number_format.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/breakdown_header.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/breakdown_row.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/cycle_cost_row.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/fleet_card.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/modify_parameters_button.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/production_yield_row.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/result_empty_state.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/result_header.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/card_container_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/custom_app_bar.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class ResultDetailScreen extends StatelessWidget {
  static const screenName = '/result-detail';

  const ResultDetailScreen({
    super.key,
    this.result,
    this.canModifyParameters = false,
  });

  final CalculationHistory? result;
  final bool canModifyParameters;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AppScaffold(
      appBar: CustomAppBar(title: l10n.resultDetail),
      body: result == null
          ? const ResultEmptyState()
          : _ResultContent(
              calculation: result!,
              canModifyParameters: canModifyParameters,
            ),
    );
  }
}

class _ResultContent extends StatelessWidget {
  const _ResultContent({
    required this.calculation,
    required this.canModifyParameters,
  });

  final CalculationHistory calculation;
  final bool canModifyParameters;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 16,
        children: [
          ResultHeader(calculation: calculation),
          FleetCard(calculation: calculation),
          ProductionYieldRow(calculation: calculation),
          CycleCostRow(calculation: calculation),
          _BreakdownCard(calculation: calculation),
          if (canModifyParameters)
            ModifyParametersButton(
              onPressed: () => context.pop(ResultPopAction.keepForm),
            ),
          const SizedBox(height: 10),
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
    final calculation = widget.calculation;
    final swellPercent =
        ((calculation.calculatedSwellFactor - 1) * 100).clamp(0, 999);

    return CardContainerWidget(
      child: Column(
        children: [
          BreakdownHeader(
            isExpanded: _isExpanded,
            onTap: () => setState(() => _isExpanded = !_isExpanded),
          ),
          if (_isExpanded) ...[
            const SizedBox(height: 4),
            BreakdownRow(
              icon: Icons.layers_outlined,
              label: l10n.swellFactorLabel,
              value: l10n.swellFactorValue(
                ResultNumberFormat.decimal(
                  context,
                  calculation.calculatedSwellFactor,
                  maxDecimals: 3,
                ),
                ResultNumberFormat.decimal(
                  context,
                  swellPercent.toDouble(),
                  maxDecimals: 0,
                ),
              ),
            ),
            BreakdownRow(
              icon: Icons.inventory_2_outlined,
              label: l10n.effectiveHopperCapacity,
              value:
                  '${ResultNumberFormat.decimal(context, calculation.effectiveCapacityM3)} ${l10n.unitM3}',
            ),
            BreakdownRow(
              icon: Icons.sync_outlined,
              label: l10n.tripsPerUnit,
              value:
                  '${ResultNumberFormat.decimal(context, calculation.tripsPerShiftPerTruck)} ${l10n.tripsUnit}',
            ),
          ],
        ],
      ),
    );
  }
}
