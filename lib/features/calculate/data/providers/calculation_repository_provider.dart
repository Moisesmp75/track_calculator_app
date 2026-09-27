import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/core/di/core_providers.dart';
import 'package:vehicle_calculator/features/calculate/data/datasources/calculation_remote_datasource.dart';
import 'package:vehicle_calculator/features/calculate/data/repositories/calculation_repository_impl.dart';
import 'package:vehicle_calculator/features/calculate/domain/repositories/calculation_repository.dart';

final calculationRemoteDatasourceProvider =
    Provider<CalculationRemoteDatasource>((ref) {
  return CalculationRemoteDatasource(ref.watch(apiClientProvider));
});

final calculationRepositoryProvider = Provider<CalculationRepository>((ref) {
  return CalculationRepositoryImpl(
    datasource: ref.watch(calculationRemoteDatasourceProvider),
  );
});
