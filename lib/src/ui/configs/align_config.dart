import 'package:flutter/material.dart';

/// Controls alignment for different emotional states.
@immutable
class AlignConfig {
  /// The alignment of the child
  final Alignment alignment;

  const AlignConfig({required this.alignment});

  /// Neutral emotion: center alignment
  static const AlignConfig neutral = AlignConfig(alignment: Alignment.center);

  /// Soft emotion (e.g., sadness): top-center alignment for gentle layout
  static const AlignConfig soft = AlignConfig(alignment: Alignment.topCenter);

  /// Lively emotion (e.g., enjoyment, surprise): bottom-center alignment for playful layout
  static const AlignConfig lively = AlignConfig(alignment: Alignment.bottomCenter);
}
