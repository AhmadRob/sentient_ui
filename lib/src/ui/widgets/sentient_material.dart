import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A Material wrapper that adapts its visual style dynamically
/// based on the current [EmotionTheme].
///
/// This widget is part of the Sentient UI system and reacts to
/// emotional states such as sadness, enjoyment, or fear by
/// adjusting colors, elevation, padding, and borders.
///
/// Typically used as a building block for emotion-aware surfaces.
///
/// ## Features
/// - Emotion-aware visual style (soft/flat for negative, lively/elevated for positive).
/// - Dynamic adjustment of elevation, border radius, and gradient.
/// - Configurable overrides via [MaterialConfig].
/// - Seamless integration with [EmotionTheme].
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientMaterial(
///   child: Padding(
///     padding: EdgeInsets.all(16.0),
///     child: Text('Card Content'),
///   ),
/// )
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientMaterial(
///   config: MaterialConfig(
///     elevation: 8.0,
///     borderRadius: 16.0,
///   ),
///   child: Container(...),
/// )
/// ```
class SentientMaterial extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// Optional configuration override.
  ///
  /// When provided, non-null properties will override
  /// the emotion-resolved configuration.
  final MaterialConfig? config;

  /// Creates a [SentientMaterial].
  ///
  /// The [child] argument must not be null.
  /// The [config] can be used to partially or fully override
  /// the emotion-based styling.
  const SentientMaterial({
    super.key,
    required this.child,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    // Listen to emotion-driven adaptations
    final adaptationManager = context.watch<AdaptationManager>();

    // Current emotion-aware theme
    final theme = adaptationManager.currentTheme;

    // Resolve final visual configuration
    final resolved = config ?? theme.materialConfig;

    return Material(
      color: resolved.backgroundColor,
      elevation: resolved.elevation,
      borderRadius: BorderRadius.circular(resolved.borderRadius),
      child: Container(
        padding: resolved.padding,
        alignment: resolved.alignment,
        decoration: BoxDecoration(
          gradient: resolved.backgroundGradient,
          border: resolved.border,
          borderRadius: BorderRadius.circular(resolved.borderRadius),
        ),
        child: child,
      ),
    );
  }
}
