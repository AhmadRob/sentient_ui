import 'package:flutter/material.dart';

/// Controls the rotation amount expressed in quarter turns.
@immutable
class RotatedBoxConfig {
  final int quarterTurns;

  const RotatedBoxConfig({
    required this.quarterTurns,
  });

  /// Default stable rotation — used for neutral, fear, anger, contempt, disgust.
  static const RotatedBoxConfig neutral = RotatedBoxConfig(
    quarterTurns: 0,
  );

  /// Soft emotional state — very light rotation for subtle flow.
  static const RotatedBoxConfig soft = RotatedBoxConfig(
    quarterTurns: 1, // 90° gentle rotation
  );

  /// Energetic states — more expressive motion.
  static const RotatedBoxConfig lively = RotatedBoxConfig(
    quarterTurns: 2, // 180° rotation
  );
}
