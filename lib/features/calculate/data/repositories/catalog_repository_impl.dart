import 'package:vehicle_calculator/features/calculate/data/datasources/catalog_remote_datasource.dart';
import 'package:vehicle_calculator/features/calculate/data/mappers/catalog_mapper.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/catalog_dump_truck_type.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/catalog_material.dart';
import 'package:vehicle_calculator/features/calculate/domain/repositories/catalog_repository.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl({
    required this._datasource,
    this._mapper = const CatalogMapper(),
  });

  final CatalogRemoteDatasource _datasource;
  final CatalogMapper _mapper;

  @override
  Future<List<CatalogMaterial>> getMaterials() async {
    final models = await _datasource.getMaterials();
    return models.map(_mapper.toMaterial).toList();
  }

  @override
  Future<List<CatalogDumpTruckType>> getDumpTruckTypes() async {
    final models = await _datasource.getDumpTruckTypes();
    return models.map(_mapper.toDumpTruckType).toList();
  }
}
