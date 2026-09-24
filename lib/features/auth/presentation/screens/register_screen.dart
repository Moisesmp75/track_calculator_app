import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/login_screen.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class RegisterScreen extends StatelessWidget {
  static const screenName = '/register';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: _RegisterScreenView(),
    );
  }
}

class _RegisterScreenView extends StatelessWidget {
  const _RegisterScreenView();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          _RegisterViewHeader(),
          _RegisterForm(),
          _RegisterViewFooter(),
        ],
      ),
    );
  }
}

class _RegisterViewHeader extends StatelessWidget {
  const _RegisterViewHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBadgeWidget(
          label: l10n.newAccount,
          status: AppBadgeStatus.info,
        ),
        Text(
          l10n.createAccount,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          l10n.registerTagline,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm();

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
            label: l10n.firstNames,
            prefixIcon: Icons.person,
            keyboardType: TextInputType.name,
            hintText: l10n.firstNamesHint,
          ),
          AppTextFormField(
            label: l10n.lastNames,
            prefixIcon: Icons.person,
            keyboardType: TextInputType.name,
            hintText: l10n.lastNamesHint,
          ),
          AppTextFormField(
            label: l10n.birthDate,
            prefixIcon: Icons.calendar_month,
            keyboardType: TextInputType.number,
            hintText: l10n.birthDateHint,
          ),
          AppTextFormField(
            label: l10n.email,
            prefixIcon: Icons.alternate_email,
            keyboardType: TextInputType.emailAddress,
            hintText: l10n.emailPersonalHint,
          ),
          AppTextFormField(
            label: l10n.password,
            prefixIcon: Icons.lock_outline,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.visibility_outlined),
            ),
            keyboardType: TextInputType.visiblePassword,
            hintText: l10n.passwordHint,
            obscureText: true,
          ),
          AppTextFormField(
            label: l10n.confirmPassword,
            prefixIcon: Icons.lock_outline,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.visibility_outlined),
            ),
            keyboardType: TextInputType.visiblePassword,
            hintText: l10n.passwordHint,
            obscureText: true,
          ),
          const SizedBox(height: 12),
          AppButtonWidget(
            label: l10n.createAccount,
            onPressed: () {},
            variant: AppButtonVariant.primary,
            icon: Icons.arrow_forward,
          ),
        ],
      ),
    );
  }
}

class _RegisterViewFooter extends StatelessWidget {
  const _RegisterViewFooter();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          Flexible(
            child: Text(
              l10n.alreadyHaveAccount,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () => context.pushNamed(LoginScreen.screenName),
            child: Text(
              l10n.signIn,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 16,
                color: colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
