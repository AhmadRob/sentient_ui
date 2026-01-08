import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../../models/emotion_state.dart';

/// A reactive animated opacity widget that adapts its opacity behavior based on the
/// user's emotional state.
///
/// `SentientAnimatedOpacity` functions as a drop-in replacement for Flutter's
/// [AnimatedOpacity] but introduces emotion-aware timing and opacity adjustments.
/// It automatically tunes the transition duration and curve based on the active
/// [EmotionTheme] provided by the [AdaptationManager].
///
/// This widget ensures that visibility changes feel consistent with the user's
/// emotional context—for example, faster and bouncier for enjoyment, or slower
/// and smoother for sadness.
///
/// ## Features
/// - Emotion-aware transition duration and easing curves.
/// - Subtle opacity modification based on emotion (e.g., ensuring minimum visibility for fear/anger).
/// - Supports custom overrides for duration and curve.
///
/// ## Example Usage
/// ```dart
/// SentientAnimatedOpacity(
///   opacity: isVisible ? 1.0 : 0.0,
///   child: Text('Now you see me'),
/// )
/// ```
class SentientAnimatedOpacity extends StatelessWidget {
  /// The widget to animate.
  final Widget child;

  /// The target opacity.
  ///
  /// This value is slightly adjusted based on the emotional state to ensure
  /// accessibility and comfort (e.g., preventing elements from disappearing
  /// too abruptly in negative states).
  final double opacity;

  /// An optional override for the animation duration.
  ///
  /// If not provided, the duration is determined by the active [EmotionTheme].
  final Duration? duration;

  /// An optional override for the animation curve.
  ///
  /// If not provided, the curve is determined by the active [EmotionTheme].
  final Curve? curve;

  /// Called when the animation completes.
  final VoidCallback? onEnd;

  /// Creates a new adaptive `SentientAnimatedOpacity` widget.
  const SentientAnimatedOpacity({
    super.key,
    required this.child,
    required this.opacity,
    this.duration,
    this.curve,
    this.onEnd,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;
    final opacityBehavior = _getEmotionOpacityBehavior(emotionTheme);

    return AnimatedOpacity(
      opacity: _applyEmotionOpacityModification(opacity, emotionTheme),
      duration: duration ?? opacityBehavior.duration,
      curve: curve ?? opacityBehavior.curve,
      onEnd: onEnd,
      child: child,
    );
  }

  /// Adjusts the target opacity based on the emotional state.
  ///
  /// This ensures that in states of high arousal or negativity (like anger or fear),
  /// vital UI elements don't fade out too completely or aggressively, maintaining
  /// a sense of stability and visibility.
  double _applyEmotionOpacityModification(double opacity, EmotionTheme theme) {
    // Clamp sensing to valid range.
    double target = opacity.clamp(0.0, 1.0);
    
    // Only apply modifications if the element is meant to be at least partially visible.
    // We avoid making invisible items (opacity 0) visible unexpectedly.
    if (target <= 0.0) return 0.0;

    switch (theme.emotionState) {
      case EmotionState.anger:
        // Ensure minimum visibility for stability.
        if (target < 0.3) return 0.3;
        return target * 0.9;
      case EmotionState.disgust:
        if (target < 0.4) return 0.4;
        return (target * 1.05).clamp(0.0, 1.0);
      case EmotionState.enjoyment:
        return target;
      case EmotionState.fear:
        // Fear requires reassurance; don't hide things completely if possible.
        if (target < 0.5) return 0.5;
        return target * 0.95;
      case EmotionState.sadness:
        // Soften the opacity slightly.
        return target * 0.98;
      case EmotionState.surprise:
        // Enhance visibility slightly.
        if (target > 0.8) {
          return (target * 1.02).clamp(0.0, 1.0);
        }
        return target;
      default:
        return target;
    }
  }

  /// Returns the appropriate duration and curve for the current emotion.
  _OpacityBehavior _getEmotionOpacityBehavior(EmotionTheme theme) {
    switch (theme.emotionState) {
      case EmotionState.anger:
        return _OpacityBehavior(
          duration: theme.animation.transitionDuration * 1.5,
          curve: Curves.easeInOut,
        );
      case EmotionState.disgust:
        return _OpacityBehavior(
          duration: theme.animation.transitionDuration * 1.2,
          curve: Curves.easeOut,
        );
      case EmotionState.enjoyment:
        return _OpacityBehavior(
          duration: theme.animation.microInteractionDuration,
          curve: theme.animation.allowPlayfulAnimations 
              ? Curves.easeOutBack
              : Curves.easeOut,
        );
      case EmotionState.fear:
        return _OpacityBehavior(
          duration: theme.animation.transitionDuration * 1.8,
          curve: Curves.easeInOutCubic,
        );
      case EmotionState.sadness:
        return _OpacityBehavior(
          duration: theme.animation.transitionDuration * 1.4,
          curve: Curves.easeInOut,
        );
      case EmotionState.surprise:
        return _OpacityBehavior(
          duration: theme.animation.microInteractionDuration * 0.8,
          curve: theme.animation.allowPlayfulAnimations
              ? Curves.elasticOut
              : Curves.easeOutCubic,
        );
      default:
        return _OpacityBehavior(
          duration: theme.animation.transitionDuration,
          curve: theme.animation.animationCurve,
        );
    }
  }
}

/// A helper class to encapsulate animation parameters.
@immutable
class _OpacityBehavior {
  final Duration duration;
  final Curve curve;

