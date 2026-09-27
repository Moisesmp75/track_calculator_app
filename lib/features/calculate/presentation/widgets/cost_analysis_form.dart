import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/numeric_field_pair.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/card_container_widget.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class CostAnalysisForm extends StatelessWidget {
  const CostAnalysisForm({
    super.key,
    required this.dumpTruckRateController,
    required this.loaderRateController,
    required this.staffRateController,
  });

  final TextEditingController dumpTruckRateController;
  final TextEditingController loaderRateController;
  final TextEditingController staffRateController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return CardContainerWidget(
      child: Column(
        spacing: 12,
        children: [
          Row(
            spacing: 12,
            children: [
              AppSimpleIcon(action: AppIconAction.payments),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.costAnalysis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      l10n.estimateUnitRatios,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              AppBadgeWidget(
                label: l10n.optional,
                showDot: false,
              ),
            ],
          ),
          Form(
            child: Column(
              spacing: 12,
              children: [
                NumericFieldPair(
                  leftLabel: l10n.dumpTruckHourlyRate,
                  leftHint: '180',
                  leftController: dumpTruckRateController,
                  leftSuffix: l10n.unitPerHour,
                  rightLabel: l10n.loaderHourlyRate,
                  rightHint: '250',
                  rightController: loaderRateController,
                  rightSuffix: l10n.unitPerHour,
                ),
                AppTextFormField(
                  label: l10n.staffHourlyRate,
                  hintText: '45',
                  controller: staffRateController,
                  suffixText: l10n.unitPerHour,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
