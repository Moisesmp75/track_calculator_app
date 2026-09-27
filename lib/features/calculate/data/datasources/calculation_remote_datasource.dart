import 'package:vehicle_calculator/core/config/api_config.dart';
import 'package:vehicle_calculator/core/network/api_client.dart';
import 'package:vehicle_calculator/features/calculate/data/models/calculation_history_model.dart';
import 'package:vehicle_calculator/features/calculate/data/models/create_calculation_request_model.dart';

class CalculationRemoteDatasource {
  const CalculationRemoteDatasource(this._apiClient);

  final ApiClient _apiClient;

  Future<CalculationHistoryModel> processAndSave(
    CreateCalculationRequestModel request,
  ) {
    return _apiClient.post(
      ApiConfig.calculationHistories,
      data: request.toJson(),
      parse: (data) => CalculationHistoryModel.fromJson(_asMap(data)),
    );
  }

  Map<String, dynamic> _asMap(dynamic data) {
    return Map<String, dynamic>.from(data as Map);
  }
}
