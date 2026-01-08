import 'package:flutter/material.dart';

/// Controls default flex value for emotion-aware layouts.
@immutable
class SpacerConfig {
  /// The flex factor of the spacer
  final int flex;

  const SpacerConfig({required this.flex});

  /// Neutral style (default spacing)
  static const SpacerConfig neutral = SpacerConfig(flex: 1);

  /// Soft style (more breathing space for sadness)
  static const SpacerConfig soft = SpacerConfig(flex: 2);

  /// Lively style (slightly compact for enjoyment/surprise)
  static const SpacerConfig lively = SpacerConfig(flex: 1);
}
