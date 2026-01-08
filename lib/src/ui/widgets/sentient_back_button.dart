import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../configs/back_button_config.dart';

/// An emotion-aware back navigation button.
///
/// This widget adapts its visual prominence (color, opacity,
/// and padding) based on the current [EmotionTheme],
/// providing calm and predictable navigation feedback
/// during negative emotional states, while allowing
/// more expressive styling during positive emotions.
///
/// Typically used in app bars or custom navigation layouts
/// within the Sentient UI system.
///
/// ## Features
/// - Emotion-aware prominence (calm for negative, expressive for positive).
/// - Dynamic adjustment of color and opacity.
/// - Configurable overrides via [BackButtonConfig].
/// - Seamless integration with [EmotionTheme].
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientBackButton()
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientBackButton(
///   color: Colors.white,
///   config: BackButtonConfig(
///     opacity: 0.8,
///   ),
/// )
/// ```
class SentientBackButton extends StatelessWidget {
  /// Optional explicit color override.
  ///
  /// When provided, this color takes precedence over
  /// emotion-resolved and theme-based colors.
  final Color? color;

  /// Optional configuration override.
  ///
  /// Non-null properties override the emotion-resolved
  /// back button configuration.
  final BackButtonConfig? config;

  /// Creates a [SentientBackButton].
  const SentientBackButton({
    super.key,
    this.color,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    // Observe emotion-driven navigation adaptations
    final adaptationManager = context.watch<AdaptationManager>();

    // Current emotion-aware theme
    final theme = adaptationManager.currentTheme;

    // Resolve final back button configuration
    final resolved = config ?? theme.backButtonConfig;

    // Determine effective icon color
    final effectiveColor =
        color ??
            resolved.color ??
            theme.primaryColor.withOpacity(resolved.opacity);

    return Padding(
      padding: resolved.padding,
      child: BackButton(
        color: effectiveColor,
        onPressed: () => Navigator.maybePop(context),
      ),
    );
  }
}
