String? toIsoBornDate(String input) {
  final match = RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').firstMatch(input.trim());
  if (match == null) return null;
  return '${match[3]}-${match[2]}-${match[1]}';
}
