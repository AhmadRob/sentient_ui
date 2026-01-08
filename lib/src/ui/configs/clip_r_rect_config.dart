import 'package:flutter/material.dart';

/// Controls the border radius applied to the child widget.
@immutable
class ClipRRectConfig {
  /// Border radius of the child widget.
  final double borderRadius;

  const ClipRRectConfig({
    required this.borderRadius,
  });

  /// Default neutral radius (stable)
  static const ClipRRectConfig neutral = ClipRRectConfig(
    borderRadius: 8.0,
  );

  /// Soft radius — gentle rounded edges
  static const ClipRRectConfig soft = ClipRRectConfig(
    borderRadius: 12.0,
  );

  /// Lively radius — expressive rounded edges
  static const ClipRRectConfig lively = ClipRRectConfig(
    borderRadius: 16.0,
  );
}
