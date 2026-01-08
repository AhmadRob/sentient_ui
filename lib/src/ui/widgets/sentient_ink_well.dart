import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../configs/ink_well_config.dart';

/// An emotion-aware [InkWell] wrapper that adapts its interaction
/// feedback based on the current [EmotionTheme].
///
/// This widget dynamically adjusts splash intensity, colors,
/// padding, and border radius according to the user's
/// emotional state, providing a more empathetic interaction
/// experience.
///
/// Commonly used for tappable surfaces such as buttons,
/// list items, and cards within the Sentient UI system.
///
/// ## Features
/// - Emotion-aware interaction feedback (soft for negative, lively for positive).
/// - Dynamic adjustment of splash color and intensity.
/// - Configurable overrides via [InkWellConfig].
/// - Seamless integration with [EmotionTheme].
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientInkWell(
///   onTap: () => print('Tapped'),
///   child: Padding(
///     padding: EdgeInsets.all(16),
///     child: Text('Tap Me'),
///   ),
/// )
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientInkWell(
///   config: InkWellConfig(
///     splashIntensity: 0.8,
///     splashColor: Colors.red,
///   ),
///   onTap: () {},
///   child: Container(...),
/// )
/// ```
class SentientInkWell extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// Called when the user taps this widget.
  ///
  /// If null, the widget will be non-interactive.
  final VoidCallback? onTap;

  /// Optional configuration override.
  ///
  /// When provided, non-null properties override
  /// the emotion-resolved interaction style.
  final InkWellConfig? config;

  /// Creates a [SentientInkWell].
  ///
  /// The [child] argument must not be null.
  /// Use [config] to customize splash behavior
  /// independently from the emotional adaptation.
  const SentientInkWell({
    super.key,
    required this.child,
    this.onTap,
    this.config,
  });

  @override
  Widget build(BuildContext context) {
    // Observe the current emotion-driven theme
    final adaptationManager = context.watch<AdaptationManager>();

    // Active emotion theme
    final theme = adaptationManager.currentTheme;

    // Resolve final interaction configuration
    final resolved = config ?? theme.inkWellConfig;

    return Padding(
      padding: resolved.padding,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(resolved.borderRadius),
        splashColor: _applySplashIntensity(
          resolved.splashColor ?? theme.primaryColor,
          resolved.splashIntensity,
        ),
        highlightColor: _applySplashIntensity(
          resolved.highlightColor ?? theme.secondaryColor,
          resolved.splashIntensity * 0.5,
        ),
        child: child,
      ),
    );
  }

  /// Applies a visual intensity factor to a splash color.
  ///
  /// The [intensity] value is clamped between 0.0 and 1.0
  /// and mapped to the color's opacity.
  Color _applySplashIntensity(Color baseColor, double intensity) {
    return baseColor.withOpacity(intensity.clamp(0.0, 1.0));
  }
}
