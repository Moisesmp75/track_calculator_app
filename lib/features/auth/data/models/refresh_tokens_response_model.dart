class RefreshTokensResponseModel {
  const RefreshTokensResponseModel({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  factory RefreshTokensResponseModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokensResponseModel(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }
}
