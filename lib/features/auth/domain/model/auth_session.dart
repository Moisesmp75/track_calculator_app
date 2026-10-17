import 'package:vehicle_calculator/features/auth/domain/model/auth_tokens.dart';
import 'package:vehicle_calculator/features/auth/domain/model/user.dart';

class AuthSession {
  const AuthSession({
    required this.tokens,
    this.user,
  });

  final AuthTokens tokens;
  final User? user;
}
