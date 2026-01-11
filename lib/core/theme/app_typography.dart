import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application typography configuration - Antique Theme
///
/// Uses Playfair Display for headlines and Merriweather for body text.
/// Classic serif fonts for an elegant, vintage aesthetic.
abstract class AppTypography {
  /// Font family for headlines and display text
  static String get headlineFont => GoogleFonts.playfairDisplay().fontFamily!;

  /// Font family for body text and UI elements
  static String get bodyFont => GoogleFonts.merriweather().fontFamily!;

  /// Build the complete TextTheme for the app
  static TextTheme buildTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.25,
        color: colorScheme.onSurface,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      headlineLarge: GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      headlineMedium: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      headlineSmall: GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      titleLarge: GoogleFonts.merriweather(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: colorScheme.onSurface,
      ),
      titleMedium: GoogleFonts.merriweather(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.15,
        color: colorScheme.onSurface,
      ),
      titleSmall: GoogleFonts.merriweather(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
      ),
      bodyLarge: GoogleFonts.merriweather(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
      bodyMedium: GoogleFonts.merriweather(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        color: colorScheme.onSurface,
      ),
      bodySmall: GoogleFonts.merriweather(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        color: colorScheme.onSurfaceVariant,
      ),
      labelLarge: GoogleFonts.merriweather(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.1,
        color: colorScheme.onSurface,
      ),
      labelMedium: GoogleFonts.merriweather(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: colorScheme.onSurface,
      ),
      labelSmall: GoogleFonts.merriweather(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: colorScheme.onSurfaceVariant,
      ),
    );
  }
}

/// Font size constants for custom text styles
abstract class AppFontSize {
  static const double xs = 11;
  static const double sm = 12;
  static const double md = 14;
  static const double lg = 16;
  static const double xl = 18;
  static const double xxl = 20;
  static const double xxxl = 24;
}

/// Font weight constants
abstract class AppFontWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}
