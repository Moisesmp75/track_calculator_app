class LoaderYieldOption {
  const LoaderYieldOption({required this.label, required this.m3h});

  final String label;
  final double m3h;
}

class OperationParameterPresets {
  static const shiftHours = 8.0;

  static const loaderYields = [
    LoaderYieldOption(label: 'Retro', m3h: 60),
    LoaderYieldOption(label: 'Exc. 320', m3h: 120),
    LoaderYieldOption(label: 'Exc. 336', m3h: 140),
    LoaderYieldOption(label: 'Exc. 336', m3h: 150),
  ];

  static const loadedSpeedsKmh = [12.0, 14.0, 16.0, 20.0];
  static const returnSpeedsKmh = [16.0, 20.0, 24.0, 30.0];
  static const efficiencies = [0.9, 1.0];
}
