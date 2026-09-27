import 'package:vehicle_calculator/core/config/api_config.dart';
import 'package:vehicle_calculator/core/network/api_client.dart';
import 'package:vehicle_calculator/features/calculate/data/models/dump_truck_type_model.dart';
import 'package:vehicle_calculator/features/calculate/data/models/material_model.dart';

class CatalogRemoteDatasource {
  const CatalogRemoteDatasource(this._apiClient);

  final ApiClient _apiClient;

  Future<List<MaterialModel>> getMaterials() {
    return _apiClient.get(
      ApiConfig.materials,
      queryParameters: const {'onlyActive': true},
      parse: (data) => _asList(data)
          .map((item) => MaterialModel.fromJson(_asMap(item)))
          .toList(),
    );
  }

  Future<List<DumpTruckTypeModel>> getDumpTruckTypes() {
    return _apiClient.get(
      ApiConfig.dumpTruckTypes,
      queryParameters: const {'onlyActive': true},
      parse: (data) => _asList(data)
          .map((item) => DumpTruckTypeModel.fromJson(_asMap(item)))
          .toList(),
    );
  }

  List<dynamic> _asList(dynamic data) {
    if (data is List) return data;
    return const [];
  }

  Map<String, dynamic> _asMap(dynamic data) {
    return Map<String, dynamic>.from(data as Map);
  }
}
