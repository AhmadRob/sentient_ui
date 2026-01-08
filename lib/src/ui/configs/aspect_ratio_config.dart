import 'package:flutter/material.dart';

/// Configuration for [SentientAspectRatio] behavior.
@immutable
class AspectRatioConfig {
  /// The aspect ratio to use (width / height).
  final double ratio;

  const AspectRatioConfig({
    required this.ratio,
  });

  /// Stable square ratio for anger/fear.
  static const AspectRatioConfig square = AspectRatioConfig(
    ratio: 1.0,
  );

  /// Standard ratio for neutral/contempt/sadness.
  static const AspectRatioConfig standard = AspectRatioConfig(
    ratio: 4.0 / 3.0,
  );

  /// Golden ratio for disgust.
  static const AspectRatioConfig golden = AspectRatioConfig(
    ratio: 1.618,
  );

  /// Widescreen for enjoyment.
  static const AspectRatioConfig widescreen = AspectRatioConfig(
    ratio: 16.0 / 9.0,
  );

  /// Dynamic ratio for surprise.
  static const AspectRatioConfig dynamic = AspectRatioConfig(
    ratio: 2.0,
  );
}
