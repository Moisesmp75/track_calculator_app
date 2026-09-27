import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class BreakdownHeader extends StatelessWidget {
  const BreakdownHeader({
    super.key,
    required this.isExpanded,
    required this.onTap,
  });

  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          AppSimpleIcon(action: AppIconAction.tune, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              l10n.operationalBreakdown,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Icon(
            isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
            color: theme.colorScheme.outline,
          ),
        ],
      ),
    );
  }
}
