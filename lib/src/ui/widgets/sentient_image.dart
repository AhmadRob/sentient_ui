import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive image widget that adapts its appearance based on the
/// user's emotional state.
///
/// `SentientImage` functions as a wrapper around Flutter's [Image.asset]
/// but introduces emotion-aware styling. It uses values from the active
/// [EmotionTheme] or a provided [ImageConfig] to determine properties like
/// border radius and color filtering.
///
/// The widget listens to the [AdaptationManager] automatically and rebuilds
/// when the user's emotional state changes.
///
/// ## Features
/// - Emotion-aware border radius (e.g., softer corners for sadness).
/// - Adaptive color filtering (e.g., subtle overlay for anger).
/// - Supports custom configuration overrides.
/// - Follows Sentient Adaptation Guidelines.
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientImage(
///   path: 'assets/images/photo.jpg',
/// )
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientImage(
///   path: 'assets/images/photo.jpg',
///   borderRadius: 16.0,
/// )
/// ```
class SentientImage extends StatelessWidget {
  /// The asset path of the image.
  final String path;

  /// An optional override for the corner radius.
  ///
  /// If null, this is determined by the active [EmotionTheme] or [ImageConfig].
  final double? borderRadius;

  /// An optional configuration to override the emotion-based defaults.
  ///
  /// If provided, this configuration is used directly, and the emotion-aware
  /// adaptation decision is disabled (unless `borderRadius` is also provided).
  final ImageConfig? configOverride;

  /// How to inscribe the image into the space allocated during layout.
  final BoxFit? fit;

  /// Creates a new adaptive image widget.
  const SentientImage({
    super.key,
    required this.path,
    this.borderRadius,
    this.configOverride,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from an override or the current emotion.
    final ImageConfig config =
        configOverride ?? emotionTheme.imageConfig;

    Widget image = Image.asset(
      path,
      color: config.colorFilter,
      colorBlendMode: config.colorFilter != null ? BlendMode.srcATop : null,
      fit: fit ?? BoxFit.cover,
    );

    // Apply corner radius if any
    final effectiveRadius = borderRadius ?? config.borderRadius;
    if (effectiveRadius > 0) {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(effectiveRadius),
        child: image,
      );
    }

    return image;
  }
}
