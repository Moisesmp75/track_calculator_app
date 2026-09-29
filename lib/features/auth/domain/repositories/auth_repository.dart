import 'package:vehicle_calculator/features/auth/domain/model/auth_session.dart';
import 'package:vehicle_calculator/features/auth/domain/model/user.dart';

abstract class AuthRepository {
  Future<User> signUp({
    required String email,
    required String password,
    required String name,
    required String lastName,
    String? bornDate,
  });

  Future<AuthSession> signIn({
    required String email,
    required String password,
  });

  Future<AuthSession?> restoreSession();

  Future<User> getCurrentUser();

  Future<void> logout();

  Future<void> deleteAccount();
}
