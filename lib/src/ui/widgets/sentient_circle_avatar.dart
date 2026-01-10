import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive circle avatar that adapts its appearance based on the
/// user's emotional state.
///
/// `SentientCircleAvatar` functions similarly to Flutter's [CircleAvatar]
/// but introduces emotion-aware styling, using values from the active [EmotionTheme]
/// to determine optimal colors, sizing, and visual effects.
///
/// The widget listens to the [AdaptationManager] automatically and rebuilds
/// when the user's emotional state changes, potentially adjusting avatar appearance.
///
/// ## Features
/// - Emotion-aware background colors and sizing.
/// - Adaptive shadow and border effects.
/// - Dynamic radius calculations.
/// - Follows Sentient Adaptation Guidelines for consistent avatars.
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientCircleAvatar(
///   child: Text('JD'),
/// )
/// ```
///
/// With custom radius and background:
/// ```dart
/// SentientCircleAvatar(
///   radius: 30,
///   backgroundColor: Colors.blue,
///   child: Icon(Icons.person),
/// )
/// ```
class SentientCircleAvatar extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget? child;

  /// Custom radius override (null = use emotion-based radius).
  final double? radius;

  /// Custom background color override (null = use emotion-based color).
  final Color? backgroundColor;

  /// Custom background image override (null = use emotion-based styling).
  final ImageProvider? backgroundImage;

  /// Custom foreground color override (null = use emotion-based color).
  final Color? foregroundColor;

  /// Custom foreground image override.
  final ImageProvider? foregroundImage;

  /// Custom error builder for foreground image.
  final ImageErrorListener? onForegroundImageError;

  /// Custom error builder for background image.
  final ImageErrorListener? onBackgroundImageError;

  /// An optional configuration to override the emotion-based defaults.
  final CircleAvatarConfig? configOverride;

  /// Creates a new adaptive circle avatar.
  const SentientCircleAvatar({
    super.key,
    this.child,
    this.radius,
    this.backgroundColor,
    this.backgroundImage,
    this.foregroundColor,
    this.foregroundImage,
    this.onForegroundImageError,
    this.onBackgroundImageError,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Get emotion-driven avatar styling.
    final CircleAvatarConfig config = configOverride ?? emotionTheme.circleAvatarConfig;

    return AnimatedContainer(
      duration: emotionTheme.animation.transitionDuration,
      curve: emotionTheme.animation.animationCurve,
      child: CircleAvatar(
        radius: radius ?? config.radius,
        backgroundColor: backgroundColor ?? config.backgroundColor,
        backgroundImage: backgroundImage, // Background image usually comes from user, but we could add one to config if needed (rare)
        foregroundColor: foregroundColor ?? config.foregroundColor,
        foregroundImage: foregroundImage,
        onForegroundImageError: onForegroundImageError,
        onBackgroundImageError: onBackgroundImageError,
        child: _buildChild(emotionTheme, config),
      ),
    );
  }

  /// Builds the child widget with emotion-aware styling.
  Widget? _buildChild(EmotionTheme theme, CircleAvatarConfig config) {
    if (child == null) return null;

    // Apply emotion-specific effects to child
    Widget styledChild = child!;

    if (theme.animation.allowPlayfulAnimations) {
      switch (theme.emotionState) {
        case EmotionState.enjoyment:
          // Add gentle pulse for enjoyment.
          styledChild = AnimatedContainer(
            duration: theme.animation.microInteractionDuration,
            curve: Curves.easeInOut,
            transform: Matrix4.identity()..scaleByDouble(1.05, 1.05, 1.05, 1.0),
            child: styledChild,
          );
          break;
        case EmotionState.surprise:
          // Add bounce effect for surprise.
          styledChild = AnimatedContainer(
            duration: theme.animation.microInteractionDuration,
            curve: Curves.bounceOut,
            transform: Matrix4.identity()..scaleByDouble(1.1, 1.1, 1.1, 1.0),
            child: styledChild,
          );
          break;
        default:
          break;
      }
    }

    return styledChild;
  }
}
