// lib/app/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GameColors extends ThemeExtension<GameColors> {
  const GameColors({
    required this.cellBorder,
    required this.cellHighlight,
    required this.cellSelected,
    required this.givenNumberColor,
    required this.inputNumberColor,
    required this.errorNumberColor,
    required this.boardBackground,
  });

  final Color cellBorder;
  final Color cellHighlight;
  final Color cellSelected;
  final Color givenNumberColor;
  final Color inputNumberColor;
  final Color errorNumberColor;
  final Color boardBackground;

  @override
  ThemeExtension<GameColors> copyWith({
    Color? cellBorder,
    Color? cellHighlight,
    Color? cellSelected,
    Color? givenNumberColor,
    Color? inputNumberColor,
    Color? errorNumberColor,
    Color? boardBackground,
  }) {
    return GameColors(
      cellBorder: cellBorder ?? this.cellBorder,
      cellHighlight: cellHighlight ?? this.cellHighlight,
      cellSelected: cellSelected ?? this.cellSelected,
      givenNumberColor: givenNumberColor ?? this.givenNumberColor,
      inputNumberColor: inputNumberColor ?? this.inputNumberColor,
      errorNumberColor: errorNumberColor ?? this.errorNumberColor,
      boardBackground: boardBackground ?? this.boardBackground,
    );
  }

  @override
  ThemeExtension<GameColors> lerp(
      covariant ThemeExtension<GameColors>? other, double t) {
    if (other is! GameColors) return this;
    return GameColors(
      cellBorder: Color.lerp(cellBorder, other.cellBorder, t)!,
      cellHighlight: Color.lerp(cellHighlight, other.cellHighlight, t)!,
      cellSelected: Color.lerp(cellSelected, other.cellSelected, t)!,
      givenNumberColor:
          Color.lerp(givenNumberColor, other.givenNumberColor, t)!,
      inputNumberColor:
          Color.lerp(inputNumberColor, other.inputNumberColor, t)!,
      errorNumberColor:
          Color.lerp(errorNumberColor, other.errorNumberColor, t)!,
      boardBackground: Color.lerp(boardBackground, other.boardBackground, t)!,
    );
  }
}

class AppTheme {
  AppTheme._();

  static const Color accent = Color(0xFF6C63FF);
  static const Color error = Color(0xFFDC2626);
  static const Color success = Color(0xFF16A34A);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0D1117),
      colorScheme: const ColorScheme.dark(
        primary: accent,
        secondary: accent,
        surface: Color(0xFF161B22),
        error: error,
      ),
      textTheme: GoogleFonts.nunitoTextTheme(ThemeData.dark().textTheme),
      cardTheme: CardThemeData(
        color: const Color(0xFF21262D),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      extensions: const [
        GameColors(
          cellBorder: Color(0xFF30363D),
          cellHighlight: Color(0x1F6C63FF), // accent 12%
          cellSelected: Color(0x336C63FF), // accent 20%
          givenNumberColor: Colors.white,
          inputNumberColor: accent,
          errorNumberColor: error,
          boardBackground: Color(0xFF0D1117),
        ),
      ],
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF9FAFB),
      colorScheme: const ColorScheme.light(
        primary: accent,
        secondary: accent,
        surface: Colors.white,
        error: error,
      ),
      textTheme: GoogleFonts.nunitoTextTheme(ThemeData.light().textTheme),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.05),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: accent,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
      ),
      extensions: const [
        GameColors(
          cellBorder: Color(0xFFE5E7EB),
          cellHighlight: Color(0x1F6C63FF), // accent 12%
          cellSelected: Color(0x336C63FF), // accent 20%
          givenNumberColor: Color(0xFF111827),
          inputNumberColor: accent,
          errorNumberColor: error,
          boardBackground: Colors.white,
        ),
      ],
    );
  }
}
