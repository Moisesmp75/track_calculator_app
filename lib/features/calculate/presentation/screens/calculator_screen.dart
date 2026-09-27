import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/create_calculation_input.dart';
import 'package:vehicle_calculator/features/calculate/presentation/screens/result_detail_screen.dart';
import 'package:vehicle_calculator/features/calculate/presentation/utils/calculation_form_parsers.dart';
import 'package:vehicle_calculator/features/calculate/presentation/viewmodels/calculator_view_model.dart';
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

class _CalculatorScreenView extends ConsumerStatefulWidget {
  const _CalculatorScreenView();

  @override
  ConsumerState<_CalculatorScreenView> createState() =>
      _CalculatorScreenViewState();
}

class _CalculatorScreenViewState extends ConsumerState<_CalculatorScreenView> {
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
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final catalog = ref.watch(catalogViewModelProvider);
    final calculator = ref.watch(calculatorViewModelProvider);

    ref.listen(catalogViewModelProvider, (previous, next) {
      final message = next.errorMessage;
      if (message != null && message != previous?.errorMessage) {
        context.showSnackBar(message: message);
      }
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 22,
        children: [
          Text(l10n.haulageSimulation, style: theme.textTheme.bodyMedium),
          Text(
            l10n.newCalculation,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
          ),
          _buildGeneralForm(theme, l10n),
          _buildOperationForm(theme, l10n, catalog),
          _buildCostForm(theme, l10n),
          AppButtonWidget(
            label: l10n.calculateFleetAndCycle,
            onPressed: _submit,
            enabled: _canSubmit && !calculator.isSubmitting,
            isLoading: calculator.isSubmitting,
            trailingIcon: Icons.speed,
            icon: Icons.arrow_forward,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildGeneralForm(ThemeData theme, AppLocalizations l10n) {
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
              ),
            ],
          ),
          Form(
            child: Column(
              spacing: 12,
              children: [
                AppTextFormField(
                  label: l10n.miningProject,
                  hintText: l10n.miningProjectHint,
                  controller: _projectController,
                  suffixIcon: AppSimpleIcon(action: AppIconAction.apartment),
                ),
                AppTextFormField(
                  label: l10n.transportRoute,
                  hintText: l10n.transportRouteHint,
                  controller: _sectionController,
                  suffixIcon: AppSimpleIcon(action: AppIconAction.allRoute),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationForm(
    ThemeData theme,
    AppLocalizations l10n,
    CatalogState catalog,
  ) {
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
                        controller: _distanceController,
                        suffixText: l10n.unitKm,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.loadingYield,
                        hintText: '450',
                        controller: _loaderPerformanceController,
                        suffixText: l10n.unitM3h,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
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
                        controller: _loadedSpeedController,
                        suffixText: l10n.unitKmh,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.returnSpeed,
                        hintText: '38',
                        controller: _unloadedSpeedController,
                        suffixText: l10n.unitKmh,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
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
                        controller: _shiftHoursController,
                        suffixText: l10n.unitHours,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.efficiency,
                        hintText: '0.85',
                        controller: _efficiencyController,
                        suffixText: l10n.unitRatio,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
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

  Widget _buildCostForm(ThemeData theme, AppLocalizations l10n) {
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
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.dumpTruckHourlyRate,
                        hintText: '180',
                        controller: _dumpTruckRateController,
                        suffixText: l10n.unitPerHour,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: AppTextFormField(
                        label: l10n.loaderHourlyRate,
                        hintText: '250',
                        controller: _loaderRateController,
                        suffixText: l10n.unitPerHour,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),
                  ],
                ),
                AppTextFormField(
                  label: l10n.staffHourlyRate,
                  hintText: '45',
                  controller: _staffRateController,
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
