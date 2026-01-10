import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive widget that clips its child using a rounded rectangle that adapts
/// to the user's emotional state.
///
/// `SentientClipRRect` functions as a drop-in replacement for Flutter's [ClipRRect]
/// but adjusts its `borderRadius` based on the active [EmotionTheme] from the
/// [AdaptationManager]. This allows containers, images, and other elements
/// to feel softer or sharper depending on the emotional context.
///
/// ## Features
/// - Emotion-aware border radius (e.g., larger radius for sadness, smaller for anger).
/// - Supports a custom `borderRadius` or `configOverride` to disable emotional adaptation.
///
/// ## Example Usage
/// ```dart
/// SentientClipRRect(
///   child: SentientImage(path: 'assets/image.png'),
/// )
/// ```
class SentientClipRRect extends StatelessWidget {
  /// The widget below this widget in the tree to be clipped.
  final Widget child;

  /// An optional override for the border radius.
  ///
  /// If provided, this value is used directly, and the emotion-aware
  /// adaptation decision is disabled.
  final double? borderRadius;

  /// An optional configuration to override the emotion-based defaults.
  final ClipRRectConfig? configOverride;

  /// Creates a new adaptive `ClipRRect` widget.
  const SentientClipRRect({
    super.key,
    required this.child,
    this.borderRadius,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from an override or the current emotion.
    final ClipRRectConfig config =
        configOverride ?? emotionTheme.clipRRectConfig;

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? config.borderRadius),
      child: child,
    );
  }
}
