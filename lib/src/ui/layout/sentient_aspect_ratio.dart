import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive widget that adapts its child's aspect ratio based on the
/// user's emotional state.
///
/// `SentientAspectRatio` functions as a drop-in replacement for Flutter's
/// [AspectRatio] but animates its proportions based on the active [EmotionTheme]
/// provided by the [AdaptationManager]. This allows the UI layout to feel more
/// stable, spacious, or dynamic depending on the emotional context.
///
/// ## Features
/// - Emotion-aware aspect ratio adjustments (e.g., 1:1 for anger, 16:9 for enjoyment).
/// - Smoothly animates transitions between different aspect ratios.
/// - Supports a custom `aspectRatio` override to disable emotional adaptation.
/// - Follows Sentient Adaptation Guidelines.
///
/// ## Example Usage
/// ```dart
/// SentientAspectRatio(
///   child: SentientContainer(
///     child: Text('This container will change shape!'),
///   ),
/// )
/// ```
class SentientAspectRatio extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// An optional override for the aspect ratio.
  ///
  /// If provided, this value is used directly, and the emotion-aware
  /// adaptation decision is disabled.
  final double? aspectRatio;

  /// An optional configuration to override the emotion-based defaults.
  final AspectRatioConfig? configOverride;

  /// Creates a new adaptive aspect ratio widget.
  const SentientAspectRatio({
    super.key,
    required this.child,
    this.aspectRatio,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the final aspect ratio from emotion or a manual override.
    final AspectRatioConfig config = configOverride ?? emotionTheme.aspectRatioConfig;
    final double finalAspectRatio = aspectRatio ?? config.ratio;

    // Animate the transition between aspect ratios smoothly.
    return TweenAnimationBuilder<double>(
      duration: emotionTheme.animation.transitionDuration,
      curve: emotionTheme.animation.animationCurve,
      tween: Tween<double>(begin: finalAspectRatio, end: finalAspectRatio),
      builder: (context, animatedAspectRatio, child) {
        return AspectRatio(
          aspectRatio: animatedAspectRatio,
          child: child!,
        );
      },
      child: child,
    );
  }
}
