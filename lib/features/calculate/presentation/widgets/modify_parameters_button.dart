import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class ModifyParametersButton extends StatelessWidget {
  const ModifyParametersButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AppButtonWidget(
      label: l10n.modifyParameters,
      variant: AppButtonVariant.outline,
      trailingIcon: Icons.edit_outlined,
      onPressed: () => context.pop(),
    );
  }
}
