import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/features/calculate/presentation/viewmodels/catalog_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/extensions/snackbar_extension.dart';
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
            style: theme.textTheme.bodyMedium
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

class _OperationInformationForm extends ConsumerStatefulWidget {
  const _OperationInformationForm();

  @override
  ConsumerState<_OperationInformationForm> createState() =>
      _OperationInformationFormState();
}

class _OperationInformationFormState
    extends ConsumerState<_OperationInformationForm> {
  String? _materialId;
  String? _dumpTruckTypeId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final catalog = ref.watch(catalogViewModelProvider);

    ref.listen(catalogViewModelProvider, (previous, next) {
      final message = next.errorMessage;
      if (message != null && message != previous?.errorMessage) {
        context.showSnackBar(message: message);
      }
    });

    final materialItems = catalog.materials
        .map(
          (material) => DropdownMenuItem(
            value: material.id,
            child: Text(material.label, overflow: TextOverflow.ellipsis),
          ),
        )
        .toList();
    final truckItems = catalog.dumpTruckTypes
        .map(
          (truck) => DropdownMenuItem(
            value: truck.id,
            child: Text(truck.label, overflow: TextOverflow.ellipsis),
          ),
        )
        .toList();

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
              if (catalog.isLoading) ...[
                const Spacer(),
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ],
            ],
          ),
          Form(
            child: Column(
              spacing: 12,
              children: [
                DropdownFormField<String>(
                  key: ValueKey('materials-${catalog.materials.length}'),
                  label: l10n.inSituMaterial,
                  hintText: l10n.selectMaterial,
                  prefixIcon: Icons.layers_outlined,
                  enabled: !catalog.isLoading && materialItems.isNotEmpty,
                  value: _materialId,
                  items: materialItems,
                  onChanged: (newValue) {
                    setState(() => _materialId = newValue);
                  },
                ),
                DropdownFormField<String>(
                  key: ValueKey('trucks-${catalog.dumpTruckTypes.length}'),
                  label: l10n.haulageUnit,
                  hintText: l10n.selectUnit,
                  prefixIcon: Icons.layers_outlined,
                  enabled: !catalog.isLoading && truckItems.isNotEmpty,
                  value: _dumpTruckTypeId,
                  items: truckItems,
                  onChanged: (newValue) {
                    setState(() => _dumpTruckTypeId = newValue);
                  },
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
