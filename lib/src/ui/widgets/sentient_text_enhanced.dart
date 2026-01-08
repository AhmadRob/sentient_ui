import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../configs/text_enhanced_config.dart';
import '../foundation/emotion_theme.dart';

/// An enhanced reactive text widget that adapts its styling based on the
/// user's emotional state with direct [Text] widget attribute mapping.
///
/// `SentientTextEnhanced` is a robust version of the standard `SentientText`, offering
/// more granular control over text properties like directionality and overflow,
/// while maintaining the core emotion-aware styling capabilities.
///
/// The widget listens to the [AdaptationManager] automatically and rebuilds
/// when the user's emotional state changes.
///
/// ## Features
/// - Granular emotion-aware typography (spacing, height, weight).
/// - Dynamic text shadows and effects for high-arousal states.
/// - Adaptive font sizes for better readability in stressed states.
/// - Supports all standard [Text] widget properties.
/// - Configurable via [TextEnhancedConfig].
///
/// ## Example Usage
///
/// ```dart
/// SentientTextEnhanced(
///   'Enhanced adaptive text',
///   style: TextStyle(fontSize: 18),
///   textAlign: TextAlign.center,
/// )
/// ```
class SentientTextEnhanced extends StatelessWidget {
  /// The string of text to display.
  final String text;

  /// An optional, custom [TextStyle] to apply on top of the adaptive style.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// The directionality of the text.
  final TextDirection? textDirection;

  /// An optional configuration to override the emotion-based defaults.
  final TextEnhancedConfig? configOverride;

  /// Creates a new enhanced adaptive text widget.
  const SentientTextEnhanced(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Watch for emotional changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Get base emotion style and merge with custom style.
    final TextEnhancedConfig config = configOverride ?? emotionTheme.textEnhancedConfig;
    final TextStyle emotionStyle = _applyConfigToStyle(emotionTheme.bodyTextStyle, config);
    final TextStyle finalStyle = style != null ? emotionStyle.merge(style!) : emotionStyle;

    return AnimatedDefaultTextStyle(
      style: finalStyle,
      duration: emotionTheme.animation.transitionDuration,
      curve: emotionTheme.animation.animationCurve,
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
        textDirection: textDirection,
      ),
    );
  }

  TextStyle _applyConfigToStyle(TextStyle base, TextEnhancedConfig config) {
    return base.copyWith(
      fontSize: (base.fontSize ?? 14.0) * config.fontSizeMultiplier,
      letterSpacing: (base.letterSpacing ?? 0.0) + config.letterSpacingAdder,
      height: config.height,
      wordSpacing: config.wordSpacing,
      fontWeight: config.fontWeight,
      shadows: config.shadows,
      fontStyle: config.fontStyle,
    );
  }
}

/// A specialized enhanced heading widget that adapts to emotional states.
///
/// `SentientHeadingEnhanced` applies heavier weights and stronger visual treatments
/// appropriate for headings, while respecting the current emotional context.
///
/// ## Example Usage
/// ```dart
/// SentientHeadingEnhanced(
///   'Big Headline',
///   textAlign: TextAlign.center,
/// )
/// ```
class SentientHeadingEnhanced extends StatelessWidget {
  /// The string of text to display.
  final String text;

  /// Custom text style override.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// An optional configuration to override the emotion-based defaults.
  final TextEnhancedConfig? configOverride;

  /// Creates a new enhanced adaptive heading.
  const SentientHeadingEnhanced(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;
    
    final TextEnhancedConfig config = configOverride ?? emotionTheme.textEnhancedConfig;
    // Apply config to heading text style
    final TextStyle emotionStyle = _applyConfigToStyle(emotionTheme.headingTextStyle, config);
    final TextStyle finalStyle = style != null ? emotionStyle.merge(style!) : emotionStyle;

    return AnimatedDefaultTextStyle(
      style: finalStyle,
      duration: emotionTheme.animation.transitionDuration,
      curve: emotionTheme.animation.animationCurve,
      child: Text(text, textAlign: textAlign, maxLines: maxLines, overflow: overflow),
    );
  }

  TextStyle _applyConfigToStyle(TextStyle base, TextEnhancedConfig config) {
    return base.copyWith(
      fontSize: (base.fontSize ?? 24.0) * config.fontSizeMultiplier,
      letterSpacing: (base.letterSpacing ?? 0.0) + config.letterSpacingAdder,
      // Headings might use slightly different application of weights, 
      // but for consistency we apply config. However, config.fontWeight 
      // is usually designed for body text context in some configs.
      // Ideally TextEnhancedConfig would have variants or we rely on the fact 
      // that high arousal states increase weight for both.
      fontWeight: config.fontWeight.index > base.fontWeight!.index ? config.fontWeight : base.fontWeight,
      shadows: config.shadows,
      fontStyle: config.fontStyle,
    );
  }
}

/// A specialized enhanced caption widget that adapts to emotional states.
///
/// `SentientCaptionEnhanced` provides subtle, context-aware styling suitable
/// for secondary information, footnotes, or labels.
///
/// ## Example Usage
/// ```dart
/// SentientCaptionEnhanced('Last updated just now')
/// ```
class SentientCaptionEnhanced extends StatelessWidget {
  /// The string of text to display.
  final String text;

  /// Custom text style override.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// An optional configuration to override the emotion-based defaults.
  final TextEnhancedConfig? configOverride;

  /// Creates a new enhanced adaptive caption.
  const SentientCaptionEnhanced(
    this.text, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;
    
    final TextEnhancedConfig config = configOverride ?? emotionTheme.textEnhancedConfig;
    final TextStyle emotionStyle = _applyConfigToStyle(emotionTheme.captionTextStyle, config);
    final TextStyle finalStyle = style != null ? emotionStyle.merge(style!) : emotionStyle;

    return AnimatedDefaultTextStyle(
      style: finalStyle,
      duration: emotionTheme.animation.transitionDuration,
      curve: emotionTheme.animation.animationCurve,
      child: Text(text, textAlign: textAlign, maxLines: maxLines, overflow: overflow),
    );
  }

  TextStyle _applyConfigToStyle(TextStyle base, TextEnhancedConfig config) {
    return base.copyWith(
      // Caption usually doesn't scale as much, but we apply the multiplier
      fontSize: (base.fontSize ?? 12.0) * config.fontSizeMultiplier,
      letterSpacing: (base.letterSpacing ?? 0.0) + config.letterSpacingAdder,
      fontStyle: config.fontStyle,
      // Captions might use lighter colors or specific opacities handled by theme.captionTextStyle
      // We don't override color here from config (config doesn't have color).
    );
  }
}
