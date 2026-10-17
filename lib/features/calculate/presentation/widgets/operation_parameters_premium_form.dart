import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/features/calculate/presentation/viewmodels/catalog_view_model.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/numeric_field_pair.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/card_container_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/drop_down_form_field.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

/// Free-input operational form. Kept for a future paid version.
class OperationParametersPremiumForm extends ConsumerWidget {
  const OperationParametersPremiumForm({
    super.key,
    required this.materialId,
    required this.dumpTruckTypeId,
    required this.distanceController,
    required this.loaderPerformanceController,
    required this.loadedSpeedController,
    required this.unloadedSpeedController,
    required this.shiftHoursController,
    required this.efficiencyController,
    required this.onMaterialChanged,
    required this.onDumpTruckTypeChanged,
  });

  final String? materialId;
  final String? dumpTruckTypeId;
  final TextEditingController distanceController;
  final TextEditingController loaderPerformanceController;
  final TextEditingController loadedSpeedController;
  final TextEditingController unloadedSpeedController;
  final TextEditingController shiftHoursController;
  final TextEditingController efficiencyController;
  final ValueChanged<String?> onMaterialChanged;
  final ValueChanged<String?> onDumpTruckTypeChanged;

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
                  key: ValueKey('premium-materials-${catalog.materials.length}'),
                  label: l10n.inSituMaterial,
                  hintText: l10n.selectMaterial,
                  prefixIcon: Icons.layers_outlined,
                  enabled: !catalog.isLoading && materialItems.isNotEmpty,
                  value: materialId,
                  items: materialItems,
                  onChanged: onMaterialChanged,
                ),
                DropdownFormField<String>(
                  key: ValueKey('premium-trucks-${catalog.dumpTruckTypes.length}'),
                  label: l10n.haulageUnit,
                  hintText: l10n.selectUnit,
                  prefixIcon: Icons.layers_outlined,
                  enabled: !catalog.isLoading && truckItems.isNotEmpty,
                  value: dumpTruckTypeId,
                  items: truckItems,
                  onChanged: onDumpTruckTypeChanged,
                ),
                NumericFieldPair(
                  leftLabel: l10n.outboundDistance,
                  leftHint: '4.2',
                  leftController: distanceController,
                  leftSuffix: l10n.unitKm,
                  rightLabel: l10n.loadingYield,
                  rightHint: '450',
                  rightController: loaderPerformanceController,
                  rightSuffix: l10n.unitM3h,
                ),
                NumericFieldPair(
                  leftLabel: l10n.loadedSpeed,
                  leftHint: '24',
                  leftController: loadedSpeedController,
                  leftSuffix: l10n.unitKmh,
                  rightLabel: l10n.returnSpeed,
                  rightHint: '38',
                  rightController: unloadedSpeedController,
                  rightSuffix: l10n.unitKmh,
                ),
                NumericFieldPair(
                  leftLabel: l10n.shiftHours,
                  leftHint: '8.0',
                  leftController: shiftHoursController,
                  leftSuffix: l10n.unitHours,
                  rightLabel: l10n.efficiency,
                  rightHint: '0.85',
                  rightController: efficiencyController,
                  rightSuffix: l10n.unitRatio,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
