import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/create_calculation_input.dart';
import 'package:vehicle_calculator/features/calculate/presentation/screens/result_detail_screen.dart';
import 'package:vehicle_calculator/features/calculate/presentation/utils/calculation_form_parsers.dart';
import 'package:vehicle_calculator/features/calculate/presentation/viewmodels/calculator_view_model.dart';
import 'package:vehicle_calculator/features/calculate/presentation/viewmodels/catalog_view_model.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/calculator_view_header.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/cost_analysis_form.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/general_information_form.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/numeric_field_pair.dart';
import 'package:vehicle_calculator/features/shared/presentation/extensions/snackbar_extension.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
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
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 22,
        children: [
          CalculatorViewHeader(),
          _CalculatorForm(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _CalculatorForm extends ConsumerStatefulWidget {
  const _CalculatorForm();

  @override
  ConsumerState<_CalculatorForm> createState() => _CalculatorFormState();
}

class _CalculatorFormState extends ConsumerState<_CalculatorForm> {
  final _projectController = TextEditingController();
  final _sectionController = TextEditingController();
  final _distanceController = TextEditingController();
  final _loaderPerformanceController = TextEditingController();
  final _loadedSpeedController = TextEditingController();
  final _unloadedSpeedController = TextEditingController();
  final _shiftHoursController = TextEditingController();
  final _efficiencyController = TextEditingController();
  final _dumpTruckRateController = TextEditingController();
  final _loaderRateController = TextEditingController();
  final _staffRateController = TextEditingController();

  String? _materialId;
  String? _dumpTruckTypeId;

  @override
  void initState() {
    super.initState();
    for (final controller in _controllers) {
      controller.addListener(_onFieldChanged);
    }
  }

  List<TextEditingController> get _controllers => [
        _projectController,
        _sectionController,
        _distanceController,
        _loaderPerformanceController,
        _loadedSpeedController,
        _unloadedSpeedController,
        _shiftHoursController,
        _efficiencyController,
        _dumpTruckRateController,
        _loaderRateController,
        _staffRateController,
      ];

  void _onFieldChanged() => setState(() {});

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  bool get _canSubmit {
    if (_materialId == null || _dumpTruckTypeId == null) return false;
    if (!isPositive(parseOptionalNumber(_distanceController.text))) {
      return false;
    }
    if (!isValidSpeed(parseOptionalNumber(_loadedSpeedController.text))) {
      return false;
    }
    if (!isValidSpeed(parseOptionalNumber(_unloadedSpeedController.text))) {
      return false;
    }
    if (!isPositive(parseOptionalNumber(_shiftHoursController.text))) {
      return false;
    }
    if (!isValidEfficiency(parseOptionalNumber(_efficiencyController.text))) {
      return false;
    }
    if (!isPositive(parseOptionalNumber(_loaderPerformanceController.text))) {
      return false;
    }
    return _isOptionalRateValid(_dumpTruckRateController.text) &&
        _isOptionalRateValid(_loaderRateController.text) &&
        _isOptionalRateValid(_staffRateController.text);
  }

  bool _isOptionalRateValid(String raw) {
    if (raw.trim().isEmpty) return true;
    return isPositive(parseOptionalNumber(raw));
  }

  Future<void> _submit() async {
    if (!_canSubmit) return;

    final l10n = AppLocalizations.of(context);
    final projectName = _projectController.text.trim();
    final section = _sectionController.text.trim();

    final result = await ref.read(calculatorViewModelProvider.notifier).submit(
      input: CreateCalculationInput(
        materialId: _materialId!,
        dumpTruckTypeId: _dumpTruckTypeId!,
        distanceKm: parseOptionalNumber(_distanceController.text)!,
        loadedSpeedKmh: parseOptionalNumber(_loadedSpeedController.text)!,
        unloadedSpeedKmh: parseOptionalNumber(_unloadedSpeedController.text)!,
        shiftHours: parseOptionalNumber(_shiftHoursController.text)!,
        efficiency: parseOptionalNumber(_efficiencyController.text)!,
        loaderPerformanceM3h:
            parseOptionalNumber(_loaderPerformanceController.text)!,
        projectName: projectName.isEmpty ? null : projectName,
        section: section.isEmpty ? null : section,
        dumpTruckHourlyRate: parseOptionalNumber(_dumpTruckRateController.text),
        loaderHourlyRate: parseOptionalNumber(_loaderRateController.text),
        staffHourlyRate: parseOptionalNumber(_staffRateController.text),
      ),
      networkErrorMessage: l10n.networkError,
    );
    if (!mounted) return;

    if (result == null) {
      final message = ref.read(calculatorViewModelProvider).errorMessage;
      if (message != null) {
        context.showSnackBar(message: message);
      }
      return;
    }

    context.pushNamed(ResultDetailScreen.screenName, extra: result);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(catalogViewModelProvider, (previous, next) {
      final message = next.errorMessage;
      if (message != null && message != previous?.errorMessage) {
        context.showSnackBar(message: message);
      }
    });

    return Column(
      spacing: 22,
      children: [
        GeneralInformationForm(
          projectController: _projectController,
          sectionController: _sectionController,
        ),
        _OperationInformationForm(
          materialId: _materialId,
          dumpTruckTypeId: _dumpTruckTypeId,
          distanceController: _distanceController,
          loaderPerformanceController: _loaderPerformanceController,
          loadedSpeedController: _loadedSpeedController,
          unloadedSpeedController: _unloadedSpeedController,
          shiftHoursController: _shiftHoursController,
          efficiencyController: _efficiencyController,
          onMaterialChanged: (value) => setState(() => _materialId = value),
          onDumpTruckTypeChanged: (value) {
            setState(() => _dumpTruckTypeId = value);
          },
        ),
        CostAnalysisForm(
          dumpTruckRateController: _dumpTruckRateController,
          loaderRateController: _loaderRateController,
          staffRateController: _staffRateController,
        ),
        _CalculatorSubmitButton(
          enabled: _canSubmit,
          onPressed: _submit,
        ),
      ],
    );
  }
}

class _CalculatorSubmitButton extends ConsumerWidget {
  const _CalculatorSubmitButton({
    required this.enabled,
    required this.onPressed,
  });

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isSubmitting = ref.watch(calculatorViewModelProvider).isSubmitting;

    return AppButtonWidget(
      label: l10n.calculateFleetAndCycle,
      onPressed: onPressed,
      enabled: enabled && !isSubmitting,
      isLoading: isSubmitting,
      trailingIcon: Icons.speed,
      icon: Icons.arrow_forward,
    );
  }
}

class _OperationInformationForm extends ConsumerWidget {
  const _OperationInformationForm({
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
