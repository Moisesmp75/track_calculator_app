import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';

class NumericFieldPair extends StatelessWidget {
  const NumericFieldPair({
    super.key,
    required this.leftLabel,
    required this.leftHint,
    required this.leftController,
    required this.leftSuffix,
    required this.rightLabel,
    required this.rightHint,
    required this.rightController,
    required this.rightSuffix,
  });

  final String leftLabel;
  final String leftHint;
  final TextEditingController leftController;
  final String leftSuffix;
  final String rightLabel;
  final String rightHint;
  final TextEditingController rightController;
  final String rightSuffix;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: AppTextFormField(
            label: leftLabel,
            hintText: leftHint,
            controller: leftController,
            suffixText: leftSuffix,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        Expanded(
          child: AppTextFormField(
            label: rightLabel,
            hintText: rightHint,
            controller: rightController,
            suffixText: rightSuffix,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}
