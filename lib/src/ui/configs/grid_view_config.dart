import 'package:flutter/material.dart';

/// This config holds layout, spacing, behavior and scroll
/// styling that changes depending on the user's emotional state.
@immutable
class GridViewConfig {
  final EdgeInsets padding;
  final Axis scrollDirection;
  final int crossAxisCount;
  final double childAspectRatio;
  final ScrollPhysics physics;

  const GridViewConfig({
    required this.padding,
    required this.scrollDirection,
    required this.crossAxisCount,
    required this.childAspectRatio,
    required this.physics,
  });

  /// Neutral style — used for anger, fear, or stable states.
  /// Tighter spacing, calm scrolling, predictable layout.
  static const GridViewConfig neutral = GridViewConfig(
    padding: EdgeInsets.all(8),
    scrollDirection: Axis.vertical,
    crossAxisCount: 2,
    childAspectRatio: 1,
    physics: ClampingScrollPhysics(),
  );

  /// Soft style — used for sadness.
  /// More whitespace, gentle scrolling, less visual pressure.
  static const GridViewConfig soft = GridViewConfig(
    padding: EdgeInsets.all(16),
    scrollDirection: Axis.vertical,
    crossAxisCount: 2,
    childAspectRatio: 0.9,
    physics: BouncingScrollPhysics(),
  );

  /// Lively style — used for enjoyment or surprise.
  /// Airy layout, slightly exaggerated spacing, more playful physics.
  static const GridViewConfig lively = GridViewConfig(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    scrollDirection: Axis.vertical,
    crossAxisCount: 2,
    childAspectRatio: 0.85,
    physics: AlwaysScrollableScrollPhysics(),
  );
}
