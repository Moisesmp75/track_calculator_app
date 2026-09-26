import 'package:vehicle_calculator/core/config/api_config.dart';
import 'package:vehicle_calculator/core/network/api_client.dart';
import 'package:vehicle_calculator/features/auth/data/models/refresh_tokens_response_model.dart';
import 'package:vehicle_calculator/features/auth/data/models/sign_in_request_model.dart';
import 'package:vehicle_calculator/features/auth/data/models/sign_in_response_model.dart';
import 'package:vehicle_calculator/features/auth/data/models/sign_up_request_model.dart';
import 'package:vehicle_calculator/features/auth/data/models/user_model.dart';
import 'package:vehicle_calculator/features/auth/data/models/validate_refresh_response_model.dart';

class AuthRemoteDatasource {
  const AuthRemoteDatasource(this._apiClient);

  final ApiClient _apiClient;

  Future<UserModel> signUp(SignUpRequestModel request) {
    return _apiClient.post(
      ApiConfig.signUp,
      data: request.toJson(),
      skipAuth: true,
      parse: (data) => UserModel.fromJson(_asMap(data)),
    );
  }

  Future<SignInResponseModel> signIn(SignInRequestModel request) {
    return _apiClient.post(
      ApiConfig.signIn,
      data: request.toJson(),
      skipAuth: true,
      parse: (data) => SignInResponseModel.fromJson(_asMap(data)),
    );
  }

  Future<bool> validateRefreshToken(String refreshToken) {
    return _apiClient.post(
      ApiConfig.validateRefreshToken,
      data: {'refreshToken': refreshToken},
      skipAuth: true,
      parse: (data) => ValidateRefreshResponseModel.fromJson(_asMap(data)).valid,
    );
  }

  Future<RefreshTokensResponseModel> refreshToken(String refreshToken) {
    return _apiClient.post(
      ApiConfig.refreshToken,
      data: {'refreshToken': refreshToken},
      skipAuth: true,
      parse: (data) => RefreshTokensResponseModel.fromJson(_asMap(data)),
    );
  }

  Map<String, dynamic> _asMap(dynamic data) {
    return Map<String, dynamic>.from(data as Map);
  }
}
