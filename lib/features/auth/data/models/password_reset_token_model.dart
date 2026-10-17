class PasswordResetTokenModel {
  const PasswordResetTokenModel({
    required this.resetToken,
    required this.expiresInMinutes,
  });

  final String resetToken;
  final int expiresInMinutes;

  factory PasswordResetTokenModel.fromJson(Map<String, dynamic> json) {
    return PasswordResetTokenModel(
      resetToken: json['resetToken'] as String? ?? '',
      expiresInMinutes: json['expiresInMinutes'] as int? ?? 0,
    );
  }
}
