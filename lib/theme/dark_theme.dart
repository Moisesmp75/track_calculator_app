import 'package:flutter/material.dart';

import 'app_typography.dart';

final ColorScheme darkColorScheme = const ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF4FDBC8),
  onPrimary: Color(0xFF003731),
  primaryContainer: Color(0xFF14B8A6),
  onPrimaryContainer: Color(0xFF00423B),
  secondary: Color(0xFF44E2CD),
  onSecondary: Color(0xFF003731),
  secondaryContainer: Color(0xFF03C6B2),
  onSecondaryContainer: Color(0xFF004D44),
  tertiary: Color(0xFF7BD0FF),
  onTertiary: Color(0xFF00354A),
  tertiaryContainer: Color(0xFF1EB0EA),
  onTertiaryContainer: Color(0xFF003F58),
  error: Color(0xFFFFB4AB),
  onError: Color(0xFF690005),
  errorContainer: Color(0xFF93000A),
  onErrorContainer: Color(0xFFFFDAD6),
  surface: Color(0xFF0B141E),
  onSurface: Color(0xFFDAE3F1),
  onSurfaceVariant: Color(0xFFBBCAC6),
  surfaceContainerLowest: Color(0xFF111A24),
  surfaceContainerLow: Color(0xFF16202C),
  surfaceContainer: Color(0xFF1A2533),
  surfaceContainerHigh: Color(0xFF1E2D3D),
  surfaceContainerHighest: Color(0xFF243548),
  outline: Color(0xFF859490),
  outlineVariant: Color(0xFF3C4947),
  inverseSurface: Color(0xFFDAE3F1),
  onInverseSurface: Color(0xFF28313C),
  inversePrimary: Color(0xFF006B5F),
  surfaceTint: Color(0xFF4FDBC8),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: const Color(0xFF0B131C),
  textTheme: AppTypography.darkTextTheme,

  // Tarjetas Nocturnas
  cardTheme: CardThemeData(
    color: const Color(0xFF1E2D3D),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: Color(0xFF243548), width: 1),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF14B8A6),
      foregroundColor: const Color(0xFF0B131C),
      minimumSize: const Size.fromHeight(56),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: AppTypography.darkTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    ),
  ),


  inputDecorationTheme: InputDecorationThemeData(
    // filled: true,
    // fillColor: const Color(0xFF111A24),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: InputBorder.none,
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(8),
    //   borderSide: const BorderSide(color: Color(0xFF243548)),
    // ),
    // enabledBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(8),
    //   borderSide: const BorderSide(color: Color(0xFF243548)),
    // ),
    // focusedBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(8),
    //   borderSide: const BorderSide(color: Color(0xFF2DD4BF), width: 1.5),
    // ),
    hintStyle: const TextStyle(color: Color(0xFF475569)),
  ),
);
