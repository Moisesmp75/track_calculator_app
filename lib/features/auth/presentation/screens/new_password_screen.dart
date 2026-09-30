import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/login_screen.dart';
import 'package:vehicle_calculator/features/auth/presentation/utils/auth_form_validators.dart';
import 'package:vehicle_calculator/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/extensions/snackbar_extension.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/custom_app_bar.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class NewPasswordScreen extends StatelessWidget {
  static const screenName = '/new-password';

  const NewPasswordScreen({super.key, required this.resetToken});

  final String resetToken;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      appBar: CustomAppBar(title: l10n.newPasswordTitle),
      body: _NewPasswordView(resetToken: resetToken),
    );
  }
}

class _NewPasswordView extends StatelessWidget {
  const _NewPasswordView({required this.resetToken});

  final String resetToken;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          const _NewPasswordHeader(),
          _NewPasswordForm(resetToken: resetToken),
        ],
      ),
    );
  }
}

class _NewPasswordHeader extends StatelessWidget {
  const _NewPasswordHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBadgeWidget(
          label: l10n.recoverPassword,
          status: AppBadgeStatus.info,
        ),
        Text(
          l10n.newPasswordTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          l10n.newPasswordTagline,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _NewPasswordForm extends ConsumerStatefulWidget {
  const _NewPasswordForm({required this.resetToken});

  final String resetToken;

  @override
  ConsumerState<_NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends ConsumerState<_NewPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onChanged);
    _confirmPasswordController.addListener(_onChanged);
  }

  void _onChanged() => setState(() {});

  bool get _isValid {
    return AuthFormValidators.isValidPassword(_passwordController.text) &&
        _confirmPasswordController.text == _passwordController.text;
  }

  @override
  void dispose() {
    _passwordController
      ..removeListener(_onChanged)
      ..dispose();
    _confirmPasswordController
      ..removeListener(_onChanged)
      ..dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (widget.resetToken.isEmpty) return;

    final l10n = AppLocalizations.of(context);
    final success = await ref.read(authViewModelProvider.notifier).resetPassword(
      resetToken: widget.resetToken,
      newPassword: _passwordController.text,
      networkErrorMessage: l10n.networkError,
    );
    if (!mounted) return;

    if (!success) {
      final message = ref.read(authViewModelProvider).errorMessage;
      if (message != null) {
        context.showSnackBar(message: message);
      }
      return;
    }

    context.showSnackBar(message: l10n.passwordUpdated);
    context.goNamed(LoginScreen.screenName);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
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
              label: l10n.newPassword,
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
              label: l10n.confirmNewPassword,
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
              label: l10n.saveNewPassword,
              onPressed: _submit,
              enabled: _isValid && widget.resetToken.isNotEmpty,
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
