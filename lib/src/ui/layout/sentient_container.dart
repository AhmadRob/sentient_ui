import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../foundation/emotion_theme.dart';


/// Defines the visual variants that a [SentientContainer] can present.
///
/// Variants allow the container to adapt its structural appearance, such as border
/// radius or shadow, depending on the design context.
enum ContainerVariant {
  /// A standard adaptive container.
  normal,

  /// An elevated, card-like adaptive container.
  card,

  /// A flat, edge-to-edge adaptive container.
  panel,
}

/// A reactive container widget that adapts its visual styling based on the
/// user's emotional state.
///
/// `SentientContainer` is a core building block of the Sentient UI system.
/// It functions similarly to Flutter’s [Container] widget but introduces
/// emotion-aware visual adaptation, using values from the active [EmotionTheme].
///
/// The widget listens to the [AdaptationManager] automatically and rebuilds
/// when the user's emotional state changes.
///
/// ## Features
/// - Emotion-aware colors, shadow intensity, and rounded corners.
/// - Supports custom overrides for color, border, shadows, and radius.
/// - Lightweight and compatible with any child widget.
/// - Configurable via [ContainerConfig].
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientContainer(
///   child: Text('Adaptive box'),
/// )
/// ```
///
/// With a card-style variant:
/// ```dart
/// SentientContainer(
///   variant: ContainerVariant.card,
///   child: Text('Adaptive card'),
/// )
/// ```
class SentientContainer extends StatelessWidget {
  /// The widget to display inside the container.
  final Widget? child;

  /// The visual structure preset for the container.
  ///
  /// Defaults to [ContainerVariant.normal].
  final ContainerVariant variant;

  /// An optional override for the background color.
  ///
  /// If not provided, the color is determined by the active [EmotionTheme]
  /// or [ContainerConfig].
  final Color? color;

  /// An optional override for the container's border radius.
  ///
  /// If null, the radius is determined by the emotional state and variant.
  final double? borderRadius;

  /// The internal padding for the container.
  final EdgeInsetsGeometry? padding;

  /// The external margin for the container.
  final EdgeInsetsGeometry? margin;

  /// An optional override for the container's border.
  final BoxBorder? border;

  /// An optional override for the container's box shadow.
  final List<BoxShadow>? boxShadow;

  /// An optional fixed width for the container.
  final double? width;

  /// An optional fixed height for the container.
  final double? height;

  /// The alignment of the child within the container.
  final AlignmentGeometry? alignment;

  /// An optional configuration to override the emotion-based defaults.
  final ContainerConfig? configOverride;

  /// Creates a new adaptive container.
  ///
  /// Its appearance changes based on the current emotional state defined by the
  /// [AdaptationManager].
  const SentientContainer({
    super.key,
    this.child,
    this.variant = ContainerVariant.normal,
    this.color,
    this.borderRadius,
    this.padding,
    this.margin,
    this.border,
    this.boxShadow,
    this.width,
    this.height,
    this.alignment,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Get the emotion-driven style preset.
    final ContainerConfig config = configOverride ?? emotionTheme.containerConfig;
    final _ContainerStyle style = _resolveStyle(emotionTheme, config);

    return Container(
      width: width,
      height: height,
      alignment: alignment ?? config.alignment,
      padding: padding ?? config.padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? style.color,
        borderRadius: BorderRadius.circular(borderRadius ?? style.borderRadius),
        border: border ?? config.border,
        boxShadow: boxShadow ?? style.boxShadow,
        gradient: config.backgroundGradient,
      ),
      child: child,
    );
  }

  /// Resolves the final container style by combining config, theme, and variant decision.
  _ContainerStyle _resolveStyle(EmotionTheme theme, ContainerConfig config) {
    Color baseColor = config.backgroundColor ?? theme.surfaceColor;
    double radius = config.borderRadius;
    List<BoxShadow>? shadows = [];

    // Construct shadows from config intensity if present
    if (config.shadowIntensity > 0) {
       shadows = [
        BoxShadow(
          color: theme.secondaryColor.withOpacity(config.shadowIntensity),
          blurRadius: config.shadowIntensity * 20,
          offset: Offset(0, config.shadowIntensity * 10),
        )
      ];
    }

    // Apply variant-based structural changes.
    switch (variant) {
      case ContainerVariant.card:
        radius = 12.0;
        break;
      case ContainerVariant.panel:
        radius = 0.0;
        break;
      case ContainerVariant.normal:
        // Use config radius (already set)
        break;
    }

    return _ContainerStyle(
      color: baseColor,
      borderRadius: radius,
      boxShadow: shadows,
    );
  }
}

class _ContainerStyle {
  final Color color;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;

  const _ContainerStyle({
    required this.color,
    required this.borderRadius,
    this.boxShadow,
  });
}
