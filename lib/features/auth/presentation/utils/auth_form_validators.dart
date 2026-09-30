class AuthFormValidators {
  static final emailPattern = RegExp(
    r'^[\w.\-+]+@[\w\-]+(\.[\w\-]+)+$',
  );
  static final namePattern = RegExp(r'^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ]+$');
  static final _upper = RegExp(r'[A-Z]');
  static final _lower = RegExp(r'[a-z]');
  static final _digit = RegExp(r'[0-9]');

  static bool isValidEmail(String value) =>
      emailPattern.hasMatch(value.trim());

  static bool isValidName(String value) {
    final name = value.trim();
    return name.isNotEmpty &&
        name.length <= 20 &&
        namePattern.hasMatch(name);
  }

  static bool isValidPassword(String value) {
    return value.length >= 10 &&
        _upper.hasMatch(value) &&
        _lower.hasMatch(value) &&
        _digit.hasMatch(value);
  }

  static bool isValidOptionalBornDate(String value) {
    final text = value.trim();
    if (text.isEmpty) return true;
    return isValidRequiredBornDate(text);
  }

  static bool isValidRequiredBornDate(String value) {
    return RegExp(r'^(\d{2})/(\d{2})/(\d{4})$').hasMatch(value.trim());
  }
}
