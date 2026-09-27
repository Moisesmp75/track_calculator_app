import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/core/di/core_providers.dart';
import 'package:vehicle_calculator/features/calculate/data/datasources/catalog_remote_datasource.dart';
import 'package:vehicle_calculator/features/calculate/data/repositories/catalog_repository_impl.dart';
import 'package:vehicle_calculator/features/calculate/domain/repositories/catalog_repository.dart';

final catalogRemoteDatasourceProvider = Provider<CatalogRemoteDatasource>((ref) {
  return CatalogRemoteDatasource(ref.watch(apiClientProvider));
});

final catalogRepositoryProvider = Provider<CatalogRepository>((ref) {
  return CatalogRepositoryImpl(
    datasource: ref.watch(catalogRemoteDatasourceProvider),
  );
});
