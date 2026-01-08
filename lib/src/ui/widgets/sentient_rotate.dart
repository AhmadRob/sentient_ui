import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../configs/rotate_config.dart';

/// An emotion-aware rotation wrapper that adapts motion
/// behavior based on the current [EmotionTheme].
///
/// This widget applies subtle or expressive rotation effects
/// depending on the detected emotional state, ensuring that
/// motion remains comfortable and contextually appropriate.
///
/// It is designed to avoid overstimulation in negative
/// emotions (e.g., fear or sadness) while allowing playful
/// motion during positive emotional states.
///
/// Common use cases include animated icons, loading indicators,
/// and interactive elements that benefit from dynamic motion
/// within the Sentient UI system.
///
/// ## Features
/// - Emotion-aware motion (stable for negative, expressive for positive).
/// - Dynamic angle adjustment based on emotional state.
/// - Configurable overrides via [RotateConfig].
/// - Seamless integration with [EmotionTheme].
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientRotate(
///   angle: 0.1,
///   child: Icon(Icons.star),
/// )
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientRotate(
///   angle: 0.1,
///   config: RotateConfig(
///     angleFactor: 1.5,
///   ),
///   child: Icon(Icons.star),
/// )
/// ```
class SentientRotate extends StatelessWidget {
  /// The base rotation angle provided by the user (in radians).
  final double angle;

  /// The widget to be rotated.
  final Widget child;

  /// Optional configuration override.
  ///
  /// When provided, non-null properties override the
  /// emotion-resolved rotation behavior.
  final RotateConfig? config;

  /// Creates a [SentientRotate].
  ///
  /// The [angle] is combined with an emotion-dependent
  /// base angle and scaling factor.
  const SentientRotate({
    super.key,
    required this.angle,
    required this.child,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    // Observe emotion-driven motion adaptations
    final adaptationManager = context.watch<AdaptationManager>();

    // Active emotion-aware theme
    final theme = adaptationManager.currentTheme;

    // Resolve final rotation configuration
    final resolved = config ?? theme.rotateConfig;

    // Compute effective rotation angle
    final effectiveAngle =
        (angle + resolved.baseAngle) * resolved.angleFactor;

    return Transform.rotate(
      angle: effectiveAngle,
      alignment: resolved.alignment,
      child: child,
    );
  }
}
