import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../configs/wrap_config.dart';

/// An emotion-aware wrapper around Flutter's [Wrap] widget.
///
/// This widget adapts layout spacing, alignment, and direction
/// dynamically based on the current [EmotionTheme].
///
/// It is designed to maintain visual comfort and readability
/// under different emotional states by adjusting how
/// child widgets are distributed and wrapped.
///
/// Common use cases include tag lists, chip groups,
/// and adaptive button layouts within the Sentient UI system.
///
/// ## Features
/// - Emotion-aware spacing (wider for comfort, tighter for energy).
/// - Dynamic alignment adjustment based on emotional state.
/// - Configurable overrides via [WrapConfig].
/// - Seamless integration with [EmotionTheme].
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientWrap(
///   children: [
///     Chip(label: Text('Tag 1')),
///     Chip(label: Text('Tag 2')),
///   ],
/// )
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientWrap(
///   config: WrapConfig(
///     spacing: 16.0,
///     alignment: WrapAlignment.center,
///   ),
///   children: [...],
/// )
/// ```
class SentientWrap extends StatelessWidget {
  /// The widgets to display inside the wrap layout.
  final List<Widget> children;

  /// Optional configuration override.
  ///
  /// When provided, non-null values override the
  /// emotion-resolved wrap configuration.
  final WrapConfig? config;

  /// Creates a [SentientWrap].
  ///
  /// The [children] argument must not be null.
  /// Use [config] to fine-tune layout behavior
  /// independent of emotional adaptation.
  const SentientWrap({
    super.key,
    required this.children,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    // Observe emotion-driven layout adaptations
    final adaptationManager = context.watch<AdaptationManager>();

    // Current emotion-aware theme
    final theme = adaptationManager.currentTheme;

    // Resolve final wrap configuration
    final resolved = config ?? theme.wrapConfig;

    return Wrap(
      spacing: resolved.spacing,
      runSpacing: resolved.runSpacing,
      alignment: resolved.alignment,
      runAlignment: resolved.runAlignment,
      direction: resolved.direction,
      clipBehavior: resolved.clipBehavior,
      children: children,
    );
  }
}
