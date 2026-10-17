import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';

enum ResultPopAction { clearForm, keepForm }

class ResultDetailArgs {
  const ResultDetailArgs({
    required this.result,
    this.canModifyParameters = false,
  });

  final CalculationHistory result;
  final bool canModifyParameters;
}
