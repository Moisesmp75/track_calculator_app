class CalculationHistory {
  const CalculationHistory({
    required this.id,
    required this.userId,
    required this.materialId,
    required this.dumpTruckTypeId,
    required this.distanceKm,
    required this.loadedSpeedKmh,
    required this.unloadedSpeedKmh,
    required this.shiftHours,
    required this.efficiency,
    required this.dumpTruckVolumeM3,
    required this.loaderPerformanceM3h,
    required this.compactedDensityKgM3,
    required this.looseDensityKgM3,
    required this.calculatedSwellFactor,
    required this.effectiveCapacityM3,
    required this.cycleTimeMinutes,
    required this.tripsPerShiftPerTruck,
    required this.suggestedTrucksCount,
    required this.totalVolumeTransportedM3,
    required this.hourlyPerformanceM3h,
    required this.createdAt,
    this.projectName,
    this.section,
    this.dumpTruckHourlyRate,
    this.loaderHourlyRate,
    this.staffHourlyRate,
    this.unitCostPerM3,
  });

  final String id;
  final String userId;
  final String materialId;
  final String dumpTruckTypeId;
  final double distanceKm;
  final double loadedSpeedKmh;
  final double unloadedSpeedKmh;
  final double shiftHours;
  final double efficiency;
  final double dumpTruckVolumeM3;
  final double loaderPerformanceM3h;
  final double compactedDensityKgM3;
  final double looseDensityKgM3;
  final double calculatedSwellFactor;
  final double effectiveCapacityM3;
  final double cycleTimeMinutes;
  final double tripsPerShiftPerTruck;
  final double suggestedTrucksCount;
  final double totalVolumeTransportedM3;
  final double hourlyPerformanceM3h;
  final DateTime createdAt;
  final String? projectName;
  final String? section;
  final double? dumpTruckHourlyRate;
  final double? loaderHourlyRate;
  final double? staffHourlyRate;
  final double? unitCostPerM3;

  bool get hasUnitCost => unitCostPerM3 != null && unitCostPerM3! > 0;
}
