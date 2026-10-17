import 'package:vehicle_calculator/features/auth/data/models/refresh_tokens_response_model.dart';
import 'package:vehicle_calculator/features/auth/data/models/sign_in_response_model.dart';
import 'package:vehicle_calculator/features/auth/data/models/user_model.dart';
import 'package:vehicle_calculator/features/auth/domain/model/auth_session.dart';
import 'package:vehicle_calculator/features/auth/domain/model/auth_tokens.dart';
import 'package:vehicle_calculator/features/auth/domain/model/user.dart';

class AuthMapper {
  const AuthMapper();

  User toUser(UserModel model) {
    return User(
      email: model.email,
      name: model.name,
      lastName: model.lastName,
      bornDate: model.bornDate,
    );
  }

  AuthTokens toTokens(RefreshTokensResponseModel model) {
    return AuthTokens(
      accessToken: model.accessToken,
      refreshToken: model.refreshToken,
    );
  }

  AuthSession toSession(SignInResponseModel model) {
    return AuthSession(
      user: toUser(model.user),
      tokens: AuthTokens(
        accessToken: model.accessToken,
        refreshToken: model.refreshToken,
      ),
    );
  }
}
