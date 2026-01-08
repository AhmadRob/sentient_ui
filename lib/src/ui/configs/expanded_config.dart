import 'package:flutter/material.dart';

/// Defines container styling for [SentientExpanded] per emotional state.
@immutable
class ExpandedConfig {
  /// Internal padding for the container.
  final EdgeInsets padding;

  /// Alignment of the child inside the container.
  final Alignment alignment;

  /// Optional background color.
  final Color? backgroundColor;

  /// Corner radius of the container.
  final double borderRadius;

  /// Optional box shadow.
  final List<BoxShadow>? boxShadow;

  const ExpandedConfig({
    required this.padding,
    this.alignment = Alignment.center,
    this.backgroundColor,
    required this.borderRadius,
    this.boxShadow,
  });

  /// Neutral style (for anger, fear)
  static const ExpandedConfig neutral = ExpandedConfig(
    padding: EdgeInsets.all(12),
    borderRadius: 8.0,
    backgroundColor: null,
    boxShadow: null,
    alignment: Alignment.center,
  );

  /// Soft style (for sadness)
  static const ExpandedConfig soft = ExpandedConfig(
    padding: EdgeInsets.all(16),
    borderRadius: 12.0,
    backgroundColor: null,
    boxShadow: null,
    alignment: Alignment.center,
  );

  /// Lively style (for enjoyment, surprise)
  static const ExpandedConfig lively = ExpandedConfig(
    padding: EdgeInsets.all(20),
    borderRadius: 16.0,
    backgroundColor: null,
    boxShadow: null,
    alignment: Alignment.center,
  );
}
