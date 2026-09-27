import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/create_calculation_input.dart';

abstract class CalculationRepository {
  Future<CalculationHistory> processAndSave(CreateCalculationInput input);
}
