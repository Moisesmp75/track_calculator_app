import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/features/calculate/data/providers/catalog_repository_provider.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/catalog_dump_truck_type.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/catalog_material.dart';

class CatalogState {
  const CatalogState({
    this.isLoading = false,
    this.materials = const [],
    this.dumpTruckTypes = const [],
    this.errorMessage,
  });

  final bool isLoading;
  final List<CatalogMaterial> materials;
  final List<CatalogDumpTruckType> dumpTruckTypes;
  final String? errorMessage;
}

final catalogViewModelProvider =
    NotifierProvider<CatalogViewModel, CatalogState>(CatalogViewModel.new);

class CatalogViewModel extends Notifier<CatalogState> {
  var _hasLoaded = false;

  @override
  CatalogState build() {
    Future.microtask(loadIfNeeded);
    return const CatalogState(isLoading: true);
  }

  Future<void> loadIfNeeded() async {
    if (_hasLoaded) return;
    await load();
  }

  Future<void> load() async {
    state = const CatalogState(isLoading: true);
    try {
      final repository = ref.read(catalogRepositoryProvider);
      final results = await Future.wait([
        repository.getMaterials(),
        repository.getDumpTruckTypes(),
      ]);
      _hasLoaded = true;
      state = CatalogState(
        materials: results[0] as List<CatalogMaterial>,
        dumpTruckTypes: results[1] as List<CatalogDumpTruckType>,
      );
    } catch (error) {
      state = CatalogState(errorMessage: error.toString());
    }
  }
}
