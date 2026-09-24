import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
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
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                spacing: 8,
                children: [
                  Text(
                    'Historial',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                  AppBadgeWidget(
                    label: 'SINCRONIZADO',
                    status: AppBadgeStatus.info,
                  )
                ],
              ),
              AppIconWidget(action: AppIconAction.refresh)
            ],
          ),
          Text(
            'Tus simulaciones y reportes guardados para campo y laboratorio',
            style: theme.textTheme.bodyMedium
          ),
        ],
      ),
    );
  }
}