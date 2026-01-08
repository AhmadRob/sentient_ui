import 'package:flutter/material.dart';

/// Configuration for Sentient AppBar widget.
@immutable
class AppBarConfig {
  /// Background color override (null = from EmotionTheme)
  final Color? backgroundColor;

  /// Elevation expressed as safe shadow intensity (0–1)
  final double shadowIntensity;

  /// Title alignment
  final bool centerTitle;

  /// Optional bottom border
  final Border? border;

  /// Height of the AppBar
  final double height;

  const AppBarConfig({
    this.backgroundColor,
    required this.shadowIntensity,
    required this.centerTitle,
    this.border,
    this.height = kToolbarHeight,
  });

  /// Calm anchor
  static const AppBarConfig neutral = AppBarConfig(
    shadowIntensity: 0.08,
    centerTitle: true,
  );

  /// Fear / Sadness → flatter, grounded
  static const AppBarConfig soft = AppBarConfig(
    shadowIntensity: 0.04,
    centerTitle: true,
  );

  /// Enjoyment / Surprise → slightly elevated
  static const AppBarConfig lively = AppBarConfig(
    shadowIntensity: 0.12,
    centerTitle: true,
  );

  /// Safe merge
  AppBarConfig merge(AppBarConfig? other) {
    if (other == null) return this;
    return AppBarConfig(
      backgroundColor: other.backgroundColor ?? backgroundColor,
      shadowIntensity: other.shadowIntensity,
      centerTitle: other.centerTitle,
      border: other.border ?? border,
      height: other.height,
    );
  }
}