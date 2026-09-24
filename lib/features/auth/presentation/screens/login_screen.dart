import 'package:flutter/material.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_badge_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_button_widget.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/app_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  static const screenName = '/login';
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: _LoginScreenView()
    );
  }
}

class _LoginScreenView extends StatelessWidget {
  const _LoginScreenView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          spacing: 12,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _LoginViewHeader(),
            _LoginForm(),
            _LoginViewFooter()
          ],
        ),
      ),
    );
  }
}

class _LoginViewHeader extends StatelessWidget {
  const _LoginViewHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: 12,
      children: [
        // AppIconWidget(action: AppIconAction.profile),
        AppBadgeWidget(
          label: 'PORTAL ACADÉMICO',
          showDot: false,
          status: AppBadgeStatus.info,
        ),
        Text(
          'Acarreo U',
          style: theme.textTheme.titleLarge?.copyWith(
            // fontFamily: '',
            fontSize: 32,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          'Optimización de ciclo, pala y tolvas para minería e ingeniería civil',
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        )
      ]
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
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
            label: 'Correo Institucional',
            hintText: 'alumno@uni.edu.pe',
            prefixIcon: Icons.alternate_email,
            keyboardType: TextInputType.emailAddress,
            // controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu correo';
              }

              return null;
            },
          ),
          AppTextFormField(
            label: 'Contraseña',
            prefixIcon: Icons.lock_outline,
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.visibility_outlined),
            ),
            obscureText: true,
            // controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingresa tu contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 6),
          AppButtonWidget(
            label: 'Iniciar Sesion',
            onPressed: (){},
            variant: AppButtonVariant.primary,
            icon: Icons.arrow_forward,
          )
        ],
      )
    );
  }
}

class _LoginViewFooter extends StatelessWidget {
  const _LoginViewFooter();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 8,
      children: [
        Text(
          'Aún no tienes una cuenta?',
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: (){},
          child: Text(
            'Registrate aquí',
            style: theme.textTheme.bodySmall?.copyWith(
              fontSize: 16,
              color: colorScheme.primary,
            ),
          ),
        )
      ]
    );
  }
}
