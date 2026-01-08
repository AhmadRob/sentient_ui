import 'package:flutter/material.dart';

///Defines Container styling for emotional states.
@immutable
class ContainerConfig {
  /// Border radius for the container
  final double borderRadius;

  /// Optional border for the container
  final Border? border;

  /// Shadow intensity (0 = no shadow)
  final double shadowIntensity;

  /// Padding inside the container
  final EdgeInsets padding;

  /// Alignment of child inside the container
  final Alignment alignment;

  /// Optional background color override (null = use theme surfaceColor)
  final Color? backgroundColor;

  /// Optional background gradient
  final LinearGradient? backgroundGradient;

  const ContainerConfig({
    required this.borderRadius,
    this.border,
    required this.shadowIntensity,
    required this.padding,
    this.alignment = Alignment.center,
    this.backgroundColor,
    this.backgroundGradient,
  });

  /// Neutral container style
  static const ContainerConfig neutral = ContainerConfig(
    borderRadius: 8.0,
    shadowIntensity: 0.1,
    padding: EdgeInsets.all(12),
    alignment: Alignment.center,
    backgroundColor: null,
    border: null,
    backgroundGradient: null,
  );

  /// Soft container style
  static const ContainerConfig soft = ContainerConfig(
    borderRadius: 12.0,
    shadowIntensity: 0.15,
    padding: EdgeInsets.all(16),
    alignment: Alignment.center,
    backgroundColor: null,
    border: null,
    backgroundGradient: null,
  );

  /// Lively container style
  static const ContainerConfig lively = ContainerConfig(
    borderRadius: 16.0,
    shadowIntensity: 0.2,
    padding: EdgeInsets.all(20),
    alignment: Alignment.center,
    backgroundColor: null,
    border: null,
    backgroundGradient: null,
  );
}
