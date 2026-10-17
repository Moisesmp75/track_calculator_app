import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/login_screen.dart';
import 'package:vehicle_calculator/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:vehicle_calculator/features/settings/presentation/viewmodels/profile_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/viewmodels/locale_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/viewmodels/theme_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/extensions/snackbar_extension.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_confirm_sheet.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_version_label.dart';
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
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
          const _PersonalInformationSection(),
          const _PreferencesSection(),
          const _AccountAndSecuritySection(),
          const Center(child: AppVersionLabel()),
        ],
      ),
    );
  }
}

class _PersonalInformationSection extends ConsumerWidget {
  const _PersonalInformationSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(profileViewModelProvider);

    return CardContainerWidget(
      child: profile.isLoading
          ? const SizedBox(
              height: 88,
              child: Center(child: CircularProgressIndicator()),
            )
          : Column(
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
                      profile.user?.displayName.toLowerCase() ?? '—',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (profile.user?.email.isNotEmpty == true)
                      AppBadgeWidget(
                        label: profile.user!.email,
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

class _PreferencesSection extends ConsumerWidget {
  const _PreferencesSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final locale = ref.watch(localeViewModelProvider);
    final themeMode = ref.watch(themeViewModelProvider);
    final isSpanish = locale.languageCode == 'es';
    final isDark = themeMode == ThemeMode.dark;

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
                statusText: isSpanish ? l10n.spanishActive : l10n.englishActive,
                selectedValue: locale.languageCode,
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
                  ref.read(localeViewModelProvider.notifier).setLocale(Locale(val));
                },
              ),
              AppToogleSwitchDual<ThemeMode>(
                title: l10n.visualAppearance,
                statusText: isDark ? l10n.darkMode : l10n.lightMode,
                selectedValue: themeMode,
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
                  ref.read(themeViewModelProvider.notifier).setThemeMode(mode);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AccountAndSecuritySection extends ConsumerWidget {
  const _AccountAndSecuritySection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                onPressed: () => _signOut(context, ref),
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
                    AppButtonWidget(
                      label: l10n.deleteAccountTwoSteps,
                      variant: AppButtonVariant.danger,
                      trailingIcon: Icons.delete_outline,
                      isLoading: ref.watch(authViewModelProvider).isLoading,
                      onPressed: () => _deleteAccount(context, ref),
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

Future<void> _signOut(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showAppConfirmSheet(
    context: context,
    title: l10n.signOutTitle,
    message: l10n.signOutMessage,
    confirmLabel: l10n.signOut,
    cancelLabel: l10n.cancel,
    confirmVariant: AppButtonVariant.primary,
    confirmIcon: Icons.logout,
  );
  if (!confirmed || !context.mounted) return;

  await ref.read(authViewModelProvider.notifier).logout();
  if (context.mounted) {
    context.goNamed(LoginScreen.screenName);
  }
}

Future<void> _deleteAccount(BuildContext context, WidgetRef ref) async {
  final l10n = AppLocalizations.of(context);
  final confirmed = await showAppConfirmSheet(
    context: context,
    title: l10n.deleteAccountTitle,
    message: l10n.deleteAccountWarning,
    confirmLabel: l10n.delete,
    cancelLabel: l10n.cancel,
  );
  if (!confirmed || !context.mounted) return;

  final success = await ref.read(authViewModelProvider.notifier).deleteAccount(
    networkErrorMessage: l10n.networkError,
  );
  if (!context.mounted) return;

  if (!success) {
    final message = ref.read(authViewModelProvider).errorMessage;
    if (message != null) {
      context.showSnackBar(message: message);
    }
    return;
  }

  context.goNamed(LoginScreen.screenName);
}
