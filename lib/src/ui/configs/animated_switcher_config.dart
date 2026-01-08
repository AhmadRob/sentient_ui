import 'package:flutter/material.dart';

/// Controls duration and animation curves for different emotions.
@immutable
class AnimatedSwitcherConfig {
  /// Duration of the animation
  final Duration duration;

  /// Curve for the entering animation
  final Curve switchInCurve;

  /// Curve for the exiting animation
  final Curve switchOutCurve;

  const AnimatedSwitcherConfig({
    required this.duration,
    required this.switchInCurve,
    required this.switchOutCurve,
  });

  /// Neutral emotion: moderate speed, smooth curves
  static const AnimatedSwitcherConfig neutral = AnimatedSwitcherConfig(
    duration: Duration(milliseconds: 300),
    switchInCurve: Curves.easeInOut,
    switchOutCurve: Curves.easeInOut,
  );

  /// Soft emotion (e.g., sadness): slower and gentle
  static const AnimatedSwitcherConfig soft = AnimatedSwitcherConfig(
    duration: Duration(milliseconds: 500),
    switchInCurve: Curves.easeIn,
    switchOutCurve: Curves.easeOut,
  );

  /// Lively emotion (e.g., enjoyment, surprise): faster and playful
  static const AnimatedSwitcherConfig lively = AnimatedSwitcherConfig(
    duration: Duration(milliseconds: 200),
    switchInCurve: Curves.easeOutBack,
    switchOutCurve: Curves.easeInBack,
  );
}
