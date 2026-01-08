import 'package:flutter/material.dart';

/// Defines animation behavior characteristics for emotional states.
@immutable
class AnimationConfig {
  /// Duration for standard transitions (e.g., page changes, fades)
  final Duration transitionDuration;

  /// Duration for micro-interactions (e.g., button hover, tap feedback)
  final Duration microInteractionDuration;

  /// The animation curve to use for most transitions
  final Curve animationCurve;

  /// Whether playful animations (bounce, sparkle, pop) are allowed
  final bool allowPlayfulAnimations;

  /// Whether sudden/abrupt animations should be avoided
  final bool useSmoothTransitionsOnly;

  const AnimationConfig({
    required this.transitionDuration,
    required this.microInteractionDuration,
    required this.animationCurve,
    this.allowPlayfulAnimations = false,
    this.useSmoothTransitionsOnly = true,
  });

  static const AnimationConfig calm = AnimationConfig(
    transitionDuration: Duration(milliseconds: 400),
    microInteractionDuration: Duration(milliseconds: 200),
    animationCurve: Curves.easeInOut,
    allowPlayfulAnimations: false,
    useSmoothTransitionsOnly: true,
  );

  static const AnimationConfig lively = AnimationConfig(
    transitionDuration: Duration(milliseconds: 300),
    microInteractionDuration: Duration(milliseconds: 150),
    animationCurve: Curves.easeOutBack,
    allowPlayfulAnimations: true,
    useSmoothTransitionsOnly: false,
  );

  static const AnimationConfig minimal = AnimationConfig(
    transitionDuration: Duration(milliseconds: 500),
    microInteractionDuration: Duration(milliseconds: 300),
    animationCurve: Curves.easeOut,
    allowPlayfulAnimations: false,
    useSmoothTransitionsOnly: true,
  );
}
