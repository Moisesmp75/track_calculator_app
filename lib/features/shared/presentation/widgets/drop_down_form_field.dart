import 'package:flutter/material.dart';

class DropdownFormField<T> extends StatelessWidget {
  const DropdownFormField({
    super.key,
    required this.label,
    required this.items,
    this.value,
    this.hintText,
    this.prefixIcon,
    this.onChanged,
    this.validator,
    this.enabled = true,
  });

  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? hintText;
  final IconData? prefixIcon;
  final ValueChanged<T?>? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          label,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonFormField<T>(
            initialValue: value,
            items: items,
            isExpanded: true,
            onChanged: enabled ? onChanged : null,
            validator: validator,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface,
              overflow: TextOverflow.ellipsis,
            ),
            dropdownColor: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            icon: Icon(
              Icons.expand_more_rounded,
              color: colorScheme.outline,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 8),
            ),
          ),
        ),
      ],
    );
  }
}