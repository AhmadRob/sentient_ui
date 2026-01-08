import 'package:flutter/material.dart';

/// Controls optional styling such as border radius,
/// color filters, or other emotion-driven adjustments.
@immutable
class ImageConfig {
  /// Optional border radius for the image.
  final double borderRadius;

  /// Optional color filter applied to the image.
  final Color? colorFilter;

  const ImageConfig({
    required this.borderRadius,
    this.colorFilter,
  });

  /// Neutral: default stable image presentation
  static const ImageConfig neutral = ImageConfig(
    borderRadius: 0.0,
    colorFilter: null,
  );

  /// Soft: slightly softened presentation
  static const ImageConfig soft = ImageConfig(
    borderRadius: 8.0,
    colorFilter: null,
  );

  /// Lively: expressive rounded corners, brightened
  static const ImageConfig lively = ImageConfig(
    borderRadius: 16.0,
    colorFilter: null,
  );
}
