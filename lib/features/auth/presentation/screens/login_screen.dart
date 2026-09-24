import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/register_screen.dart';
import 'package:vehicle_calculator/features/calculate/presentation/screens/calculator_screen.dart';
import 'package:vehicle_calculator/features/shared/presentation/providers/locale_provider.dart';
import 'package:vehicle_calculator/features/shared/presentation/providers/theme_provider.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_toggle.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  static const screenName = '/login';
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: _LoginScreenView(),
    );
  }
}

class _LoginScreenView extends StatelessWidget {
  const _LoginScreenView();

  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 24,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _LoginPreferences(),
        _LoginViewHeader(),
        _LoginForm(),
        _LoginViewFooter(),
      ],
    );
  }
}

class _LoginPreferences extends StatelessWidget {
  const _LoginPreferences();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return Align(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          AppIconToggle(
            icon: themeProvider.isDark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            tooltip: l10n.toggleTheme,
            onTap: themeProvider.toggleTheme,
          ),
          AppIconToggle(
            icon: Icons.translate_outlined,
            tooltip: l10n.toggleLanguage,
            onTap: localeProvider.toggleLocale,
          ),
        ],
      ),
    );
  }
}

class _LoginViewHeader extends StatelessWidget {
  const _LoginViewHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      spacing: 12,
      children: [
        AppBadgeWidget(
          label: l10n.academicPortal,
          showDot: false,
          status: AppBadgeStatus.info,
        ),
        Text(
          // l10n.appName,
          'App Name',
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          l10n.appTagline,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        spacing: 12,
        children: [
          AppTextFormField(
            label: l10n.institutionalEmail,
            hintText: l10n.emailHint,
            prefixIcon: Icons.alternate_email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.emailRequired;
              }
              return null;
            },
          ),
          AppTextFormField(
            label: l10n.password,
            hintText: l10n.passwordHint,
            prefixIcon: Icons.lock_outline,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.visibility_outlined),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return l10n.passwordRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 6),
          AppButtonWidget(
            label: l10n.signIn,
            onPressed: () { context.goNamed(CalculatorScreen.screenName); },
            variant: AppButtonVariant.primary,
            icon: Icons.arrow_forward,
          ),
        ],
      ),
    );
  }
}

class _LoginViewFooter extends StatelessWidget {
  const _LoginViewFooter();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Flexible(
          child: Text(
            l10n.noAccount,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 16,
            ),
          ),
        ),
        TextButton(
          onPressed: () => context.pushNamed(RegisterScreen.screenName),
          child: Text(
            l10n.registerHere,
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 16,
              color: colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
