import 'package:flutter/material.dart';

/// Configuration for [SentientTextButton] appearance.
@immutable
class TextButtonConfig {
  /// The background color.
  final Color backgroundColor;

  /// The foreground (text/icon) color.
  final Color foregroundColor;

  /// The overlay color (splash/highlight).
  final Color overlayColor;

  /// The border radius.
  final double borderRadius;

  /// The padding.
  final EdgeInsetsGeometry padding;

  /// The font weight for the text.
  final FontWeight fontWeight;

  /// The letter spacing for the text.
  final double? letterSpacing;

  const TextButtonConfig({
    required this.backgroundColor,
    required this.foregroundColor,
    required this.overlayColor,
    required this.borderRadius,
    required this.padding,
    required this.fontWeight,
    this.letterSpacing,
  });

  /// Minimal styling for anger.
  static TextButtonConfig minimal(Color primary) => TextButtonConfig(
    backgroundColor: primary.withAlpha(26),
    foregroundColor: primary,
    overlayColor: primary.withAlpha(26),
    borderRadius: 8.0,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  /// Professional styling for contempt/neutral.
  static TextButtonConfig standard(Color primary) => TextButtonConfig(
    backgroundColor: primary.withAlpha(13),
    foregroundColor: primary,
    overlayColor: primary.withAlpha(26),
    borderRadius: 8.0,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    fontWeight: FontWeight.w400,
  );

  /// Clean styling for disgust.
  static TextButtonConfig clean(Color primary) => TextButtonConfig(
    backgroundColor: Colors.transparent,
    foregroundColor: primary,
    overlayColor: primary.withAlpha(38),
    borderRadius: 12.0,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    fontWeight: FontWeight.w400,
  );

  /// Expressive styling for enjoyment.
  static TextButtonConfig expressive(Color primary) => TextButtonConfig(
    backgroundColor: primary.withAlpha(51),
    foregroundColor: primary,
    overlayColor: primary.withAlpha(77),
    borderRadius: 16.0,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    fontWeight: FontWeight.w600,
  );

  /// Stable styling for fear.
  static TextButtonConfig stable(Color primary) => TextButtonConfig(
    backgroundColor: Colors.transparent,
    foregroundColor: primary,
    overlayColor: primary.withAlpha(20),
    borderRadius: 8.0,
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    fontWeight: FontWeight.w400,
    letterSpacing: 0.3,
  );

  /// Gentle styling for sadness.
  static TextButtonConfig gentle(Color primary) => TextButtonConfig(
    backgroundColor: primary.withAlpha(26),
    foregroundColor: primary,
    overlayColor: primary.withAlpha(31),
    borderRadius: 14.0,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    fontWeight: FontWeight.w400,
  );

  /// Dynamic styling for surprise.
  static TextButtonConfig dynamic(Color secondary) => TextButtonConfig(
    backgroundColor: secondary.withAlpha(64),
    foregroundColor: secondary,
    overlayColor: secondary.withAlpha(102),
    borderRadius: 18.0,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    fontWeight: FontWeight.w700,
  );
}
