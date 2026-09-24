import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/login_screen.dart';
import 'package:vehicle_calculator/features/shared/presentation/providers/locale_provider.dart';
import 'package:vehicle_calculator/features/shared/presentation/providers/theme_provider.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/card_container_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/custom_app_bar.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/toogle_switch_dual.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class ProfileSettingsScreen extends StatelessWidget {
  static const screenName = '/profile-settings';
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      appBar: CustomAppBar(
        title: l10n.settings,
        leadingIcon: Icons.settings_outlined,
      ),
      body: const _ProfileSettingsScreenView(),
    );
  }
}

class _ProfileSettingsScreenView extends StatelessWidget {
  const _ProfileSettingsScreenView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      child: Column(
        spacing: 22,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                l10n.configuration,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
              Text(
                l10n.settingsSubtitle,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
          const _PersonalInformationSection(),
          const _PreferencesSection(),
          const _AccountAndSecuritySection(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _PersonalInformationSection extends StatelessWidget {
  const _PersonalInformationSection();

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
              AppIconWidget(action: AppIconAction.school),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    Text(
                      'Carlos Mendoza Davila',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppBadgeWidget(
                      label: 'carlos.mendoza@gmail.com',
                      showDot: false,
                      status: AppBadgeStatus.info,
                    )
                  ],
                ),
              )
            ],
          ),
          CardContainerWidget(
            color: theme.colorScheme.surfaceContainerLow,
            child: Row(
              spacing: 12,
              children: [
                AppSimpleIcon(action: AppIconAction.badge),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.editPersonalData,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        l10n.editPersonalDataSubtitle,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                AppSimpleIcon(action: AppIconAction.chevronRight),
              ],
            ),
          )
        ],
      )
    );
  }
}

class _PreferencesSection extends StatelessWidget {
  const _PreferencesSection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final localeProvider = context.watch<LocaleProvider>();
    final themeProvider = context.watch<ThemeProvider>();

    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.interfacePreferences, style: theme.textTheme.titleMedium),
        CardContainerWidget(
          child: Column(
            spacing: 22,
            children: [
              AppToogleSwitchDual<String>(
                title: l10n.systemLanguage,
                statusText: localeProvider.isSpanish
                    ? l10n.spanishActive
                    : l10n.englishActive,
                selectedValue: localeProvider.locale.languageCode,
                option1: ToogleSwitchDualOption(
                  value: 'es',
                  label: l10n.spanishPe,
                  icon: Icons.language,
                ),
                option2: ToogleSwitchDualOption(
                  value: 'en',
                  label: l10n.englishUs,
                  icon: Icons.translate,
                ),
                valueChanged: (val) {
                  context.read<LocaleProvider>().setLocale(Locale(val));
                },
              ),
              AppToogleSwitchDual<ThemeMode>(
                title: l10n.visualAppearance,
                statusText: themeProvider.isDark ? l10n.darkMode : l10n.lightMode,
                selectedValue: themeProvider.themeMode,
                option1: ToogleSwitchDualOption(
                  value: ThemeMode.light,
                  label: l10n.lightMode,
                  icon: Icons.light_mode_outlined,
                ),
                option2: ToogleSwitchDualOption(
                  value: ThemeMode.dark,
                  label: l10n.darkMode,
                  icon: Icons.dark_mode_outlined,
                ),
                valueChanged: (mode) {
                  context.read<ThemeProvider>().setThemeMode(mode);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AccountAndSecuritySection extends StatelessWidget {
  const _AccountAndSecuritySection();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.accountAndSecurity, style: theme.textTheme.titleMedium),
        CardContainerWidget(
          child: Column(
            spacing: 22,
            children: [
              Row(
                spacing: 12,
                children: [
                  AppSimpleIcon(
                    action: AppIconAction.lockReset,
                    color: theme.colorScheme.onSurface,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.changePassword,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        l10n.passwordLastModified,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const Spacer(),
                  AppSimpleIcon(
                    action: AppIconAction.chevronRight,
                    color: theme.colorScheme.onSurface,
                  ),
                ],
              ),
              AppButtonWidget(
                label: l10n.signOut,
                onPressed: () {
                  context.goNamed(LoginScreen.screenName);
                },
                trailingIcon: Icons.logout,
                variant: AppButtonVariant.primary,
              ),
              CardContainerWidget(
                color: theme.colorScheme.errorContainer.withAlpha(80),
                child: Column(
                  spacing: 12,
                  children: [
                    Row(
                      spacing: 12,
                      children: [
                        AppSimpleIcon(
                          action: AppIconAction.warning,
                          color: theme.colorScheme.onErrorContainer,
                        ),
                        Text(
                          l10n.dangerZone,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      l10n.deleteAccountWarning,
                      style: theme.textTheme.bodyMedium,
                    ),
                    CardContainerWidget(
                      color: theme.colorScheme.errorContainer,
                      child: Text(
                        l10n.deleteAccountTwoSteps,
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onErrorContainer,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
