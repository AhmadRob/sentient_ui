import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../configs/icon_config.dart';
import '../foundation/emotion_theme.dart';

/// A reactive icon widget that adapts its appearance based on the
/// user's emotional state.
///
/// `SentientIcon` functions as a drop-in replacement for Flutter's [Icon]
/// but introduces emotion-aware styling. It uses values from the active
/// [EmotionTheme] or a provided [IconConfig] to determine optimal color and size.
///
/// The widget listens to the [AdaptationManager] automatically and rebuilds
/// when the user's emotional state changes.
///
/// ## Features
/// - Emotion-aware sizing (e.g., larger for enjoyment, smaller for anger).
/// - Adaptive coloring decision.
/// - Supports custom configuration overrides.
/// - Follows Sentient Adaptation Guidelines.
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientIcon(
///   icon: Icons.favorite,
/// )
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientIcon(
///   icon: Icons.star,
///   size: 32.0,
///   color: Colors.amber,
/// )
/// ```
class SentientIcon extends StatelessWidget {
  /// The icon to display.
  final IconData icon;

  /// The color to use when drawing the icon.
  ///
  /// If null, this is determined by the active [EmotionTheme] or [IconConfig].
  final Color? color;

  /// The size of the icon in logical pixels.
  ///
  /// If null, this is determined by the active [EmotionTheme] or [IconConfig].
  final double? size;

  /// An optional configuration to override the emotion-based defaults.
  ///
  /// If provided, this configuration is used directly, and the emotion-aware
  /// adaptation decision is disabled (unless `color` or `size` are also provided).
  final IconConfig? configOverride;

  /// Creates a new adaptive icon.
  const SentientIcon({
    super.key,
    required this.icon,
    this.color,
    this.size,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from an override or the current emotion.
    final IconConfig config =
        configOverride ?? emotionTheme.iconConfig;

    return Icon(
      icon,
      color: color ?? config.color,
      size: size ?? config.size,
    );
  }
}
