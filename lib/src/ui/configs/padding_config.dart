import 'package:flutter/material.dart';

/// Configuration for Sentient Padding widget.
@immutable
class PaddingConfig {
  /// Base padding values
  final EdgeInsets padding;

  const PaddingConfig({
    required this.padding,
  });

  /// Calm anchor
  static const PaddingConfig neutral = PaddingConfig(
    padding: EdgeInsets.all(12),
  );

  /// Fear / Sadness → more breathing room
  static const PaddingConfig soft = PaddingConfig(
    padding: EdgeInsets.all(16),
  );

  /// Enjoyment / Surprise → lively but safe spacing
  static const PaddingConfig lively = PaddingConfig(
    padding: EdgeInsets.all(14),
  );

  /// Safe merge
  PaddingConfig merge(PaddingConfig? other) {
    if (other == null) return this;
    return PaddingConfig(
      padding: other.padding,
    );
  }
}