import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/card_container_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/custom_app_bar.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/drop_down_form_field.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class CalculatorScreen extends StatelessWidget {
  static const screenName = '/calculator';
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      appBar: CustomAppBar(
        title: l10n.calculate,
        leadingIcon: Icons.precision_manufacturing_outlined,
      ),
      body: const _CalculatorScreenView(),
    );
  }
}

class _CalculatorScreenView extends StatelessWidget {
  const _CalculatorScreenView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 22,
        children: [
          Text(
            l10n.haulageSimulation,
            style: theme.textTheme.bodySmall
          ),
          Text(
            l10n.newCalculation,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          const _GeneralInformationForm(),
          const _OperationInformationForm(),
          const _CoastAnalysisForm(),
          AppButtonWidget(
            label: l10n.calculateFleetAndCycle,
            onPressed: () {},
            trailingIcon: Icons.speed,
            icon: Icons.arrow_forward,
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}

class _GeneralInformationForm extends StatelessWidget {
  const _GeneralInformationForm();

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
              AppSimpleIcon(action: AppIconAction.map),
              Text(
                l10n.generalData,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              AppBadgeWidget(
                label: l10n.optional,
                showDot: false,
              )
            ],
          ),
          Form(
            child: Column(
              spacing: 12,
              children: [
                AppTextFormField(
                  label: l10n.miningProject,
                  hintText: l10n.transportRoute,
                  suffixIcon: AppSimpleIcon(action: AppIconAction.apartment),
                  onChanged: (value) {},
                ),
                AppTextFormField(
                  label: l10n.transportRoute,
                  hintText: l10n.transportRoute,
                  suffixIcon: AppSimpleIcon(action: AppIconAction.allRoute),
                  onChanged: (value) {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OperationInformationForm extends StatelessWidget {
  const _OperationInformationForm();

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
              AppSimpleIcon(action: AppIconAction.truck),
              Text(
                l10n.operationParameters,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Form(
            child: Column(
              spacing: 12,
              children: [
                DropdownFormField<String>(
                  label: l10n.inSituMaterial,
                  hintText: l10n.selectMaterial,
                  prefixIcon: Icons.layers_outlined,
                  items: const [
                    DropdownMenuItem(
                      value: '1.85',
                      child: Text('Grava / Roca Fragmentada - 1.85 t/m³'),
                    ),
                    DropdownMenuItem(
                      value: '2.10',
                      child: Text('Sulfuros Pesados / Cobre - 2.10 t/m³'),
                    ),
                    DropdownMenuItem(
                      value: '1.60',
                      child: Text('Estéril de Desbroce / Andesita - 1.60 t/m³'),
                    ),
                  ],
                  onChanged: (newValue) {},
                ),
                DropdownFormField<String>(
                  label: l10n.haulageUnit,
                  hintText: l10n.selectUnit,
                  prefixIcon: Icons.layers_outlined,
                  items: const [
                    DropdownMenuItem(
                      value: '1.85',
                      child: Text('Grava / Roca Fragmentada - 1.85 t/m³'),
                    ),
                    DropdownMenuItem(
                      value: '2.10',
                      child: Text('Sulfuros Pesados / Cobre - 2.10 t/m³'),
                    ),
                    DropdownMenuItem(
                      value: '1.60',
                      child: Text('Estéril de Desbroce / Andesita - 1.60 t/m³'),
                    ),
                  ],
                  onChanged: (newValue) {},
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.outboundDistance,
                        hintText: '4.2',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ),
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.loadingYield,
                        hintText: '450',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.loadedSpeed,
                        hintText: '24',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ),
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.returnSpeed,
                        hintText: '38',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.shiftHours,
                        hintText: '8.0',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ),
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.efficiency,
                        hintText: '0.85',
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CoastAnalysisForm extends StatelessWidget {
  const _CoastAnalysisForm();

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
              Column(
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
            ],
          ),
        ],
      ),
    );
  }
}
