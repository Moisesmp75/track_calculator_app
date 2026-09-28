import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vehicle_calculator/features/calculate/data/providers/calculation_repository_provider.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';

class HistoryState {
  const HistoryState({
    this.isLoading = false,
    this.items = const [],
    this.errorMessage,
  });

  final bool isLoading;
  final List<CalculationHistory> items;
  final String? errorMessage;
}

final historyViewModelProvider =
    NotifierProvider<HistoryViewModel, HistoryState>(HistoryViewModel.new);

class HistoryViewModel extends Notifier<HistoryState> {
  @override
  HistoryState build() {
    Future.microtask(load);
    return const HistoryState(isLoading: true);
  }

  Future<void> load() async {
    state = HistoryState(isLoading: true, items: state.items);
    try {
      final items = await ref.read(calculationRepositoryProvider).getMine();
      state = HistoryState(items: items);
    } catch (error) {
      state = HistoryState(
        items: state.items,
        errorMessage: error.toString(),
      );
    }
  }

  Future<bool> delete(String id) async {
    try {
      await ref.read(calculationRepositoryProvider).delete(id);
      state = HistoryState(
        items: state.items.where((item) => item.id != id).toList(),
      );
      return true;
    } catch (error) {
      state = HistoryState(
        items: state.items,
        errorMessage: error.toString(),
      );
      return false;
    }
  }
}
