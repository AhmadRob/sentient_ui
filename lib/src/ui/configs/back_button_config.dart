import 'package:flutter/material.dart';

/// Configuration for Sentient BackButton widget
@immutable
class BackButtonConfig {
  /// Icon color override (null = use emotion theme)
  final Color? color;

  /// Icon size
  final double size;

  /// Opacity modifier based on emotion
  final double opacity;

  /// Optional padding around the button
  final EdgeInsets padding;

  const BackButtonConfig({
    this.color,
    required this.size,
    required this.opacity,
    this.padding = const EdgeInsets.all(4),
  });

  /// Neutral → Default stable behavior
  static const BackButtonConfig neutral = BackButtonConfig(
    color: null,
    size: 24,
    opacity: 1.0,
    padding: EdgeInsets.all(4),
  );

  /// Soft → sadness, fear → reduce intensity, soften color
  static const BackButtonConfig soft = BackButtonConfig(
    color: null,
    size: 22,
    opacity: 0.85,
    padding: EdgeInsets.all(6),
  );

  /// Lively → enjoyment, surprise → expressive, slightly bigger
  static const BackButtonConfig lively = BackButtonConfig(
    color: null,
    size: 26,
    opacity: 1.0,
    padding: EdgeInsets.all(6),
  );
}