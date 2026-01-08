import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'emotion_theme.dart';

/// A widget that implicitly animates the [EmotionTheme] from one value to another.
///
/// This widget enables smooth transitions for all custom Sentient UI properties
/// (like custom corner radii, spacing, and icon sizes) that are not covered
/// by the standard Flutter [ThemeData].
///
/// It works similarly to [AnimatedTheme] but for [EmotionTheme].
class AnimatedEmotionTheme extends ImplicitlyAnimatedWidget {
  /// The target emotion theme to animate to.
  final EmotionTheme data;

  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates an animated emotion theme.
  const AnimatedEmotionTheme({
    super.key,
    required this.data,
    required this.child,
    super.curve = Curves.linear,
    super.duration = const Duration(milliseconds: 200),
    super.onEnd,
  });

  @override
  AnimatedWidgetBaseState<AnimatedEmotionTheme> createState() =>
      _AnimatedEmotionThemeState();
}

class _AnimatedEmotionThemeState
    extends AnimatedWidgetBaseState<AnimatedEmotionTheme> {
  EmotionThemeTween? _data;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _data = visitor(
      _data,
      widget.data,
      (dynamic value) => EmotionThemeTween(begin: value as EmotionTheme),
    ) as EmotionThemeTween?;
  }

  @override
  Widget build(BuildContext context) {
    // We use Provider.value to expose the current *interpolated* theme
    // frame-by-frame to the subtree.
    return Provider<EmotionTheme>.value(
      value: _data!.evaluate(animation),
      child: widget.child,
    );
  }
}

/// A custom tween that interpolates between two [EmotionTheme]s.
class EmotionThemeTween extends Tween<EmotionTheme> {
  EmotionThemeTween({super.begin, super.end});

  @override
  EmotionTheme lerp(double t) => EmotionTheme.lerp(begin!, end!, t);
}
