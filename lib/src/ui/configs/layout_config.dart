import 'package:flutter/material.dart';

/// Defines layout characteristics for emotional states.
@immutable
class LayoutConfig {
  /// Base spacing unit multiplier (1.0 = 8.0 dp)
  final double spacingMultiplier;

  /// Border radius for cards and containers
  final double cardBorderRadius;

  /// Shadow intensity (0.0 - 1.0)
  final double shadowIntensity;

  /// Whether to use asymmetric/dynamic layouts
  final bool allowAsymmetry;

  /// Grid alignment strictness
  final bool enforceStrictGrid;

  const LayoutConfig({
    required this.spacingMultiplier,
    required this.cardBorderRadius,
    required this.shadowIntensity,
    this.allowAsymmetry = false,
    this.enforceStrictGrid = true,
  });

  static const LayoutConfig structured = LayoutConfig(
    spacingMultiplier: 1.0,
    cardBorderRadius: 8.0,
    shadowIntensity: 0.1,
    allowAsymmetry: false,
    enforceStrictGrid: true,
  );

  static const LayoutConfig airy = LayoutConfig(
    spacingMultiplier: 1.3,
    cardBorderRadius: 16.0,
    shadowIntensity: 0.15,
    allowAsymmetry: false,
    enforceStrictGrid: false,
  );

  static const LayoutConfig dynamic = LayoutConfig(
    spacingMultiplier: 1.2,
    cardBorderRadius: 20.0,
    shadowIntensity: 0.2,
    allowAsymmetry: true,
    enforceStrictGrid: false,
  );
}
