import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../../models/emotion_state.dart';
import '../foundation/emotion_theme.dart';

/// A reactive divider widget that adapts its appearance based on the
/// user's emotional state.
///
/// `SentientDivider` functions as a drop-in replacement for Flutter's [Divider]
/// but introduces emotion-aware styling, using values from the active
/// [EmotionTheme] to determine optimal thickness, height, and color.
///
/// The widget listens to the [AdaptationManager] automatically and rebuilds
/// when the user's emotional state changes.
///
/// ## Features
/// - Emotion-aware thickness and spacing.
/// - Adaptive color intensity and saturation.
/// - Supports custom overrides for thickness and height.
/// - Follows Sentient Adaptation Guidelines for visual hierarchy.
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientDivider()
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientDivider(
///   thickness: 2.0,
///   height: 20.0,
/// )
/// ```
class SentientDivider extends StatelessWidget {
  /// The thickness of the divider line.
  ///
  /// If null, this is determined by the active [EmotionTheme].
  final double? thickness;

  /// The height of the divider container.
  ///
  /// If null, this is determined by the active [EmotionTheme].
  final double? height;

  /// The color of the divider.
  ///
  /// If null, this is determined by the active [EmotionTheme].
  final Color? color;

  /// The indent of the divider.
  final double? indent;

  /// The end indent of the divider.
  final double? endIndent;

  /// An optional configuration to override the emotion-based defaults.
  final DividerConfig? configOverride;

  /// Creates a new adaptive divider.
  const SentientDivider({
    super.key,
    this.thickness,
    this.height,
    this.color,
    this.indent,
    this.endIndent,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Get emotion-driven styling.
    final DividerConfig config = configOverride ?? emotionTheme.dividerConfig;

    return AnimatedContainer(
      duration: emotionTheme.animation.transitionDuration,
      curve: emotionTheme.animation.animationCurve,
      height: height ?? config.height,
      child: Divider(
        thickness: thickness ?? config.thickness,
        color: color ?? config.color,
        indent: indent,
        endIndent: endIndent,
      ),
    );
  }
}
