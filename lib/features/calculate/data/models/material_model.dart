class MaterialModel {
  const MaterialModel({
    required this.id,
    required this.name,
    required this.compactedDensityKgM3,
    required this.looseDensityKgM3,
    required this.swellFactor,
    required this.isActive,
  });

  final String id;
  final String name;
  final double compactedDensityKgM3;
  final double looseDensityKgM3;
  final double swellFactor;
  final bool isActive;

  factory MaterialModel.fromJson(Map<String, dynamic> json) {
    return MaterialModel(
      id: json['id'] as String,
      name: json['name'] as String,
      compactedDensityKgM3: double.parse(json['compactedDensityKgM3'] as String),
      looseDensityKgM3: double.parse(json['looseDensityKgM3'] as String),
      swellFactor: double.parse(json['swellFactor'] as String),
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}
