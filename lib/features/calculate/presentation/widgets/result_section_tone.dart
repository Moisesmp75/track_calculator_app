import 'package:flutter/material.dart';

enum ResultSectionTone {
  fleet,
  production,
  performance,
  cycle,
  cost,
  breakdown,
}

class ResultSectionColors {
  const ResultSectionColors({
    required this.header,
    required this.onHeader,
    required this.background,
    required this.border,
    required this.foreground,
    required this.muted,
  });

  final Color header;
  final Color onHeader;
  final Color background;
  final Color border;
  final Color foreground;
  final Color muted;
}

extension ResultSectionToneColors on ResultSectionTone {
  ResultSectionColors colorsOf(Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return switch (this) {
      ResultSectionTone.fleet =>
        isDark
            ? const ResultSectionColors(
                header: Color(0xFF2DD4BF),
                onHeader: Color(0xFF042F2C),
                background: Color(0xFF102824),
                border: Color(0xFF1F6B62),
                foreground: Color(0xFFE7FFFB),
                muted: Color(0xFF9ED9D0),
              )
            : const ResultSectionColors(
                header: Color(0xFF00685F),
                onHeader: Color(0xFFFFFFFF),
                background: Color(0xFFE5F6F3),
                border: Color(0xFF9EDDD4),
                foreground: Color(0xFF064E48),
                muted: Color(0xFF3F6F69),
              ),
      ResultSectionTone.production =>
        isDark
            ? const ResultSectionColors(
                header: Color(0xFFF5B942),
                onHeader: Color(0xFF3A2500),
                background: Color(0xFF2C220F),
                border: Color(0xFF8A6420),
                foreground: Color(0xFFFFF6E0),
                muted: Color(0xFFE4C98A),
              )
            : const ResultSectionColors(
                header: Color(0xFF9A6200),
                onHeader: Color(0xFFFFFFFF),
                background: Color(0xFFFFF4D4),
                border: Color(0xFFE8C56A),
                foreground: Color(0xFF7A4B00),
                muted: Color(0xFF8A6230),
              ),
      ResultSectionTone.performance =>
        isDark
            ? const ResultSectionColors(
                header: Color(0xFFFF8A80),
                onHeader: Color(0xFF3D1212),
                background: Color(0xFF2E1616),
                border: Color(0xFF8C4545),
                foreground: Color(0xFFFFF0EE),
                muted: Color(0xFFF0B8B4),
              )
            : const ResultSectionColors(
                header: Color(0xFFB42318),
                onHeader: Color(0xFFFFFFFF),
                background: Color(0xFFFDECEC),
                border: Color(0xFFF0B4B0),
                foreground: Color(0xFF8E2424),
                muted: Color(0xFF9A4A4A),
              ),
      ResultSectionTone.cycle =>
        isDark
            ? const ResultSectionColors(
                header: Color(0xFF6FDB8B),
                onHeader: Color(0xFF0C2814),
                background: Color(0xFF102418),
                border: Color(0xFF2F6B42),
                foreground: Color(0xFFEDFFF2),
                muted: Color(0xFFA8DDB6),
              )
            : const ResultSectionColors(
                header: Color(0xFF157A3A),
                onHeader: Color(0xFFFFFFFF),
                background: Color(0xFFE7F6EC),
                border: Color(0xFFAEDCC0),
                foreground: Color(0xFF145C32),
                muted: Color(0xFF3E6B50),
              ),
      ResultSectionTone.cost =>
        isDark
            ? const ResultSectionColors(
                header: Color(0xFF8EBEFF),
                onHeader: Color(0xFF0C1C33),
                background: Color(0xFF121E30),
                border: Color(0xFF3A6294),
                foreground: Color(0xFFEEF5FF),
                muted: Color(0xFFB7D0F0),
              )
            : const ResultSectionColors(
                header: Color(0xFF1D4F91),
                onHeader: Color(0xFFFFFFFF),
                background: Color(0xFFE8F1FC),
                border: Color(0xFFBFD3F0),
                foreground: Color(0xFF1E4E86),
                muted: Color(0xFF4A6490),
              ),
      ResultSectionTone.breakdown =>
        isDark
            ? const ResultSectionColors(
                header: Color(0xFFC4B5FD),
                onHeader: Color(0xFF1E1533),
                background: Color(0xFF1C1730),
                border: Color(0xFF5B4B86),
                foreground: Color(0xFFF4F0FF),
                muted: Color(0xFFD0C6EE),
              )
            : const ResultSectionColors(
                header: Color(0xFF5B3A9E),
                onHeader: Color(0xFFFFFFFF),
                background: Color(0xFFF3EFFB),
                border: Color(0xFFD4C8F0),
                foreground: Color(0xFF4C3489),
                muted: Color(0xFF6B5A96),
              ),
    };
  }
}
