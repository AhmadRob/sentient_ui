import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../foundation/emotion_theme.dart';

/// A reactive text button widget that adapts its styling based on the
/// user's emotional state.
///
/// `SentientTextButton` functions similarly to Flutter's [TextButton] widget
/// but introduces emotion-aware styling, using values from the active
/// [EmotionTheme] to determine optimal colors, typography, and interaction behavior.
///
/// The widget listens to the [AdaptationManager] automatically and rebuilds
/// when the user's emotional state changes, allowing for dynamic adjustments
/// to button appearance.
///
/// ## Features
/// - Emotion-aware colors and typography.
/// - Adaptive padding and border radius.
/// - Dynamic hover and press effects.
/// - Follows Sentient Adaptation Guidelines for consistent interaction.
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientTextButton(
///   onPressed: () => print('Pressed'),
///   child: Text('Adaptive button'),
/// )
/// ```
///
/// With custom style override:
/// ```dart
/// SentientTextButton(
///   onPressed: () => print('Pressed'),
///   style: ButtonStyle(
///     backgroundColor: MaterialStateProperty.all(Colors.blue),
///   ),
///   child: Text('Custom button'),
/// )
/// ```
class SentientTextButton extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// Called when the button is pressed.
  final VoidCallback? onPressed;

  /// Called when the button is long-pressed.
  final VoidCallback? onLongPress;

  /// Custom button style override (null = use emotion-based style).
  final ButtonStyle? style;

  /// Whether the button is enabled.
  final bool enabled;

  /// An optional configuration to override the emotion-based defaults.
  final TextButtonConfig? configOverride;

  /// Creates a new adaptive text button.
  const SentientTextButton({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.style,
    this.enabled = true,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Get emotion-driven button style.
    final TextButtonConfig config = configOverride ?? emotionTheme.textButtonConfig;
    final emotionStyle = _createButtonStyle(config);

    // Merge custom style with emotion style (custom takes precedence)
    final finalStyle = style != null
        ? _mergeButtonStyles(emotionStyle, style!)
        : emotionStyle;

    return AnimatedContainer(
      duration: emotionTheme.animation.microInteractionDuration,
      curve: emotionTheme.animation.animationCurve,
      child: TextButton(
        onPressed: enabled ? onPressed : null,
        onLongPress: enabled ? onLongPress : null,
        style: finalStyle,
        child: _buildChild(emotionTheme, config),
      ),
    );
  }

  /// Builds the child widget with emotion-aware styling.
  Widget _buildChild(EmotionTheme theme, TextButtonConfig config) {
    // Use the fontWeight/letterSpacing from config, but colors from foregroundColor
    final style = theme.bodyTextStyle.copyWith(
      color: config.foregroundColor,
      fontWeight: config.fontWeight,
      letterSpacing: config.letterSpacing,
    );

    if (child is Text) {
      final text = child as Text;
      return DefaultTextStyle(
        style: style,
        child: text,
      );
    }

    return DefaultTextStyle(
      style: style,
      child: child,
    );
  }

  ButtonStyle _createButtonStyle(TextButtonConfig config) {
    return TextButton.styleFrom(
      backgroundColor: config.backgroundColor,
      foregroundColor: config.foregroundColor,
      padding: config.padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(config.borderRadius),
      ),
    ).copyWith(
      overlayColor: MaterialStateProperty.all(config.overlayColor),
    );
  }

  /// Merges emotion-based style with custom style, giving precedence to custom style.
  ButtonStyle _mergeButtonStyles(ButtonStyle emotionStyle, ButtonStyle customStyle) {
    return ButtonStyle(
      backgroundColor: customStyle.backgroundColor ?? emotionStyle.backgroundColor,
      foregroundColor: customStyle.foregroundColor ?? emotionStyle.foregroundColor,
      overlayColor: customStyle.overlayColor ?? emotionStyle.overlayColor,
      shadowColor: customStyle.shadowColor ?? emotionStyle.shadowColor,
      surfaceTintColor: customStyle.surfaceTintColor ?? emotionStyle.surfaceTintColor,
      elevation: customStyle.elevation ?? emotionStyle.elevation,
      padding: customStyle.padding ?? emotionStyle.padding,
      minimumSize: customStyle.minimumSize ?? emotionStyle.minimumSize,
      fixedSize: customStyle.fixedSize ?? emotionStyle.fixedSize,
      maximumSize: customStyle.maximumSize ?? emotionStyle.maximumSize,
      side: customStyle.side ?? emotionStyle.side,
      shape: customStyle.shape ?? emotionStyle.shape,
      mouseCursor: customStyle.mouseCursor ?? emotionStyle.mouseCursor,
      visualDensity: customStyle.visualDensity ?? emotionStyle.visualDensity,
      tapTargetSize: customStyle.tapTargetSize ?? emotionStyle.tapTargetSize,
      animationDuration: customStyle.animationDuration ?? emotionStyle.animationDuration,
      enableFeedback: customStyle.enableFeedback ?? emotionStyle.enableFeedback,
      alignment: customStyle.alignment ?? emotionStyle.alignment,
      splashFactory: customStyle.splashFactory ?? emotionStyle.splashFactory,
    );
  }
}
