import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../configs/padding_config.dart';

/// An emotion-aware wrapper around Flutter's [Padding] widget.
///
/// This widget adapts its padding values dynamically based on the
/// current [EmotionTheme], ensuring visual comfort and
/// readability by adjusting spacing according to the user's
/// emotional state.
///
/// It is designed to reduce visual density during negative
/// or low-arousal states (e.g., sadness, fear) by increasing
/// spacing, while allowing more compact layouts during
/// positive, high-energy states.
///
/// Common use cases include wrapping content sections, cards,
/// or layout blocks where adaptive breathing room enhances
/// the user experience within the Sentient UI system.
///
/// ## Features
/// - Emotion-aware spacing (wider for comfort, standard/tighter for energy).
/// - Dynamic adjustment to reduce visual clutter.
/// - Configurable overrides via [PaddingConfig].
/// - Seamless integration with [EmotionTheme].
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientPadding(
///   child: Text('Content'),
/// )
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientPadding(
///   config: PaddingConfig(
///     padding: EdgeInsets.all(20.0),
///   ),
///   child: Text('Custom Padding'),
/// )
/// ```
class SentientPadding extends StatelessWidget {
  /// The widget to be inset by the resolved padding.
  final Widget child;

  /// Optional configuration override.
  ///
  /// When provided, non-null padding values override
  /// the emotion-resolved configuration.
  final PaddingConfig? config;

  /// Creates a [SentientPadding].
  ///
  /// The [child] argument must not be null.
  const SentientPadding({
    super.key,
    required this.child,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    // Observe emotion-driven spacing adaptations
    final adaptation = context.watch<AdaptationManager>();

    // Current emotion-aware theme
    final theme = adaptation.currentTheme;

    // Resolve final padding configuration and merge overrides
    final resolved = config ?? theme.paddingConfig;

    return Padding(
      padding: resolved.padding,
      child: child,
    );
  }
}
