import 'package:flutter/material.dart';

/// Defines button styling for emotional states.
@immutable
class ButtonConfig {
  /// Border radius for buttons
  final double borderRadius;

  /// Elevation for buttons (0 = flat)
  final double elevation;

  /// Scale factor on hover (1.0 = no scale)
  final double hoverScale;

  /// Whether to use gradient backgrounds
  final bool useGradient;

  /// Padding inside buttons
  final EdgeInsets padding;

  const ButtonConfig({
    required this.borderRadius,
    required this.elevation,
    required this.hoverScale,
    this.useGradient = false,
    required this.padding,
  });

  static const ButtonConfig muted = ButtonConfig(
    borderRadius: 4.0,
    elevation: 0.0,
    hoverScale: 1.0,
    useGradient: false,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
  );

  static const ButtonConfig soft = ButtonConfig(
    borderRadius: 12.0,
    elevation: 2.0,
    hoverScale: 1.02,
    useGradient: false,
    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  );

  static const ButtonConfig lively = ButtonConfig(
    borderRadius: 16.0,
    elevation: 4.0,
    hoverScale: 1.05,
    useGradient: true,
    padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16),
  );
}
