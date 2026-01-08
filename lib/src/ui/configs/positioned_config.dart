import 'package:flutter/material.dart';

/// Configuration for [SentientPositioned] layout.
@immutable
class PositionedConfig {
  /// Multiplier for top offset.
  final double? topMultiplier;

  /// Multiplier for bottom offset.
  final double? bottomMultiplier;

  /// Multiplier for left offset.
  final double? leftMultiplier;

  /// Multiplier for right offset.
  final double? rightMultiplier;

  const PositionedConfig({
    this.topMultiplier,
    this.bottomMultiplier,
    this.leftMultiplier,
    this.rightMultiplier,
  });

  /// Stable/Anchored (Top-Left) for Anger/Fear.
  static const PositionedConfig anchored = PositionedConfig(
    topMultiplier: 0.5,
    leftMultiplier: 0.5,
  );

  /// Distant (Top-Right) for Contempt/Disgust.
  static const PositionedConfig distant = PositionedConfig(
    topMultiplier: 1.0,
    rightMultiplier: 1.0,
  );

  /// Grounded (Bottom-Left) for Sadness.
  static const PositionedConfig grounded = PositionedConfig(
    bottomMultiplier: 1.0,
    leftMultiplier: 1.0,
  );

  /// Standard (Top-Left) for Neutral.
  static const PositionedConfig standard = PositionedConfig(
    topMultiplier: 1.0,
    leftMultiplier: 1.0,
  );

  /// Dynamic (Top-Right 0) for Enjoyment/Surprise (Asymmetric).
  static const PositionedConfig dynamicAsymmetric = PositionedConfig(
    topMultiplier: 0.0,
    rightMultiplier: 0.0,
  );
  
  /// Dynamic (Top-Left Standard) for Enjoyment/Surprise (Symmetric fallback).
  static const PositionedConfig dynamicSymmetric = PositionedConfig(
    topMultiplier: 1.0,
    leftMultiplier: 1.0,
  );
}
