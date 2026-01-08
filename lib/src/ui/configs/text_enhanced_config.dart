import 'package:flutter/material.dart';

/// Configuration for [SentientTextEnhanced] styling.
@immutable
class TextEnhancedConfig {
  /// Multiplier for font size.
  final double fontSizeMultiplier;

  /// Value added to letter spacing.
  final double letterSpacingAdder;

  /// Line height.
  final double height;

  /// Word spacing.
  final double wordSpacing;

  /// Font weight.
  final FontWeight fontWeight;

  /// Optional text shadows.
  final List<Shadow>? shadows;

  /// Font style (normal/italic).
  final FontStyle fontStyle;

  const TextEnhancedConfig({
    required this.fontSizeMultiplier,
    required this.letterSpacingAdder,
    required this.height,
    required this.wordSpacing,
    required this.fontWeight,
    this.shadows,
    this.fontStyle = FontStyle.normal,
  });

  /// Calming/Spacious for Anger.
  static const TextEnhancedConfig calming = TextEnhancedConfig(
    fontSizeMultiplier: 1.0,
    letterSpacingAdder: 0.8,
    height: 1.6,
    wordSpacing: 2.0,
    fontWeight: FontWeight.w500,
  );

  /// Professional/Precise for Contempt.
  static const TextEnhancedConfig precise = TextEnhancedConfig(
    fontSizeMultiplier: 1.0,
    letterSpacingAdder: 0.3,
    height: 1.5,
    wordSpacing: 1.5,
    fontWeight: FontWeight.w400,
  );

  /// Clean/Open for Disgust.
  static const TextEnhancedConfig clean = TextEnhancedConfig(
    fontSizeMultiplier: 1.05,
    letterSpacingAdder: 0.5,
    height: 1.7,
    wordSpacing: 1.8,
    fontWeight: FontWeight.w400,
  );

  /// Expressive/Dynamic for Enjoyment.
  static TextEnhancedConfig expressive(Color primary) => TextEnhancedConfig(
    fontSizeMultiplier: 1.1,
    letterSpacingAdder: 0.4,
    height: 1.5,
    wordSpacing: 1.5,
    fontWeight: FontWeight.w600,
    shadows: [Shadow(color: primary.withOpacity(0.2), blurRadius: 2.0, offset: const Offset(0, 1))],
  );

  /// Spacious/Stable for Fear.
  static const TextEnhancedConfig spacious = TextEnhancedConfig(
    fontSizeMultiplier: 1.05,
    letterSpacingAdder: 0.6,
    height: 1.8,
    wordSpacing: 2.2,
    fontWeight: FontWeight.w400,
  );

  /// Gentle/Soft for Sadness.
  static const TextEnhancedConfig gentle = TextEnhancedConfig(
    fontSizeMultiplier: 1.0,
    letterSpacingAdder: 0.3,
    height: 1.6,
    wordSpacing: 1.6,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.italic,
  );

  /// Bold/Attention for Surprise.
  static const TextEnhancedConfig bold = TextEnhancedConfig(
    fontSizeMultiplier: 1.15,
    letterSpacingAdder: 0.2,
    height: 1.4,
    wordSpacing: 1.2,
    fontWeight: FontWeight.w700,
  );

  /// Standard for Neutral.
  static const TextEnhancedConfig standard = TextEnhancedConfig(
    fontSizeMultiplier: 1.0,
    letterSpacingAdder: 0.2,
    height: 1.5,
    wordSpacing: 1.5,
    fontWeight: FontWeight.w500,
  );
}
