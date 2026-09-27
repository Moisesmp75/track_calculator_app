import 'package:vehicle_calculator/features/calculate/data/datasources/calculation_remote_datasource.dart';
import 'package:vehicle_calculator/features/calculate/data/mappers/calculation_mapper.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/create_calculation_input.dart';
import 'package:vehicle_calculator/features/calculate/domain/repositories/calculation_repository.dart';

class CalculationRepositoryImpl implements CalculationRepository {
  CalculationRepositoryImpl({
    required this._datasource,
    this._mapper = const CalculationMapper(),
  });

  final CalculationRemoteDatasource _datasource;
  final CalculationMapper _mapper;

  @override
  Future<CalculationHistory> processAndSave(CreateCalculationInput input) async {
    final model = await _datasource.processAndSave(_mapper.toRequest(input));
    return _mapper.toDomain(model);
  }

  @override
  Future<List<CalculationHistory>> getMine() async {
    final models = await _datasource.getMine();
    return models.map(_mapper.toDomain).toList();
  }
}
