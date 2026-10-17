import 'package:vehicle_calculator/features/calculate/data/models/calculation_history_model.dart';
import 'package:vehicle_calculator/features/calculate/data/models/create_calculation_request_model.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/calculation_history.dart';
import 'package:vehicle_calculator/features/calculate/domain/model/create_calculation_input.dart';

class CalculationMapper {
  const CalculationMapper();

  CreateCalculationRequestModel toRequest(CreateCalculationInput input) {
    return CreateCalculationRequestModel(
      materialId: input.materialId,
      dumpTruckTypeId: input.dumpTruckTypeId,
      distanceKm: input.distanceKm,
      loadedSpeedKmh: input.loadedSpeedKmh,
      unloadedSpeedKmh: input.unloadedSpeedKmh,
      shiftHours: input.shiftHours,
      efficiency: input.efficiency,
      loaderPerformanceM3h: input.loaderPerformanceM3h,
      projectName: input.projectName,
      section: input.section,
      dumpTruckHourlyRate: input.dumpTruckHourlyRate,
      loaderHourlyRate: input.loaderHourlyRate,
      staffHourlyRate: input.staffHourlyRate,
    );
  }

  CalculationHistory toDomain(CalculationHistoryModel model) {
    return CalculationHistory(
      id: model.id,
      userId: model.userId,
      materialId: model.materialId,
      dumpTruckTypeId: model.dumpTruckTypeId,
      distanceKm: model.distanceKm,
      loadedSpeedKmh: model.loadedSpeedKmh,
      unloadedSpeedKmh: model.unloadedSpeedKmh,
      shiftHours: model.shiftHours,
      efficiency: model.efficiency,
      dumpTruckVolumeM3: model.dumpTruckVolumeM3,
      loaderPerformanceM3h: model.loaderPerformanceM3h,
      compactedDensityKgM3: model.compactedDensityKgM3,
      looseDensityKgM3: model.looseDensityKgM3,
      calculatedSwellFactor: model.calculatedSwellFactor,
      effectiveCapacityM3: model.effectiveCapacityM3,
      cycleTimeMinutes: model.cycleTimeMinutes,
      tripsPerShiftPerTruck: model.tripsPerShiftPerTruck,
      suggestedTrucksCount: model.suggestedTrucksCount,
      totalVolumeTransportedM3: model.totalVolumeTransportedM3,
      hourlyPerformanceM3h: model.hourlyPerformanceM3h,
      createdAt: model.createdAt,
      projectName: model.projectName,
      section: model.section,
      dumpTruckHourlyRate: model.dumpTruckHourlyRate,
      loaderHourlyRate: model.loaderHourlyRate,
      staffHourlyRate: model.staffHourlyRate,
      unitCostPerM3: model.unitCostPerM3,
    );
  }
}
