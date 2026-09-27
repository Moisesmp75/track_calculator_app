import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/calculate/presentation/screens/result_detail_screen.dart';
import 'package:vehicle_calculator/features/history/presentation/viewmodels/history_view_model.dart';
import 'package:vehicle_calculator/features/history/presentation/widgets/calculation_history_item.dart';
import 'package:vehicle_calculator/features/shared/presentation/extensions/snackbar_extension.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/custom_app_bar.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class CalculationHistoryScreen extends StatelessWidget {
  static const screenName = '/calculation-history';
  const CalculationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      appBar: CustomAppBar(
        title: l10n.calculationHistoryTitle,
        leadingIcon: Icons.history_outlined,
      ),
      body: const _CalculationHistoryScreenView(),
    );
  }
}

class _CalculationHistoryScreenView extends StatelessWidget {
  const _CalculationHistoryScreenView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        _HistoryHeader(),
        Expanded(child: _HistoryList()),
      ],
    );
  }
}

class _HistoryHeader extends ConsumerWidget {
  const _HistoryHeader();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final history = ref.watch(historyViewModelProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                spacing: 8,
                children: [
                  Flexible(
                    child: Text(
                      l10n.history,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  if (!history.isLoading)
                    AppBadgeWidget(
                      label: l10n.historySynced,
                      status: AppBadgeStatus.info,
                    ),
                ],
              ),
            ),
            AppIconWidget(
              action: AppIconAction.refresh,
              size: 40,
              onTap: history.isLoading
                  ? null
                  : () => ref.read(historyViewModelProvider.notifier).load(),
            ),
          ],
        ),
        Text(
          l10n.historySubtitle,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _HistoryList extends ConsumerWidget {
  const _HistoryList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final history = ref.watch(historyViewModelProvider);

    ref.listen(historyViewModelProvider, (previous, next) {
      final message = next.errorMessage;
      if (message != null && message != previous?.errorMessage) {
        context.showSnackBar(message: message);
      }
    });

    if (history.isLoading && history.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (history.items.isEmpty) {
      return Center(
        child: Text(
          l10n.historyEmpty,
          style: Theme.of(context).textTheme.bodyLarge,
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      itemCount: history.items.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final calculation = history.items[index];
        return CalculationHistoryItem(
          calculation: calculation,
          onTap: () {
            context.pushNamed(
              ResultDetailScreen.screenName,
              extra: calculation,
            );
          },
        );
      },
    );
  }
}
