// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive animated builder widget that adapts its animation behavior based on the
/// user's emotional state.
///
/// `SentientAnimatedBuilder` functions as a wrapper around Flutter's [AnimatedBuilder]
/// but introduces emotion-aware animation timing and behavior, using values from
/// the active [EmotionTheme] to determine optimal animation characteristics.
///
/// The widget listens to the [AdaptationManager] automatically and rebuilds
/// when the user's emotional state changes, allowing for adjustments to animation
/// parameters in real-time.
///
/// ## Features
/// - Emotion-aware animation timing and curves.
/// - Adaptive animation behavior (e.g., playful vs. smooth).
/// - Supports custom animation controllers.
/// - Follows Sentient Adaptation Guidelines for safe animations.
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientAnimatedBuilder(
///   animation: controller,
///   builder: (context, child) {
///     return Transform.rotate(
///       angle: controller.value * 2 * 3.14159,
///       child: child,
///     );
///   },
///   child: Text('Rotating text'),
/// )
/// ```
///
/// With custom duration override:
/// ```dart
/// SentientAnimatedBuilder(
///   animation: controller,
///   duration: Duration(milliseconds: 500),
///   builder: (context, child) => child,
///   child: Text('Custom animation'),
/// )
/// ```
class SentientAnimatedBuilder extends StatefulWidget {
  /// The animation to drive the rebuilding.
  final Animation<double> animation;

  /// The builder function that rebuilds when the animation changes.
  final Widget Function(BuildContext context, Widget? child) builder;

  /// The widget below this widget in the tree.
  final Widget? child;

  /// Custom animation duration override.
  ///
  /// If null, the duration is determined by the active [EmotionTheme].
  final Duration? duration;

  /// Custom animation curve override.
  ///
  /// If null, the curve is determined by the active [EmotionTheme].
  final Curve? curve;

  /// Whether to force smooth transitions regardless of emotion.
  final bool forceSmoothTransitions;

  /// Creates a new adaptive animated builder.
  const SentientAnimatedBuilder({
    super.key,
    required this.animation,
    required this.builder,
    this.child,
    this.duration,
    this.curve,
    this.forceSmoothTransitions = false,
  });

  @override
  State<SentientAnimatedBuilder> createState() =>
      _SentientAnimatedBuilderState();
}

class _SentientAnimatedBuilderState extends State<SentientAnimatedBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _emotionController;
  late Animation<double> _emotionAnimation;
  late Animation<double> _combinedAnimation;

  @override
  void initState() {
    super.initState();
    _emotionController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _emotionAnimation = CurvedAnimation(
      parent: _emotionController,
      curve: Curves.easeInOut,
    );
    _updateAnimation();
  }

  @override
  void didUpdateWidget(SentientAnimatedBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.animation != widget.animation) {
      _updateAnimation();
    }
  }

  void _updateAnimation() {
    _combinedAnimation = widget.animation.drive(
      TweenSequence<double>([
        TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 1.0),
          weight: 1.0,
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _emotionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Update emotion controller when emotion changes.
    _updateEmotionAnimation(emotionTheme);

    return AnimatedBuilder(
      animation: Listenable.merge([_combinedAnimation, _emotionAnimation]),
      builder: (context, child) {
        // Note: Future implementations may expose the modified value to the builder.
        // Currently, this ensures rebuilds occur on emotion changes.
        return widget.builder(context, widget.child);
      },
      child: widget.child,
    );
  }

  /// Updates the emotion animation based on the current emotional state.
  void _updateEmotionAnimation(EmotionTheme theme) {
    final targetDuration =
        widget.duration ?? theme.animation.transitionDuration;

    if (_emotionController.duration != targetDuration) {
      _emotionController.duration = targetDuration;
      _emotionController.reset();
      _emotionController.forward();
    }
  }

  /// Applies emotion-specific modifications to animation values.
  ///
  /// This method implements principles from the Sentient Adaptation Guidelines:
  /// - **Consistency First**: Always provides animation output.
  /// - **Safe Bounds**: Keeps animations within predictable ranges.
  /// - **Deterministic Mapping**: Same emotion → same modifications.
  /// - **Preserve Hierarchy**: Maintains animation without visual dominance.
  /// - **Subtle Changes**: Adaptations are smooth, not dramatic.
  ///
  /// *Note: This decision is currently preserved for future enhancements where
  /// the builder might consume modified animation values.*
  double _applyEmotionModifications(double value, EmotionTheme theme) {
    switch (theme.emotionState) {
      case EmotionState.anger:
        // Anger: Minimal, predictable, non-agitating.
        if (widget.forceSmoothTransitions ||
            theme.animation.useSmoothTransitionsOnly) {
          return _smoothAnimation(value, 0.5); // Dampened movement.
        }
        return value * 0.7; // Reduced intensity.

      case EmotionState.disgust:
        // Disgust: Clean, smooth, non-jarring.
        return _smoothAnimation(value, 0.9); // Very smooth.

      case EmotionState.enjoyment:
        // Enjoyment: Expressive, engaging, lively.
        if (theme.animation.allowPlayfulAnimations &&
            !widget.forceSmoothTransitions) {
          return _playfulAnimation(value); // Add subtle bounce.
        }
        return value; // Full expression.

      case EmotionState.fear:
        // Fear: Predictable, safe, calming.
        return _smoothAnimation(value, 0.6); // Very smooth, gentle.

      case EmotionState.sadness:
        // Sadness: Gentle, comforting, slow.
        return _smoothAnimation(value, 0.7); // Gentle, slow movement.

      case EmotionState.surprise:
        // Surprise: Dynamic, noticeable, controlled novelty.
        if (theme.animation.allowPlayfulAnimations &&
            !widget.forceSmoothTransitions) {
          return _dynamicAnimation(value); // Add controlled energy.
        }
        return value * 1.1; // Slightly more dynamic.

      case EmotionState.neutral:
      // Neutral: Balanced, standard, predictable.
        return value;
    }
  }

  /// Applies smooth easing to animation values for calming effects.
  double _smoothAnimation(double value, double intensity) {
    return Curves.easeInOut.transform(value) * intensity +
        (1 - intensity) * value;
  }

  /// Applies playful modifications for engaging animations.
  double _playfulAnimation(double value) {
    // Add subtle bounce effect.
    final bounce = Curves.elasticOut.transform(value) * 0.1;
    return value + bounce * (value < 0.5 ? 1 : -1);
  }

  /// Applies dynamic modifications for energetic animations.
  double _dynamicAnimation(double value) {
    // Add controlled acceleration/deceleration.
    if (value < 0.5) {
      return Curves.easeOutCubic.transform(value * 2) * 0.5;
    } else {
      return 0.5 + Curves.easeInCubic.transform((value - 0.5) * 2) * 0.5;
    }
  }
}

/// A specialized version of [SentientAnimatedBuilder] for simple visibility transitions.
///
/// This widget provides a simplified interface for showing or hiding content
/// with emotion-aware transitions (e.g., faster for enjoyment, smoother for sadness).
///
/// ## Example Usage
/// ```dart
/// SentientTransitionBuilder(
///   show: isVisible,
///   child: Text('Fading content'),
/// )
/// ```
class SentientTransitionBuilder extends StatelessWidget {
  /// The widget to display when [show] is true.
  final Widget? child;

  /// Whether to show the child (true) or hide it (false).
  final bool show;

  /// Custom transition duration.
  ///
  /// If null, the duration is determined by the active [EmotionTheme].
  final Duration? duration;

  /// Custom animation curve.
  ///
  /// If null, the curve is determined by the active [EmotionTheme].
  final Curve? curve;

  /// An optional configuration to override the emotion-based defaults.
  final AnimatedSwitcherConfig? configOverride;

  /// Creates a new adaptive transition builder.
  const SentientTransitionBuilder({
    super.key,
    this.child,
    required this.show,
    this.duration,
    this.curve,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    final AnimatedSwitcherConfig config =
        configOverride ?? emotionTheme.animatedSwitcherConfig;

    return AnimatedSwitcher(
      duration: duration ?? config.duration,
      switchInCurve: curve ?? config.switchInCurve,
      switchOutCurve: curve ?? config.switchOutCurve,
      child: show ? child : const SizedBox.shrink(),
    );
  }
}
