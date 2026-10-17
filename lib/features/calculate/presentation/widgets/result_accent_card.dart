import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/calculate/presentation/widgets/result_section_tone.dart';

class ResultAccentCard extends StatelessWidget {
  const ResultAccentCard({
    super.key,
    required this.tone,
    required this.child,
    this.header,
    this.bodyPadding = const EdgeInsets.fromLTRB(14, 14, 14, 14),
    this.fillHeight = false,
  });

  final ResultSectionTone tone;
  final Widget child;
  final Widget? header;
  final EdgeInsets bodyPadding;
  final bool fillHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = tone.colorsOf(theme.brightness);
    final headerStyle = theme.textTheme.labelLarge?.copyWith(
      color: colors.onHeader,
      fontWeight: FontWeight.w700,
      fontSize: 13,
      letterSpacing: 0.3,
      height: 1.25,
    );

    final content = ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null)
            Container(
              color: colors.header,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: IconTheme(
                data: IconThemeData(color: colors.onHeader, size: 20),
                child: DefaultTextStyle(
                  style: headerStyle ?? TextStyle(color: colors.onHeader),
                  child: header!,
                ),
              ),
            ),
          Padding(padding: bodyPadding, child: child),
        ],
      ),
    );

    return Container(
      alignment: fillHeight ? Alignment.topLeft : null,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.border),
      ),
      child: content,
    );
  }
}
