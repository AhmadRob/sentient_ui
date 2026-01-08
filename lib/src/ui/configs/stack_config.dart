import 'package:flutter/material.dart';

/// Controls alignment, layout tightness, and how the Stack behaves
/// depending on the user's emotional state.
@immutable
class StackConfig {
  final StackFit fit;
  final Alignment alignment;

  const StackConfig({
    required this.fit,
    required this.alignment,
  });

  /// Balanced default state — used for neutral, fear, anger, contempt, disgust.
  static const StackConfig neutral = StackConfig(
    fit: StackFit.loose,
    alignment: Alignment.center,
  );

  /// Soft emotional layout — calm, sadness → slightly more “downward” flow.
  static const StackConfig soft = StackConfig(
    fit: StackFit.loose,
    alignment: Alignment.topCenter,
  );

  /// Energetic layout — enjoyment, surprise.
  static const StackConfig lively = StackConfig(
    fit: StackFit.expand,
    alignment: Alignment.center,
  );
}
