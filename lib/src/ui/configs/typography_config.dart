import 'package:flutter/material.dart';

/// Defines typography configuration for emotional states.
@immutable
class TypographyConfig {
  /// The font family to use (e.g., 'Inter', 'Nunito', 'Poppins')
  final String fontFamily;

  /// Base font size for body text
  final double baseFontSize;

  /// Letter spacing multiplier (1.0 = normal)
  final double letterSpacingMultiplier;

  /// Line height multiplier for readability
  final double lineHeightMultiplier;

  /// Font weight for body text
  final FontWeight bodyWeight;

  /// Font weight for headings
  final FontWeight headingWeight;

  /// Whether to use italic for emotional softness
  final bool useItalicAccents;

  const TypographyConfig({
    required this.fontFamily,
    required this.baseFontSize,
    required this.letterSpacingMultiplier,
    required this.lineHeightMultiplier,
    required this.bodyWeight,
    required this.headingWeight,
    this.useItalicAccents = false,
  });

  static const TypographyConfig stable = TypographyConfig(
    fontFamily: 'Inter',
    baseFontSize: 16.0,
    letterSpacingMultiplier: 1.1,
    lineHeightMultiplier: 1.5,
    bodyWeight: FontWeight.w400,
    headingWeight: FontWeight.w600,
  );

  static const TypographyConfig friendly = TypographyConfig(
    fontFamily: 'Nunito',
    baseFontSize: 17.0,
    letterSpacingMultiplier: 1.15,
    lineHeightMultiplier: 1.6,
    bodyWeight: FontWeight.w400,
    headingWeight: FontWeight.w700,
  );

  static const TypographyConfig expressive = TypographyConfig(
    fontFamily: 'Poppins',
    baseFontSize: 18.0,
    letterSpacingMultiplier: 1.2,
    lineHeightMultiplier: 1.5,
    bodyWeight: FontWeight.w400,
    headingWeight: FontWeight.w800,
  );
}
