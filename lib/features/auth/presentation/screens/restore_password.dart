import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vehicle_calculator/features/auth/presentation/screens/new_password_screen.dart';
import 'package:vehicle_calculator/features/auth/presentation/utils/auth_form_validators.dart';
import 'package:vehicle_calculator/features/auth/presentation/utils/born_date_input_formatter.dart';
import 'package:vehicle_calculator/features/auth/presentation/utils/born_date_parser.dart';
import 'package:vehicle_calculator/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:vehicle_calculator/features/shared/presentation/extensions/snackbar_extension.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_scaffold.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/custom_app_bar.dart';
import 'package:vehicle_calculator/l10n/app_localizations.dart';

class RestorePassword extends StatelessWidget {
  static const screenName = '/restore-password';
  const RestorePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppScaffold(
      appBar: CustomAppBar(title: l10n.recoverPasswordTitle),
      body: const _RestorePasswordView(),
    );
  }
}

class _RestorePasswordView extends StatelessWidget {
  const _RestorePasswordView();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          _RestorePasswordHeader(),
          _RestorePasswordForm(),
        ],
      ),
    );
  }
}

class _RestorePasswordHeader extends StatelessWidget {
  const _RestorePasswordHeader();

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
          l10n.recoverPasswordTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          l10n.recoverPasswordTagline,
          style: theme.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _RestorePasswordForm extends ConsumerStatefulWidget {
  const _RestorePasswordForm();

  @override
  ConsumerState<_RestorePasswordForm> createState() =>
      _RestorePasswordFormState();
}

class _RestorePasswordFormState extends ConsumerState<_RestorePasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _bornDateController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (final controller in [
      _nameController,
      _lastNameController,
      _bornDateController,
      _emailController,
    ]) {
      controller.addListener(_onChanged);
    }
  }

  void _onChanged() => setState(() {});

  bool get _isValid {
    return AuthFormValidators.isValidName(_nameController.text) &&
        AuthFormValidators.isValidName(_lastNameController.text) &&
        AuthFormValidators.isValidEmail(_emailController.text) &&
        AuthFormValidators.isValidRequiredBornDate(_bornDateController.text) &&
        toIsoBornDate(_bornDateController.text) != null;
  }

  @override
  void dispose() {
    for (final controller in [
      _nameController,
      _lastNameController,
      _bornDateController,
      _emailController,
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
    final bornDate = toIsoBornDate(_bornDateController.text);
    if (bornDate == null) return;

    final token = await ref
        .read(authViewModelProvider.notifier)
        .verifyPasswordRecovery(
          email: _emailController.text,
          name: _nameController.text,
          lastName: _lastNameController.text,
          bornDate: bornDate,
          networkErrorMessage: l10n.networkError,
        );
    if (!mounted) return;

    if (token == null || token.isEmpty) {
      final message = ref.read(authViewModelProvider).errorMessage;
      if (message != null) {
        context.showSnackBar(message: message);
      }
      return;
    }

    context.pushNamed(NewPasswordScreen.screenName, extra: token);
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
                  return l10n.birthDateRequired;
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
            const SizedBox(height: 12),
            AppButtonWidget(
              label: l10n.verifyIdentity,
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
