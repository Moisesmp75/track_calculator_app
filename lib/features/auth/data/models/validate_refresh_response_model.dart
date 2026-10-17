class ValidateRefreshResponseModel {
  const ValidateRefreshResponseModel({required this.valid});

  final bool valid;

  factory ValidateRefreshResponseModel.fromJson(Map<String, dynamic> json) {
    return ValidateRefreshResponseModel(valid: json['valid'] == true);
  }
}
