import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/features/calculate/presentation/models/operation_parameter_presets.dart';
import 'package:vehicle_calculator/features/calculate/presentation/viewmodels/catalog_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/card_container_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/drop_down_form_field.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class OperationParametersBasicForm extends ConsumerWidget {
  const OperationParametersBasicForm({
    super.key,
    required this.materialId,
    required this.dumpTruckTypeId,
    required this.distanceController,
    required this.loaderYieldM3h,
    required this.loadedSpeedKmh,
    required this.returnSpeedKmh,
    required this.efficiency,
    required this.onMaterialChanged,
    required this.onDumpTruckTypeChanged,
    required this.onLoaderYieldChanged,
    required this.onLoadedSpeedChanged,
    required this.onReturnSpeedChanged,
    required this.onEfficiencyChanged,
  });

  final String? materialId;
  final String? dumpTruckTypeId;
  final TextEditingController distanceController;
  final double? loaderYieldM3h;
  final double? loadedSpeedKmh;
  final double? returnSpeedKmh;
  final double? efficiency;
  final ValueChanged<String?> onMaterialChanged;
  final ValueChanged<String?> onDumpTruckTypeChanged;
  final ValueChanged<double?> onLoaderYieldChanged;
  final ValueChanged<double?> onLoadedSpeedChanged;
  final ValueChanged<double?> onReturnSpeedChanged;
  final ValueChanged<double?> onEfficiencyChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final catalog = ref.watch(catalogViewModelProvider);
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
                  value: materialId,
                  items: materialItems,
                  onChanged: onMaterialChanged,
                ),
                DropdownFormField<String>(
                  key: ValueKey('trucks-${catalog.dumpTruckTypes.length}'),
                  label: l10n.haulageUnit,
                  hintText: l10n.selectUnit,
                  prefixIcon: Icons.layers_outlined,
                  enabled: !catalog.isLoading && truckItems.isNotEmpty,
                  value: dumpTruckTypeId,
                  items: truckItems,
                  onChanged: onDumpTruckTypeChanged,
                ),
                AppTextFormField(
                  label: l10n.outboundDistance,
                  controller: distanceController,
                  hintText: '4.2',
                  suffixText: l10n.unitKm,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                DropdownFormField<double>(
                  key: ValueKey('loader-$loaderYieldM3h'),
                  label: l10n.loadingYield,
                  hintText: l10n.selectLoadingYield,
                  prefixIcon: Icons.precision_manufacturing_outlined,
                  value: loaderYieldM3h,
                  items: [
                    for (final option in OperationParameterPresets.loaderYields)
                      DropdownMenuItem(
                        value: option.m3h,
                        child: Text(
                          '${option.label} · ${option.m3h.toStringAsFixed(0)} ${l10n.unitM3h}',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: onLoaderYieldChanged,
                ),
                DropdownFormField<double>(
                  key: ValueKey('loaded-$loadedSpeedKmh'),
                  label: l10n.loadedSpeed,
                  hintText: l10n.selectSpeed,
                  prefixIcon: Icons.speed_outlined,
                  value: loadedSpeedKmh,
                  items: [
                    for (final speed in OperationParameterPresets.loadedSpeedsKmh)
                      DropdownMenuItem(
                        value: speed,
                        child: Text(
                          '${speed.toStringAsFixed(0)} ${l10n.unitKmh}',
                        ),
                      ),
                  ],
                  onChanged: onLoadedSpeedChanged,
                ),
                DropdownFormField<double>(
                  key: ValueKey('return-$returnSpeedKmh'),
                  label: l10n.returnSpeed,
                  hintText: l10n.selectSpeed,
                  prefixIcon: Icons.speed_outlined,
                  value: returnSpeedKmh,
                  items: [
                    for (final speed in OperationParameterPresets.returnSpeedsKmh)
                      DropdownMenuItem(
                        value: speed,
                        child: Text(
                          '${speed.toStringAsFixed(0)} ${l10n.unitKmh}',
                        ),
                      ),
                  ],
                  onChanged: onReturnSpeedChanged,
                ),
                _ShiftHoursInfo(),
                DropdownFormField<double>(
                  key: ValueKey('eff-$efficiency'),
                  label: l10n.efficiency,
                  hintText: l10n.selectEfficiency,
                  prefixIcon: Icons.tune_outlined,
                  value: efficiency,
                  items: [
                    for (final value in OperationParameterPresets.efficiencies)
                      DropdownMenuItem(
                        value: value,
                        child: Text(value.toString()),
                      ),
                  ],
                  onChanged: onEfficiencyChanged,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ShiftHoursInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final hours = OperationParameterPresets.shiftHours.toStringAsFixed(0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          l10n.shiftHours,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            spacing: 12,
            children: [
              Icon(Icons.schedule_outlined, color: colorScheme.outline),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$hours ${l10n.unitHours}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      l10n.shiftHoursFixedNote,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
