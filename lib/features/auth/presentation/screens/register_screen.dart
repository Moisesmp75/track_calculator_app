import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/login_screen.dart';
import 'package:vehicle_calculator/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:vehicle_calculator/features/auth/presentation/utils/auth_form_validators.dart';
import 'package:vehicle_calculator/features/auth/presentation/utils/born_date_input_formatter.dart';
import 'package:vehicle_calculator/features/auth/presentation/utils/born_date_parser.dart';
import 'package:vehicle_calculator/features/shared/presentation/extensions/snackbar_extension.dart';
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

class _RegisterForm extends ConsumerStatefulWidget {
  const _RegisterForm();

  @override
  ConsumerState<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends ConsumerState<_RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _bornDateController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    for (final controller in [
      _nameController,
      _lastNameController,
      _bornDateController,
      _emailController,
      _passwordController,
      _confirmPasswordController,
    ]) {
      controller.addListener(_onChanged);
    }
  }

  void _onChanged() => setState(() {});

  bool get _isValid {
    return AuthFormValidators.isValidName(_nameController.text) &&
        AuthFormValidators.isValidName(_lastNameController.text) &&
        AuthFormValidators.isValidEmail(_emailController.text) &&
        AuthFormValidators.isValidPassword(_passwordController.text) &&
        _confirmPasswordController.text == _passwordController.text &&
        AuthFormValidators.isValidOptionalBornDate(_bornDateController.text);
  }

  @override
  void dispose() {
    for (final controller in [
      _nameController,
      _lastNameController,
      _bornDateController,
      _emailController,
      _passwordController,
      _confirmPasswordController,
    ]) {
      controller
        ..removeListener(_onChanged)
        ..dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context);
    final bornDateRaw = _bornDateController.text.trim();
    final bornDate = bornDateRaw.isEmpty ? null : toIsoBornDate(bornDateRaw);

    final auth = ref.read(authViewModelProvider.notifier);
    final success = await auth.signUp(
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
      lastName: _lastNameController.text,
      bornDate: bornDate,
      networkErrorMessage: l10n.networkError,
    );
    if (!mounted) return;

    if (success) {
      context.showSnackBar(message: l10n.registerSuccess);
      context.goNamed(LoginScreen.screenName);
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
              label: l10n.firstNames,
              controller: _nameController,
              prefixIcon: Icons.person,
              keyboardType: TextInputType.name,
              hintText: l10n.firstNamesHint,
              enabled: !isLoading,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.fieldRequired;
                }
                if (!AuthFormValidators.isValidName(value)) {
                  return l10n.invalidNameFormat;
                }
                return null;
              },
            ),
            AppTextFormField(
              label: l10n.lastNames,
              controller: _lastNameController,
              prefixIcon: Icons.person,
              keyboardType: TextInputType.name,
              hintText: l10n.lastNamesHint,
              enabled: !isLoading,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return l10n.fieldRequired;
                }
                if (!AuthFormValidators.isValidName(value)) {
                  return l10n.invalidNameFormat;
                }
                return null;
              },
            ),
            AppTextFormField(
              label: l10n.birthDate,
              controller: _bornDateController,
              prefixIcon: Icons.calendar_month,
              keyboardType: TextInputType.number,
              inputFormatters: const [BornDateInputFormatter()],
              hintText: l10n.birthDateHint,
              enabled: !isLoading,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return null;
                }
                if (toIsoBornDate(value) == null) {
                  return l10n.invalidBirthDateFormat;
                }
                return null;
              },
            ),
            AppTextFormField(
              label: l10n.email,
              controller: _emailController,
              prefixIcon: Icons.alternate_email,
              keyboardType: TextInputType.emailAddress,
              hintText: l10n.emailPersonalHint,
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
              controller: _passwordController,
              prefixIcon: Icons.lock_outline,
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
              keyboardType: TextInputType.visiblePassword,
              hintText: l10n.passwordHint,
              obscureText: _obscurePassword,
              enabled: !isLoading,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return l10n.passwordRequired;
                }
                if (!AuthFormValidators.isValidPassword(value)) {
                  return l10n.invalidPasswordFormat;
                }
                return null;
              },
            ),
            AppTextFormField(
              label: l10n.confirmPassword,
              controller: _confirmPasswordController,
              prefixIcon: Icons.lock_outline,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
              keyboardType: TextInputType.visiblePassword,
              hintText: l10n.passwordHint,
              obscureText: _obscureConfirmPassword,
              enabled: !isLoading,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value != _passwordController.text) {
                  return l10n.passwordsDoNotMatch;
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            AppButtonWidget(
              label: l10n.createAccount,
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
