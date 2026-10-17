class CatalogMaterial {
  const CatalogMaterial({
    required this.id,
    required this.name,
    required this.compactedDensityKgM3,
    required this.looseDensityKgM3,
    required this.swellFactor,
  });

  final String id;
  final String name;
  final double compactedDensityKgM3;
  final double looseDensityKgM3;
  final double swellFactor;

  String get label {
    final tonsPerM3 = compactedDensityKgM3 / 1000;
    return '$name - ${tonsPerM3.toStringAsFixed(2)} t/m³';
  }
}
