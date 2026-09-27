double? parseOptionalNumber(String raw) {
  final normalized = raw.trim().replaceAll(',', '.');
  if (normalized.isEmpty) return null;
  return double.tryParse(normalized);
}

bool isPositive(double? value) => value != null && value > 0;

bool isValidSpeed(double? value) {
  return value != null && value > 0 && value <= 120;
}

bool isValidEfficiency(double? value) {
  return value != null && value > 0 && value <= 1;
}