  const _OpacityBehavior({
    required this.duration,
    required this.curve,
  });
}

/// A convenience widget for fading content in and out with emotion-aware transitions.
///
/// This widget simplifies the common pattern of toggling visibility using opacity.
/// It maps a boolean [show] state to 1.0 or 0.0 opacity, utilizing emotion-specific
/// durations (e.g., faster fades for [EmotionState.enjoyment], slower for [EmotionState.sadness]).
class SentientFadeTransition extends StatelessWidget {
  /// The widget to fade.
  final Widget? child;

  /// Whether the child should be visible (opacity 1.0) or invisible (opacity 0.0).
  final bool show;

  /// An optional override for the transition duration.
  final Duration? duration;

  /// An optional override for the transition curve.
  final Curve? curve;

  /// Creates a new adaptive fade transition.
  const SentientFadeTransition({
    super.key,
    this.child,
    required this.show,
    this.duration,
    this.curve,
  });

  @override
  Widget build(BuildContext context) {
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;
    final fadeBehavior = _getEmotionFadeBehavior(emotionTheme);

    return AnimatedOpacity(
      opacity: show ? 1.0 : 0.0,
      duration: duration ?? fadeBehavior.duration,
      curve: curve ?? fadeBehavior.curve,
      child: child,
    );
  }

  /// Returns specific fade behaviors for different emotions.
  _OpacityBehavior _getEmotionFadeBehavior(EmotionTheme theme) {
    switch (theme.emotionState) {
      case EmotionState.anger:
        // Slower, deliberate fade.
        return _OpacityBehavior(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      case EmotionState.fear:
        // Very slow, non-threatening fade.
        return _OpacityBehavior(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      case EmotionState.enjoyment:
        // Snappy, responsive fade.
        return _OpacityBehavior(
          duration: const Duration(milliseconds: 200),
          curve: theme.animation.allowPlayfulAnimations 
              ? Curves.easeOutBack
              : Curves.easeOut,
        );
      case EmotionState.surprise:
        // Quick, immediate fade.
        return _OpacityBehavior(
          duration: const Duration(milliseconds: 150),
          curve: theme.animation.allowPlayfulAnimations
              ? Curves.elasticOut
              : Curves.easeOutCubic,
        );
      default:
        // Standard fade.
        return _OpacityBehavior(
          duration: theme.animation.transitionDuration,
          curve: theme.animation.animationCurve,
        );
    }
  }
}
