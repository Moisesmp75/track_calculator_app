class DumpTruckTypeModel {
  const DumpTruckTypeModel({
    required this.id,
    required this.description,
    required this.nominalVolumeM3,
    required this.weightCapacityTons,
    required this.kFactor,
    required this.isActive,
  });

  final String id;
  final String description;
  final double nominalVolumeM3;
  final double weightCapacityTons;
  final double kFactor;
  final bool isActive;

  factory DumpTruckTypeModel.fromJson(Map<String, dynamic> json) {
    return DumpTruckTypeModel(
      id: json['id'] as String,
      description: json['description'] as String,
      nominalVolumeM3: double.parse(json['nominalVolumeM3'] as String),
      weightCapacityTons: double.parse(json['weightCapacityTons'] as String),
      kFactor: double.parse(json['kFactor'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}
