import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/register_screen.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/restore_password.dart';
import 'package:vehicle_calculator/features/auth/presentation/utils/auth_form_validators.dart';
import 'package:vehicle_calculator/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:vehicle_calculator/features/calculate/presentation/screens/calculator_screen.dart';
import 'package:vehicle_calculator/features/shared/presentation/viewmodels/locale_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/viewmodels/theme_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/extensions/snackbar_extension.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_icon_toggle.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_logo.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_version_label.dart';
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
    return const SingleChildScrollView(
      child: Column(
        spacing: 24,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _LoginPreferences(),
          _LoginViewHeader(),
          _LoginForm(),
          _LoginViewFooter(),
          AppVersionLabel(),
        ],
      ),
    );
  }
}

class _LoginPreferences extends ConsumerWidget {
  const _LoginPreferences();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final themeMode = ref.watch(themeViewModelProvider);
    final themeViewModel = ref.read(themeViewModelProvider.notifier);
    final localeViewModel = ref.read(localeViewModelProvider.notifier);

    return Align(
      alignment: Alignment.topRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          AppIconToggle(
            icon: themeMode == ThemeMode.dark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            tooltip: l10n.toggleTheme,
            onTap: themeViewModel.toggleTheme,
          ),
          AppIconToggle(
            icon: Icons.translate_outlined,
            tooltip: l10n.toggleLanguage,
            onTap: localeViewModel.toggleLocale,
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
        const AppLogo(),
        Text(
          l10n.appName,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        AppBadgeWidget(
          label: l10n.appBrandSubtitle,
          showDot: false,
          status: AppBadgeStatus.info,
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

class _LoginForm extends ConsumerStatefulWidget {
  const _LoginForm();

  @override
  ConsumerState<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_onChanged);
    _passwordController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  bool get _isValid {
    return AuthFormValidators.isValidEmail(_emailController.text) &&
        _passwordController.text.isNotEmpty;
  }

  @override
  void dispose() {
    _emailController
      ..removeListener(_onChanged)
      ..dispose();
    _passwordController
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context);
    final auth = ref.read(authViewModelProvider.notifier);
    final success = await auth.signIn(
      email: _emailController.text,
      password: _passwordController.text,
      networkErrorMessage: l10n.networkError,
    );
    if (!mounted) return;

    if (success) {
      context.goNamed(CalculatorScreen.screenName);
      return;
    }

    final message = ref.read(authViewModelProvider).errorMessage;
    if (message != null) {
      context.showSnackBar(message: message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context);
    final isLoading = ref.watch(authViewModelProvider).isLoading;

    return Form(
      key: _formKey,
      child: Container(
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
              controller: _emailController,
              prefixIcon: Icons.alternate_email,
              keyboardType: TextInputType.emailAddress,
              enabled: !isLoading,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.emailRequired;
                }
                if (!AuthFormValidators.isValidEmail(value)) {
                  return l10n.invalidEmailFormat;
                }
                return null;
              },
            ),
            AppTextFormField(
              label: l10n.password,
              hintText: l10n.passwordHint,
              controller: _passwordController,
              prefixIcon: Icons.lock_outline,
              enabled: !isLoading,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() => _obscurePassword = !_obscurePassword);
                },
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              obscureText: _obscurePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.passwordRequired;
                }
                return null;
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: isLoading
                    ? null
                    : () => context.pushNamed(RestorePassword.screenName),
                child: Text(
                  l10n.forgotPassword,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
            AppButtonWidget(
              label: l10n.signIn,
              onPressed: _submit,
              enabled: _isValid,
              isLoading: isLoading,
              variant: AppButtonVariant.primary,
              icon: Icons.arrow_forward,
            ),
          ],
        ),
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
