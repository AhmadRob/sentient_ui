import 'package:flutter/material.dart';

/// Defines Row styling for different emotional states.
@immutable
class RowConfig {
  /// Padding inside the row container
  final EdgeInsets padding;

  /// Background color of the row container
  final Color? backgroundColor;

  /// Corner radius of the container
  final double borderRadius;

  /// Shadow applied around the container
  final List<BoxShadow>? boxShadow;

  /// Alignment of child widgets inside the container
  final Alignment alignment;

  const RowConfig({
    required this.padding,
    this.backgroundColor,
    required this.borderRadius,
    this.boxShadow,
    this.alignment = Alignment.center,
  });

  /// Neutral configuration for calm / structured UI
  static const RowConfig neutral = RowConfig(
    padding: EdgeInsets.all(12),
    borderRadius: 8.0,
    backgroundColor: null,
    boxShadow: null,
    alignment: Alignment.center,
  );

  /// Soft configuration for gentle / soothing UI
  static const RowConfig soft = RowConfig(
    padding: EdgeInsets.all(16),
    borderRadius: 12.0,
    backgroundColor: null,
    boxShadow: null,
    alignment: Alignment.center,
  );

  /// Lively configuration for joyful / expressive UI
  static const RowConfig lively = RowConfig(
    padding: EdgeInsets.all(20),
    borderRadius: 16.0,
    backgroundColor: null,
    boxShadow: null,
    alignment: Alignment.center,
  );
}
