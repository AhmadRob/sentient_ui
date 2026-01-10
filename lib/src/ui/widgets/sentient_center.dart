import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// An emotion-aware wrapper around Flutter's [Center] widget.
///
/// This widget adapts its alignment behavior dynamically
/// based on the current [EmotionTheme], ensuring visual stability
/// during negative emotional states and allowing expressive
/// flexibility during positive emotions.
///
/// It is designed to keep layout movement minimal to
/// preserve comfort and predictability while subtly reflecting
/// the user's emotional context.
///
/// Common use cases include centering content within
/// containers, pages, or adaptive layout sections
/// within the Sentient UI system.
///
/// ## Features
/// - Emotion-aware alignment (stable for negative, dynamic for positive).
/// - Automatic adaptation to user's emotional state.
/// - Configurable overrides via [CenterConfig].
/// - Seamless integration with [EmotionTheme].
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientCenter(
///   child: Text('Centered Content'),
/// )
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientCenter(
///   config: CenterConfig(
///     alignment: Alignment.topCenter,
///   ),
///   child: Text('Custom Alignment'),
/// )
/// ```
class SentientCenter extends StatelessWidget {
  /// The widget to be positioned at the center.
  final Widget child;

  /// Optional configuration override.
  ///
  /// When provided, this configuration overrides the
  /// emotion-resolved alignment behavior.
  final CenterConfig? config;

  /// Creates a [SentientCenter].
  ///
  /// The [child] argument must not be null.
  const SentientCenter({
    super.key,
    required this.child,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    // Observe emotion-driven layout adaptations
    final adaptationManager = context.watch<AdaptationManager>();

    // Current emotion-aware theme
    final theme = adaptationManager.currentTheme;

    // Resolve final centering configuration
    final resolved = config ?? theme.centerConfig;

    return Center(
      child: Align(
        alignment: resolved.alignment,
        child: child,
      ),
    );
  }
}
