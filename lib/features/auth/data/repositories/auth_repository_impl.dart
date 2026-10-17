import 'package:vehicle_calculator/core/error/api_exception.dart';
import 'package:vehicle_calculator/core/storage/token_storage.dart';
import 'package:vehicle_calculator/core/utils/jwt_utils.dart';
import 'package:vehicle_calculator/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:vehicle_calculator/features/auth/data/mappers/auth_mapper.dart';
import 'package:vehicle_calculator/features/auth/data/models/sign_in_request_model.dart';
import 'package:vehicle_calculator/features/auth/data/models/verify_password_recovery_request_model.dart';
import 'package:vehicle_calculator/features/auth/data/models/sign_up_request_model.dart';
import 'package:vehicle_calculator/features/auth/domain/model/auth_session.dart';
import 'package:vehicle_calculator/features/auth/domain/model/user.dart';
import 'package:vehicle_calculator/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this._datasource,
    required this._tokenStorage,
    this._mapper = const AuthMapper(),
  });

  final AuthRemoteDatasource _datasource;
  final TokenStorage _tokenStorage;
  final AuthMapper _mapper;

  @override
  Future<User> signUp({
    required String email,
    required String password,
    required String name,
    required String lastName,
    String? bornDate,
  }) async {
    final model = await _datasource.signUp(
      SignUpRequestModel(
        email: email,
        password: password,
        name: name,
        lastName: lastName,
        bornDate: bornDate,
      ),
    );
    return _mapper.toUser(model);
  }

  @override
  Future<AuthSession> signIn({
    required String email,
    required String password,
  }) async {
    final model = await _datasource.signIn(
      SignInRequestModel(email: email, password: password),
    );
    final session = _mapper.toSession(model);
    await _tokenStorage.save(
      accessToken: session.tokens.accessToken,
      refreshToken: session.tokens.refreshToken,
    );
    return session;
  }

  @override
  Future<AuthSession?> restoreSession() async {
    final refreshToken = _tokenStorage.refreshToken;
    if (refreshToken == null || refreshToken.isEmpty) {
      return null;
    }

    final isValid = await _datasource.validateRefreshToken(refreshToken);
    if (!isValid) {
      await _tokenStorage.clear();
      return null;
    }

    final tokensModel = await _datasource.refreshToken(refreshToken);
    final tokens = _mapper.toTokens(tokensModel);
    await _tokenStorage.save(
      accessToken: tokens.accessToken,
      refreshToken: tokens.refreshToken,
    );
    return AuthSession(tokens: tokens);
  }

  @override
  Future<User> getCurrentUser() async {
    final model = await _datasource.getCurrentUser();
    return _mapper.toUser(model);
  }

  @override
  Future<void> logout() => _tokenStorage.clear();

  @override
  Future<void> deleteAccount() async {
    final userId = JwtUtils.subject(_tokenStorage.accessToken);
    if (userId == null) {
      throw const ApiException(message: 'No se pudo identificar la cuenta.');
    }
    await _datasource.deleteUser(userId);
    await _tokenStorage.clear();
  }

  @override
  Future<String> verifyPasswordRecovery({
    required String email,
    required String name,
    required String lastName,
    required String bornDate,
  }) async {
    final model = await _datasource.verifyPasswordRecovery(
      VerifyPasswordRecoveryRequestModel(
        email: email,
        name: name,
        lastName: lastName,
        bornDate: bornDate,
      ),
    );
    return model.resetToken;
  }

  @override
  Future<void> resetPassword({
    required String resetToken,
    required String newPassword,
  }) {
    return _datasource.resetPassword(
      resetToken: resetToken,
      newPassword: newPassword,
    );
  }
}
