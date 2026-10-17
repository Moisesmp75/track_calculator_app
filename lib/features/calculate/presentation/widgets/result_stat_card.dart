import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/result_accent_card.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/result_section_tone.dart';

class ResultStatCard extends StatelessWidget {
  const ResultStatCard({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.caption,
    required this.tone,
    this.unit,
  });

  final String label;
  final IconData icon;
  final String value;
  final String caption;
  final ResultSectionTone tone;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = tone.colorsOf(theme.brightness);

    return ResultAccentCard(
      tone: tone,
      fillHeight: true,
      header: Row(
        children: [
          Expanded(
            child: Text(
              label.toUpperCase(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 18),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text.rich(
            TextSpan(
              text: value,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: colors.foreground,
                fontWeight: FontWeight.w800,
                fontSize: 26,
                height: 1.1,
              ),
              children: [
                if (unit != null)
                  TextSpan(
                    text: ' $unit',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: colors.foreground,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            caption,
            style: theme.textTheme.bodySmall?.copyWith(
              color: colors.muted,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}
