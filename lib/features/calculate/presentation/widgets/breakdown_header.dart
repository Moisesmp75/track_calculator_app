import 'package:flutter/material.dart';
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
    final style = DefaultTextStyle.of(context).style;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        children: [
          const Icon(Icons.tune_outlined, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              l10n.operationalBreakdown.toUpperCase(),
              style: style.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          Icon(
            isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
          ),
        ],
      ),
    );
  }
}
