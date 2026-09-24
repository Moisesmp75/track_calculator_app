import 'package:flutter/material.dart';

import 'app_typography.dart';

final ColorScheme lightColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF00685F),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF008378),
  onPrimaryContainer: Color(0xFFF4FFFC),
  secondary: Color(0xFF006B5F),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF6DF5E1),
  onSecondaryContainer: Color(0xFF006F64),
  tertiary: Color(0xFF38645C),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFF517D75),
  onTertiaryContainer: Color(0xFFF4FFFB),
  error: Color(0xFFBA1A1A),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFFFDAD6),
  onErrorContainer: Color(0xFF93000A),

  // --- Capas de Superficie Material 3 (Según el HTML) ---
  surface: Color(0xFFFAF8FF), // bg-surface (Fondo de pantalla)
  onSurface: Color(0xFF131B2E),
  onSurfaceVariant: Color(0xFF3D4947),
  
  // Asignación de contenedores de superficie:
  surfaceContainerLowest: Color(0xFFFFFFFF), // Tarjeta del formulario (#ffffff)
  surfaceContainerLow: Color(0xFFF2F3FF),    // Fondo de Inputs y Cards pequeñas
  surfaceContainer: Color(0xFFEAEDFF),       // Capa intermedia
  surfaceContainerHigh: Color(0xFFE2E7FF),   // Badge "Portal Académico"
  surfaceContainerHighest: Color(0xFFDAE2FD),

  outline: Color(0xFF6D7A77),
  outlineVariant: Color(0xFFBCC9C6),
  inverseSurface: Color(0xFF283044),
  onInverseSurface: Color(0xFFEEF0FF),
  inversePrimary: Color(0xFF6BD8CB),
  surfaceTint: Color(0xFF006A61),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: const Color(0xFFFAF8FF),
  textTheme: AppTypography.lightTextTheme,

  // Modificación de bordes para tarjetas
  cardTheme: CardThemeData(
    color: const Color(0xFFFFFFFF),
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // rounded-2xl
      side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
    ),
  ),

  // Botón Principal
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0D9488),
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(56),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      textStyle: AppTypography.lightTextTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
      ),
    ),
  ),

  // Campos de Texto / Inputs
  inputDecorationTheme: InputDecorationThemeData(
    // filled: true,
    // fillColor: const Color(0xFFFFFFFF),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: InputBorder.none,
    
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(14),
    //   borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
    // ),
    // enabledBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(14),
    //   borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
    // ),
    // focusedBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(14),
    //   borderSide: const BorderSide(color: Color(0xFF0D9488), width: 2),
    // ),
    hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
    
  ),
);
