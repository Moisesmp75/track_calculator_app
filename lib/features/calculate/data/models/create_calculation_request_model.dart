class CreateCalculationRequestModel {
  const CreateCalculationRequestModel({
    required this.materialId,
    required this.dumpTruckTypeId,
    required this.distanceKm,
    required this.loadedSpeedKmh,
    required this.unloadedSpeedKmh,
    required this.shiftHours,
    required this.efficiency,
    required this.loaderPerformanceM3h,
    this.projectName,
    this.section,
    this.dumpTruckHourlyRate,
    this.loaderHourlyRate,
    this.staffHourlyRate,
  });

  final String materialId;
  final String dumpTruckTypeId;
  final double distanceKm;
  final double loadedSpeedKmh;
  final double unloadedSpeedKmh;
  final double shiftHours;
  final double efficiency;
  final double loaderPerformanceM3h;
  final String? projectName;
  final String? section;
  final double? dumpTruckHourlyRate;
  final double? loaderHourlyRate;
  final double? staffHourlyRate;

  Map<String, dynamic> toJson() {
    return {
      'materialId': materialId,
      'dumpTruckTypeId': dumpTruckTypeId,
      'distanceKm': distanceKm,
      'loadedSpeedKmh': loadedSpeedKmh,
      'unloadedSpeedKmh': unloadedSpeedKmh,
      'shiftHours': shiftHours,
      'efficiency': efficiency,
      'loaderPerformanceM3h': loaderPerformanceM3h,
      if (projectName != null) 'projectName': projectName,
      if (section != null) 'section': section,
      if (dumpTruckHourlyRate != null) 'dumpTruckHourlyRate': dumpTruckHourlyRate,
      if (loaderHourlyRate != null) 'loaderHourlyRate': loaderHourlyRate,
      if (staffHourlyRate != null) 'staffHourlyRate': staffHourlyRate,
    };
  }
}
