import 'package:flutter/material.dart';

/// Base configuration for emotion-aware InkWell interaction.
@immutable
class InkWellConfig {
  /// Ripple (splash) opacity or intensity
  final double splashIntensity;

  /// Optional custom splash color
  final Color? splashColor;

  /// Optional highlight color
  final Color? highlightColor;

  /// Corner radius for interaction area
  final double borderRadius;

  /// Tap target padding
  final EdgeInsets padding;

  const InkWellConfig({
    required this.splashIntensity,
    required this.borderRadius,
    required this.padding,
    this.splashColor,
    this.highlightColor,
  });

  /// Neutral baseline — subtle interaction
  static const InkWellConfig neutral = InkWellConfig(
    splashIntensity: 0.2,
    borderRadius: 8.0,
    padding: EdgeInsets.all(4),
    splashColor: null,
    highlightColor: null,
  );

  /// Soft — used for sadness / fear / contempt
  static const InkWellConfig soft = InkWellConfig(
    splashIntensity: 0.1,
    borderRadius: 12.0,
    padding: EdgeInsets.all(6),
    splashColor: null,
    highlightColor: null,
  );

  /// Lively — used for enjoyment / surprise
  static const InkWellConfig lively = InkWellConfig(
    splashIntensity: 0.35,
    borderRadius: 14.0,
    padding: EdgeInsets.all(8),
    splashColor: null,
    highlightColor: null,
  );
}