import 'package:flutter/material.dart';

/// Controls default size, color, and emotion-driven adjustments.
@immutable
class IconConfig {
  /// Icon color
  final Color color;

  /// Icon size
  final double size;

  const IconConfig({
    required this.color,
    required this.size,
  });

  /// Neutral icon style
  static IconConfig neutral(Color defaultColor) => IconConfig(
    color: defaultColor,
    size: 24.0,
  );

  /// Soft style for sadness
  static IconConfig soft(Color defaultColor) => IconConfig(
    color: defaultColor.withAlpha(204),
    size: 28.0,
  );

  /// Lively style for enjoyment / surprise
  static IconConfig lively(Color defaultColor) => IconConfig(
    color: defaultColor,
    size: 32.0,
  );
}
