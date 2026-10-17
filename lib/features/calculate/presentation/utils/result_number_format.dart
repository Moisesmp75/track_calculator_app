import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ResultNumberFormat {
  const ResultNumberFormat._();

  static String decimal(
    BuildContext context,
    double value, {
    int maxDecimals = 1,
  }) {
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toString(),
    )..maximumFractionDigits = maxDecimals;
    return format.format(value);
  }

  static String count(double value) {
    if (value == value.roundToDouble()) {
      return value.toStringAsFixed(0);
    }
    return value.toStringAsFixed(1);
  }
}
