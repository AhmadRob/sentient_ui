import 'package:flutter/material.dart';

/// Base configuration for emotion-aware Wrap layout.
@immutable
class WrapConfig {
  /// Spacing between items horizontally
  final double spacing;

  /// Spacing between rows
  final double runSpacing;

  /// Alignment of items inside each wrap line
  final WrapAlignment alignment;

  /// Alignment of lines within the wrap
  final WrapAlignment runAlignment;

  /// Direction of wrapping: horizontal or vertical
  final Axis direction;

  /// Clip behavior for overflow control
  final Clip clipBehavior;

  const WrapConfig({
    required this.spacing,
    required this.runSpacing,
    required this.alignment,
    required this.runAlignment,
    required this.direction,
    this.clipBehavior = Clip.none,
  });

  /// Neutral (baseline)
  static const WrapConfig neutral = WrapConfig(
    spacing: 8.0,
    runSpacing: 8.0,
    alignment: WrapAlignment.start,
    runAlignment: WrapAlignment.start,
    direction: Axis.horizontal,
    clipBehavior: Clip.none,
  );

  /// Soft—for fear, sadness, contempt (more breathing room)
  static const WrapConfig soft = WrapConfig(
    spacing: 10.0,
    runSpacing: 12.0,
    alignment: WrapAlignment.start,
    runAlignment: WrapAlignment.start,
    direction: Axis.horizontal,
    clipBehavior: Clip.none,
  );

  /// Lively—for enjoyment, surprise (more dynamic spacing)
  static const WrapConfig lively = WrapConfig(
    spacing: 12.0,
    runSpacing: 14.0,
    alignment: WrapAlignment.center,
    runAlignment: WrapAlignment.center,
    direction: Axis.horizontal,
    clipBehavior: Clip.none,
  );
}