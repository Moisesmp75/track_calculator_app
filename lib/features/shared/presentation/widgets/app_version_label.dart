import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/core/di/core_providers.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class AppVersionLabel extends ConsumerWidget {
  const AppVersionLabel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final version = ref.watch(packageInfoProvider).version;

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: Text(
        l10n.appVersion(version),
        textAlign: TextAlign.center,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
