import 'package:flutter/material.dart';

/// Base configuration for emotion-aware rotation.
@immutable
class RotateConfig {
  /// Base rotation angle applied to the widget.
  final double baseAngle;

  /// Multiplier applied based on emotional intensity.
  ///
  /// Example: baseAngle * angleFactor
  final double angleFactor;

  /// Alignment of the transform origin.
  final Alignment alignment;

  const RotateConfig({
    required this.baseAngle,
    required this.angleFactor,
    this.alignment = Alignment.center,
  });

  /// Neutral — no rotation (most stable)
  static const RotateConfig neutral = RotateConfig(
    baseAngle: 0.0,
    angleFactor: 1.0,
    alignment: Alignment.center,
  );

  /// Soft — sadness/fear → avoid movement → very small rotation allowed
  static const RotateConfig soft = RotateConfig(
    baseAngle: 0.0,
    angleFactor: 0.2, // very stable
    alignment: Alignment.center,
  );

  /// Lively — enjoyment/surprise → playful small rotation allowed
  static const RotateConfig lively = RotateConfig(
    baseAngle: 0.05, // ~3 degrees
    angleFactor: 1.0,
    alignment: Alignment.center,
  );
}