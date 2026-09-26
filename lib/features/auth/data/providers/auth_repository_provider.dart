import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/core/di/core_providers.dart';
import 'package:vehicle_calculator/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:vehicle_calculator/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:vehicle_calculator/features/auth/domain/repositories/auth_repository.dart';

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasource(ref.watch(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    datasource: ref.watch(authRemoteDatasourceProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
  );
});
