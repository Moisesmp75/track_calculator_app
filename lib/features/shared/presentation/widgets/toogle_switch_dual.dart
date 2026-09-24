import 'package:flutter/material.dart';

class ToogleSwitchDualOption<T> {
  final T value;
  final String label;
  final IconData icon;

  const ToogleSwitchDualOption({
    required this.value,
    required this.label,
    required this.icon,
  });
}

class AppToogleSwitchDual<T> extends StatelessWidget {
  final String title;
  final String? statusText;
  final T selectedValue;
  final ToogleSwitchDualOption<T> option1;
  final ToogleSwitchDualOption<T> option2;
  final ValueChanged<T> valueChanged;

  const AppToogleSwitchDual({
    super.key,
    required this.title,
    this.statusText,
    required this.selectedValue,
    required this.option1,
    required this.option2,
    required this.valueChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            if (statusText != null)
              Text(
                statusText!,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: _SegmentItem<T>(
                  option: option1,
                  isSelected: selectedValue == option1.value,
                  onTap: () => valueChanged(option1.value),
                ),
              ),
              Expanded(
                child: _SegmentItem<T>(
                  option: option2,
                  isSelected: selectedValue == option2.value,
                  onTap: () => valueChanged(option2.value),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SegmentItem<T> extends StatelessWidget {
  final ToogleSwitchDualOption<T> option;
  final bool isSelected;
  final VoidCallback onTap;

  const _SegmentItem({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final activeColor = colorScheme.primary;
    final inactiveColor = colorScheme.onSurfaceVariant;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Ink(
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.surfaceContainerLowest
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  option.icon,
                  size: 22,
                  color: isSelected ? activeColor : inactiveColor,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    option.label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      color: isSelected ? activeColor : inactiveColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}