import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/core/error/api_exception.dart';
import 'package:vehicle_calculator/features/calculate/data/providers/calculation_repository_provider.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/create_calculation_input.dart';
import 'package:vehicle_calculator/features/history/presentation/viewmodels/history_view_model.dart';

class CalculatorState {
  const CalculatorState({
    this.isSubmitting = false,
    this.errorMessage,
  });

  final bool isSubmitting;
  final String? errorMessage;
}

final calculatorViewModelProvider =
    NotifierProvider<CalculatorViewModel, CalculatorState>(
      CalculatorViewModel.new,
    );

class CalculatorViewModel extends Notifier<CalculatorState> {
  @override
  CalculatorState build() => const CalculatorState();

  Future<CalculationHistory?> submit({
    required CreateCalculationInput input,
    required String networkErrorMessage,
  }) async {
    state = const CalculatorState(isSubmitting: true);
    try {
      final result = await ref
          .read(calculationRepositoryProvider)
          .processAndSave(input);
      ref.invalidate(historyViewModelProvider);
      state = const CalculatorState();
      return result;
    } on ApiException catch (error) {
      state = CalculatorState(errorMessage: error.message);
      return null;
    } catch (_) {
      state = CalculatorState(errorMessage: networkErrorMessage);
      return null;
    }
  }
}
