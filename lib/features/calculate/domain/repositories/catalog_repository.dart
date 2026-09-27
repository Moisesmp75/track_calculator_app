import 'package:vehicle_calculator/features/calculate/domain/model/catalog_dump_truck_type.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/catalog_material.dart';

abstract class CatalogRepository {
  Future<List<CatalogMaterial>> getMaterials();

  Future<List<CatalogDumpTruckType>> getDumpTruckTypes();
}
