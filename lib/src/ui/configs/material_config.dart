import 'package:flutter/material.dart';

/// Base configuration for emotion-aware Material widgets.
@immutable
class MaterialConfig {
  /// Corner radius of the material surface
  final double borderRadius;

  /// Elevation intensity (0 = flat)
  final double elevation;

  /// Background color override (null = use emotion theme surfaceColor)
  final Color? backgroundColor;

  /// Optional gradient background
  final LinearGradient? backgroundGradient;

  /// Optional border style
  final Border? border;

  /// Internal padding inside the Material wrapper
  final EdgeInsets padding;

  /// Alignment for the child
  final Alignment alignment;

  const MaterialConfig({
    required this.borderRadius,
    required this.elevation,
    this.backgroundColor,
    this.backgroundGradient,
    this.border,
    this.padding = const EdgeInsets.all(12),
    this.alignment = Alignment.center,
  });

  /// Neutral preset (baseline)
  static const MaterialConfig neutral = MaterialConfig(
    borderRadius: 8.0,
    elevation: 1.0,
    backgroundColor: null,
    backgroundGradient: null,
    border: null,
    padding: EdgeInsets.all(12),
    alignment: Alignment.center,
  );

  /// Soft preset (used for sadness/fear/etc.)
  static const MaterialConfig soft = MaterialConfig(
    borderRadius: 12.0,
    elevation: 0.5,
    backgroundColor: null,
    backgroundGradient: null,
    border: null,
    padding: EdgeInsets.all(16),
    alignment: Alignment.center,
  );

  /// Lively preset (used for enjoyment/surprise)
  static const MaterialConfig lively = MaterialConfig(
    borderRadius: 16.0,
    elevation: 3.0,
    backgroundColor: null,
    backgroundGradient: null,
    border: null,
    padding: EdgeInsets.all(20),
    alignment: Alignment.center,
  );
}