import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:vehicle_calculator/features/shared/presentation/widgets/simple_snack_bar.dart';

extension SnackbarExtension on BuildContext {
  void showSnackBar({
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
    String? actionText,
    VoidCallback? actionCallback,
  }) {
    final overlay = Overlay.of(this);
    final theme = Theme.of(this);
    const topPadding = 0.0;

    showTopSnackBar(
      overlay,
      padding: const EdgeInsets.only(top: topPadding),
      SimpleSnackBar(
        message: message,
        backgroundColor: backgroundColor ?? theme.colorScheme.inverseSurface,
        textColor: textColor ?? theme.colorScheme.onInverseSurface,
      ),
      displayDuration: duration,
      onTap: actionCallback,
    );
  }
}
