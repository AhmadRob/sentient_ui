import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive widget that rotates its child by a multiple of 90 degrees and
/// adapts the rotation based on the user's emotional state.
///
/// `SentientRotatedBox` functions as a drop-in replacement for Flutter's [RotatedBox]
/// but can dynamically change the `quarterTurns` property based on the active
/// [EmotionTheme] provided by the [AdaptationManager]. This allows for subtle or
/// expressive rotational effects that align with the emotional context.
///
/// ## Features
/// - Emotion-aware rotation (e.g., no rotation for anger, gentle rotation for sadness).
/// - Supports custom `quarterTurns` or `configOverride` to disable emotional adaptation.
///
/// ## Example Usage
/// ```dart
/// SentientRotatedBox(
///   child: SentientText('This text might rotate!'),
/// )
/// ```
class SentientRotatedBox extends StatelessWidget {
  /// The widget to be rotated.
  final Widget child;

  /// An optional override for the number of quarter turns to rotate the child.
  ///
  /// If provided, this value is used directly, and the emotion-aware
  /// adaptation decision is disabled.
  final int? quarterTurns;

  /// An optional configuration to override the emotion-based defaults.
  final RotatedBoxConfig? configOverride;

  /// Creates a new adaptive `SentientRotatedBox` widget.
  const SentientRotatedBox({
    super.key,
    required this.child,
    this.quarterTurns,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from an override or the current emotion.
    final RotatedBoxConfig config =
        configOverride ?? emotionTheme.rotatedBoxConfig;

    return RotatedBox(
      quarterTurns: quarterTurns ?? config.quarterTurns,
      child: child,
    );
  }
}
