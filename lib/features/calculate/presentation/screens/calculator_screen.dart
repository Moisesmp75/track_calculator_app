import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/core/di/core_providers.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/create_calculation_input.dart';
import 'package:vehicle_calculator/features/calculate/presentation/models/result_detail_args.dart';
import 'package:vehicle_calculator/features/calculate/presentation/screens/result_detail_screen.dart';
import 'package:vehicle_calculator/features/calculate/presentation/utils/calculation_form_parsers.dart';
import 'package:vehicle_calculator/features/calculate/presentation/viewmodels/calculator_view_model.dart';
import 'package:vehicle_calculator/features/calculate/presentation/viewmodels/catalog_view_model.dart';
import 'package:vehicle_calculator/features/calculate/presentation/models/operation_parameter_presets.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/calculator_view_header.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/operation_parameters_basic_form.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/premium_section_card.dart';
import 'package:vehicle_calculator/features/shared/presentation/extensions/snackbar_extension.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/custom_app_bar.dart';
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
  final _distanceController = TextEditingController();

  String? _materialId;
  String? _dumpTruckTypeId;
  double? _loaderYieldM3h;
  double? _loadedSpeedKmh;
  double? _returnSpeedKmh;
  double? _efficiency;

  @override
  void initState() {
    super.initState();
    _distanceController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() => setState(() {});

  @override
  void dispose() {
    _distanceController
      ..removeListener(_onFieldChanged)
      ..dispose();
    super.dispose();
  }

  bool get _canSubmit {
    if (_materialId == null || _dumpTruckTypeId == null) return false;
    if (_loaderYieldM3h == null ||
        _loadedSpeedKmh == null ||
        _returnSpeedKmh == null ||
        _efficiency == null) {
      return false;
    }
    return isPositive(parseOptionalNumber(_distanceController.text));
  }

  Future<void> _submit() async {
    if (!_canSubmit) return;

    final l10n = AppLocalizations.of(context);

    final result = await ref.read(calculatorViewModelProvider.notifier).submit(
      input: CreateCalculationInput(
        materialId: _materialId!,
        dumpTruckTypeId: _dumpTruckTypeId!,
        distanceKm: parseOptionalNumber(_distanceController.text)!,
        loadedSpeedKmh: _loadedSpeedKmh!,
        unloadedSpeedKmh: _returnSpeedKmh!,
        shiftHours: OperationParameterPresets.shiftHours,
        efficiency: _efficiency!,
        loaderPerformanceM3h: _loaderYieldM3h!,
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

    await ref
        .read(interstitialAdControllerProvider)
        .showAfterSuccessfulCalculation();
    if (!mounted) return;

    final popAction = await context.pushNamed(
      ResultDetailScreen.screenName,
      extra: ResultDetailArgs(
        result: result,
        canModifyParameters: true,
      ),
    );
    if (!mounted) return;
    if (popAction != ResultPopAction.keepForm) {
      _resetForm();
    }
  }

  void _resetForm() {
    _distanceController.clear();
    setState(() {
      _materialId = null;
      _dumpTruckTypeId = null;
      _loaderYieldM3h = null;
      _loadedSpeedKmh = null;
      _returnSpeedKmh = null;
      _efficiency = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(catalogViewModelProvider, (previous, next) {
      final message = next.errorMessage;
      if (message != null && message != previous?.errorMessage) {
        context.showSnackBar(message: message);
      }
    });

    final l10n = AppLocalizations.of(context);

    return Column(
      spacing: 22,
      children: [
        PremiumSectionCard(
          title: l10n.generalData,
          icon: AppIconAction.map,
        ),
        OperationParametersBasicForm(
          materialId: _materialId,
          dumpTruckTypeId: _dumpTruckTypeId,
          distanceController: _distanceController,
          loaderYieldM3h: _loaderYieldM3h,
          loadedSpeedKmh: _loadedSpeedKmh,
          returnSpeedKmh: _returnSpeedKmh,
          efficiency: _efficiency,
          onMaterialChanged: (value) => setState(() => _materialId = value),
          onDumpTruckTypeChanged: (value) {
            setState(() => _dumpTruckTypeId = value);
          },
          onLoaderYieldChanged: (value) {
            setState(() => _loaderYieldM3h = value);
          },
          onLoadedSpeedChanged: (value) {
            setState(() => _loadedSpeedKmh = value);
          },
          onReturnSpeedChanged: (value) {
            setState(() => _returnSpeedKmh = value);
          },
          onEfficiencyChanged: (value) {
            setState(() => _efficiency = value);
          },
        ),
        PremiumSectionCard(
          title: l10n.costAnalysis,
          icon: AppIconAction.payments,
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
