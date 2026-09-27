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
  var _hasLoaded = false;

  @override
  ProfileState build() {
    Future.microtask(loadIfNeeded);
    return const ProfileState(isLoading: true);
  }

  Future<void> loadIfNeeded() async {
    if (_hasLoaded) return;
    await load();
  }

  Future<void> load() async {
    state = const ProfileState(isLoading: true);

    try {
      final user = await ref.read(authRepositoryProvider).getCurrentUser();
      _hasLoaded = true;
      state = ProfileState(user: user);
    } catch (_) {
      final cached = ref.read(authViewModelProvider).user;
      _hasLoaded = cached != null;
      state = ProfileState(user: cached);
    }
  }
}
