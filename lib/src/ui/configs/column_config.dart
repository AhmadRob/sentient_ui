import 'package:flutter/material.dart';

///Defines Column styling for emotional states.
@immutable
class ColumnConfig {
  final EdgeInsets padding;
  final Color? backgroundColor;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;
  final Alignment alignment;

  const ColumnConfig({
    required this.padding,
    this.backgroundColor,
    required this.borderRadius,
    this.boxShadow,
    this.alignment = Alignment.topLeft,
  });

  /// Neutral default
  static const ColumnConfig neutral = ColumnConfig(
    padding: EdgeInsets.all(8),
    borderRadius: 8.0,
  );

  /// Soft default
  static const ColumnConfig soft = ColumnConfig(
    padding: EdgeInsets.all(12),
    borderRadius: 12.0,
  );

  /// Lively default
  static const ColumnConfig lively = ColumnConfig(
    padding: EdgeInsets.all(16),
    borderRadius: 16.0,
  );
}
