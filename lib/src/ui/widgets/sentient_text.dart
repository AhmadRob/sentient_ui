import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// Defines the text variant type for adaptive styling.
enum TextVariant {
  /// Standard body text - uses [EmotionTheme.bodyTextStyle].
  body,

  /// Heading text - uses [EmotionTheme.headingTextStyle].
  heading,

  /// Caption/secondary text - uses [EmotionTheme.captionTextStyle].
  caption,
}

/// A reactive text widget that automatically adapts its style based on the
/// user's emotional state.
///
/// `SentientText` acts as a drop-in replacement for Flutter's [Text] widget
/// but introduces emotion-aware styling capabilities derived from [EmotionTheme].
///
/// The widget listens to the [AdaptationManager] and rebuilds whenever the
/// emotional state changes, applying the appropriate typography configuration,
/// colors, spacing, and other properties defined in the current [EmotionTheme].
///
/// ## Features
/// - Emotion-aware typography (size, weight, spacing).
/// - Dynamic style adjustments (e.g., wider spacing for anger, italic for sadness).
/// - Specialized variants for body, headings, and captions.
/// - Merges custom styles with adaptive defaults.
///
/// ## Example Usage
///
/// Basic usage with default body text styling:
/// ```dart
/// SentientText('Hello, world!')
/// ```
///
/// Using a heading variant:
/// ```dart
/// SentientText(
///   'Welcome',
///   variant: TextVariant.heading,
/// )
/// ```
///
/// Combining adaptive styling with custom overrides:
/// ```dart
/// SentientText(
///   'Custom text',
///   style: TextStyle(fontWeight: FontWeight.bold),
/// )
/// ```
class SentientText extends StatelessWidget {
  /// The string of text to display.
  final String data;

  /// The text variant to use for emotion-aware styling.
  ///
  /// Determines which [TextStyle] from [EmotionTheme] to apply:
  /// - [TextVariant.body]: Uses [EmotionTheme.bodyTextStyle].
  /// - [TextVariant.heading]: Uses [EmotionTheme.headingTextStyle].
  /// - [TextVariant.caption]: Uses [EmotionTheme.captionTextStyle].
  ///
  /// Defaults to [TextVariant.body].
  final TextVariant variant;

  /// An optional, custom [TextStyle] to apply on top of the adaptive style.
  ///
  /// This style is merged after the emotion-aware style from [EmotionTheme].
  /// Any properties defined here will override the adaptive properties.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Whether the text should break at soft line breaks.
  final bool? softWrap;

  /// Creates a text widget that automatically adapts to the user's emotional state.
  const SentientText(
    this.data, {
    super.key,
    this.variant = TextVariant.body,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
  });

  @override
  Widget build(BuildContext context) {
    // Watch the AdaptationManager to rebuild when emotional state changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Select the base text style from the EmotionTheme based on the variant.
    final TextStyle baseAdaptiveStyle = _getBaseStyleFromTheme(emotionTheme);

    // Merge the custom style on top of the adaptive style.
    final TextStyle finalStyle = style != null
        ? baseAdaptiveStyle.merge(style)
        : baseAdaptiveStyle;

    return Text(
      data,
      style: finalStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  /// Retrieves the appropriate base [TextStyle] from the [EmotionTheme]
  /// based on the selected [variant].
  TextStyle _getBaseStyleFromTheme(EmotionTheme theme) {
    switch (variant) {
      case TextVariant.body:
        return theme.bodyTextStyle;
      case TextVariant.heading:
        return theme.headingTextStyle;
      case TextVariant.caption:
        return theme.captionTextStyle;
    }
  }
}

/// A specialized version of [SentientText] for displaying headings.
///
/// This is a convenience widget that automatically sets [variant] to
/// [TextVariant.heading].
///
/// ## Example
/// ```dart
/// SentientHeading('Welcome Back')
/// ```
class SentientHeading extends StatelessWidget {
  /// The string of text to display.
  final String data;

  /// Custom text style override.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Creates a heading widget.
  const SentientHeading(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return SentientText(
      data,
      variant: TextVariant.heading,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}

/// A specialized version of [SentientText] for displaying captions.
///
/// This is a convenience widget that automatically sets [variant] to
/// [TextVariant.caption].
///
/// ## Example
/// ```dart
/// SentientCaption('Last updated 5 minutes ago')
/// ```
class SentientCaption extends StatelessWidget {
  /// The string of text to display.
  final String data;

  /// Custom text style override.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// How visual overflow should be handled.
  final TextOverflow? overflow;

  /// Creates a caption widget.
  const SentientCaption(
    this.data, {
    super.key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return SentientText(
      data,
      variant: TextVariant.caption,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
