import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive widget that positions its child in a [Stack] and adapts its
/// placement based on the user's emotional state.
///
/// `SentientPositioned` functions as a drop-in replacement for Flutter's
/// [Positioned] widget but animates its offset based on the active [EmotionTheme]
/// provided by the [AdaptationManager]. This allows the UI layout to feel more
/// stable, anchored, or dynamic depending on the emotional context.
///
/// ## Features
/// - Emotion-aware positioning (top, bottom, left, right).
/// - Smoothly animates transitions between different positional states.
/// - Supports custom overrides for all positional properties.
///
/// ## Example Usage
/// ```dart
/// Stack(
///   children: [
///     SentientPositioned(
///       child: SentientContainer(),
///     ),
///   ],
/// )
/// ```
class SentientPositioned extends StatelessWidget {
  /// The widget to be positioned within the [Stack].
  final Widget child;

  /// The distance to offset the child from the top of the stack.
  ///
  /// If not provided, the value is determined by the active [EmotionTheme].
  final double? top;

  /// The distance to offset the child from the bottom of the stack.
  final double? bottom;

  /// The distance to offset the child from the left of the stack.
  final double? left;

  /// The distance to offset the child from the right of the stack.
  final double? right;

  /// An optional fixed width for the child.
  final double? width;

  /// An optional fixed height for the child.
  final double? height;

  /// A custom configuration that overrides the emotion-based defaults.
  final PositionedConfig? configOverride;

  /// Creates a new adaptive `SentientPositioned` widget.
  const SentientPositioned({
    super.key,
    required this.child,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.width,
    this.height,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    final PositionedConfig config =
        configOverride ?? emotionTheme.positionedConfig;
    final double baseSpacing = emotionTheme.baseSpacing;

    // Animate the transition between positional states smoothly.
    return AnimatedPositioned(
      duration: emotionTheme.animation.transitionDuration,
      curve: emotionTheme.animation.animationCurve,
      top: top ?? (config.topMultiplier != null ? config.topMultiplier! * baseSpacing : null),
      bottom: bottom ?? (config.bottomMultiplier != null ? config.bottomMultiplier! * baseSpacing : null),
      left: left ?? (config.leftMultiplier != null ? config.leftMultiplier! * baseSpacing : null),
      right: right ?? (config.rightMultiplier != null ? config.rightMultiplier! * baseSpacing : null),
      width: width,
      height: height,
      child: child,
    );
  }
}
