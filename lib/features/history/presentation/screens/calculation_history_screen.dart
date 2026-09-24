import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/custom_app_bar.dart';

class CalculationHistoryScreen extends StatelessWidget {
  static const screenName = '/calculation-history';
  const CalculationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      appBar: CustomAppBar(
        title: 'Historial de cálculos',
        leadingIcon: Icons.local_shipping_outlined,
      ),
      body: _CalculationHistoryScreenView(),
    );
  }
}

class _CalculationHistoryScreenView extends StatelessWidget {
  const _CalculationHistoryScreenView();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}