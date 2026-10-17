import 'package:vehicle_calculator/features/calculate/data/models/dump_truck_type_model.dart';
import 'package:vehicle_calculator/features/calculate/data/models/material_model.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/catalog_dump_truck_type.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/catalog_material.dart';

class CatalogMapper {
  const CatalogMapper();

  CatalogMaterial toMaterial(MaterialModel model) {
    return CatalogMaterial(
      id: model.id,
      name: model.name,
      compactedDensityKgM3: model.compactedDensityKgM3,
      looseDensityKgM3: model.looseDensityKgM3,
      swellFactor: model.swellFactor,
    );
  }

  CatalogDumpTruckType toDumpTruckType(DumpTruckTypeModel model) {
    return CatalogDumpTruckType(
      id: model.id,
      description: model.description,
      nominalVolumeM3: model.nominalVolumeM3,
      weightCapacityTons: model.weightCapacityTons,
      kFactor: model.kFactor,
    );
  }
}
