class CalculationHistoryModel {
  const CalculationHistoryModel({
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

  factory CalculationHistoryModel.fromJson(Map<String, dynamic> json) {
    return CalculationHistoryModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      materialId: json['materialId'] as String,
      dumpTruckTypeId: json['dumpTruckTypeId'] as String,
      distanceKm: _toDouble(json['distanceKm']),
      loadedSpeedKmh: _toDouble(json['loadedSpeedKmh']),
      unloadedSpeedKmh: _toDouble(json['unloadedSpeedKmh']),
      shiftHours: _toDouble(json['shiftHours']),
      efficiency: _toDouble(json['efficiency']),
      dumpTruckVolumeM3: _toDouble(json['dumpTruckVolumeM3']),
      loaderPerformanceM3h: _toDouble(json['loaderPerformanceM3h']),
      compactedDensityKgM3: _toDouble(json['compactedDensityKgM3']),
      looseDensityKgM3: _toDouble(json['looseDensityKgM3']),
      calculatedSwellFactor: _toDouble(json['calculatedSwellFactor']),
      effectiveCapacityM3: _toDouble(json['effectiveCapacityM3']),
      cycleTimeMinutes: _toDouble(json['cycleTimeMinutes']),
      tripsPerShiftPerTruck: _toDouble(json['tripsPerShiftPerTruck']),
      suggestedTrucksCount: _toDouble(json['suggestedTrucksCount']),
      totalVolumeTransportedM3: _toDouble(json['totalVolumeTransportedM3']),
      hourlyPerformanceM3h: _toDouble(json['hourlyPerformanceM3h']),
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
          DateTime.now(),
      projectName: json['projectName'] as String?,
      section: json['section'] as String?,
      dumpTruckHourlyRate: _toDoubleOrNull(json['dumpTruckHourlyRate']),
      loaderHourlyRate: _toDoubleOrNull(json['loaderHourlyRate']),
      staffHourlyRate: _toDoubleOrNull(json['staffHourlyRate']),
      unitCostPerM3: _toDoubleOrNull(json['unitCostPerM3']),
    );
  }

  static double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double? _toDoubleOrNull(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
