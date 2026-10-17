import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/features/auth/data/providers/auth_repository_provider.dart';
import 'package:vehicle_calculator/features/auth/domain/model/user.dart';
import 'package:vehicle_calculator/features/auth/presentation/viewmodels/auth_view_model.dart';

class ProfileState {
  const ProfileState({
    this.isLoading = false,
    this.user,
    this.errorMessage,
  });

  final bool isLoading;
  final User? user;
  final String? errorMessage;
}

final profileViewModelProvider =
    NotifierProvider<ProfileViewModel, ProfileState>(ProfileViewModel.new);

class ProfileViewModel extends Notifier<ProfileState> {
  @override
  ProfileState build() {
    final isAuthenticated =
        ref.watch(authViewModelProvider).status == AuthStatus.authenticated;
    if (!isAuthenticated) {
      return const ProfileState();
    }

    Future.microtask(load);
    return const ProfileState(isLoading: true);
  }

  Future<void> load() async {
    if (ref.read(authViewModelProvider).status != AuthStatus.authenticated) {
      state = const ProfileState();
      return;
    }

    state = const ProfileState(isLoading: true);

    try {
      final user = await ref.read(authRepositoryProvider).getCurrentUser();
      state = ProfileState(user: user);
    } catch (_) {
      final cached = ref.read(authViewModelProvider).user;
      state = ProfileState(user: cached);
    }
  }
}
