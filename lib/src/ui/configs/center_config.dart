
import 'package:flutter/material.dart';

/// Configuration for Sentient Center widget.
@immutable
class CenterConfig {
  /// Alignment used by the Center widget.
  final Alignment alignment;

  const CenterConfig({
    required this.alignment,
  });

  /// Neutral → default behavior
  static const CenterConfig neutral = CenterConfig(
    alignment: Alignment.center,
  );

  /// Soft → fear/sadness → stable centered
  static const CenterConfig soft = CenterConfig(
    alignment: Alignment.center,
  );

  /// Lively → enjoyment/surprise → slight playful alignment
  static const CenterConfig lively = CenterConfig(
    alignment: Alignment.center, // keep safe — no extreme movement
  );
}