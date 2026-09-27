class CatalogDumpTruckType {
  const CatalogDumpTruckType({
    required this.id,
    required this.description,
    required this.nominalVolumeM3,
    required this.weightCapacityTons,
    required this.kFactor,
  });

  final String id;
  final String description;
  final double nominalVolumeM3;
  final double weightCapacityTons;
  final double kFactor;

  String get label => '$description - $nominalVolumeM3 m³';
}
