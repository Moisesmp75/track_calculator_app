import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/card_container_widget.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class GeneralInformationForm extends StatelessWidget {
  const GeneralInformationForm({
    super.key,
    required this.projectController,
    required this.sectionController,
  });

  final TextEditingController projectController;
  final TextEditingController sectionController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return CardContainerWidget(
      child: Column(
        spacing: 12,
        children: [
          Row(
            spacing: 12,
            children: [
              AppSimpleIcon(action: AppIconAction.map),
              Text(
                l10n.generalData,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              AppBadgeWidget(
                label: l10n.optional,
                showDot: false,
              ),
            ],
          ),
          Form(
            child: Column(
              spacing: 12,
              children: [
                AppTextFormField(
                  label: l10n.miningProject,
                  hintText: l10n.miningProjectHint,
                  controller: projectController,
                  suffixIcon: AppSimpleIcon(action: AppIconAction.apartment),
                ),
                AppTextFormField(
                  label: l10n.transportRoute,
                  hintText: l10n.transportRouteHint,
                  controller: sectionController,
                  suffixIcon: AppSimpleIcon(action: AppIconAction.allRoute),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
