import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/core/error/api_exception.dart';
import 'package:vehicle_calculator/features/auth/data/providers/auth_repository_provider.dart';
import 'package:vehicle_calculator/features/auth/domain/model/user.dart';
import 'package:vehicle_calculator/features/auth/domain/repositories/auth_repository.dart';

enum AuthStatus { unknown, unauthenticated, authenticated }

class AuthState {
  const AuthState({
    this.status = AuthStatus.unknown,
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  final AuthStatus status;
  final User? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    bool? isLoading,
    String? errorMessage,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

final authViewModelProvider =
    NotifierProvider<AuthViewModel, AuthState>(AuthViewModel.new);

class AuthViewModel extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthState();

  AuthRepository get _repository => ref.read(authRepositoryProvider);

  Future<bool> restoreSession() async {
    try {
      final session = await _repository.restoreSession();
      if (session == null) {
        state = const AuthState(status: AuthStatus.unauthenticated);
        return false;
      }

      state = AuthState(
        status: AuthStatus.authenticated,
        user: session.user,
      );
      return true;
    } catch (_) {
      await _repository.logout();
      state = const AuthState(status: AuthStatus.unauthenticated);
      return false;
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
    required String networkErrorMessage,
  }) {
    return _run(() async {
      final session = await _repository.signIn(
        email: email.trim(),
        password: password,
      );
      state = state.copyWith(
        user: session.user,
        status: AuthStatus.authenticated,
        clearError: true,
      );
    }, networkErrorMessage);
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
    required String lastName,
    required String bornDate,
    required String networkErrorMessage,
  }) {
    return _run(() async {
      await _repository.signUp(
        email: email.trim(),
        password: password,
        name: name.trim(),
        lastName: lastName.trim(),
        bornDate: bornDate,
      );
    }, networkErrorMessage);
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  Future<bool> _run(
    Future<void> Function() action,
    String networkErrorMessage,
  ) async {
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      await action();
      state = state.copyWith(isLoading: false);
      return true;
    } on ApiException catch (error) {
      state = state.copyWith(isLoading: false, errorMessage: error.message);
      return false;
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: networkErrorMessage,
      );
      return false;
    }
  }
}
