import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive text field widget that adapts its visual styling based on the
/// user's emotional state.
///
/// `SentientTextField` functions as a drop-in replacement for Flutter's [TextField]
/// but introduces emotion-aware decoration and style adjustments. It automatically
/// rebuilds when the user's emotional state changes via the [AdaptationManager].
///
/// This widget adapts properties like borders, padding, and icons to create an
/// sensing experience that feels appropriate for the current context (e.g., softer
/// for sadness, more dynamic for enjoyment).
///
/// ## Features
/// - Emotion-driven sensing decoration (borders, hints, padding).
/// - Supports custom decoration overrides via [decorationConfig].
/// - Works with standard [TextField] properties like [controller] and [maxLines].
/// - Consistent with Sentient Adaptation Guidelines.
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientTextField(
///   controller: myController,
/// )
/// ```
///
/// With custom configuration override:
/// ```dart
/// SentientTextField(
///   decorationConfig: InputDecorationConfig.lively,
/// )
/// ```
class SentientTextField extends StatelessWidget {
  /// The text editing controller.
  final TextEditingController? controller;

  /// An optional configuration to override the emotion-based defaults.
  ///
  /// If provided, this configuration is used directly, and the emotion-aware
  /// adaptation decision is disabled.
  final InputDecorationConfig? decorationConfig;

  /// Custom text style to apply.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The maximum number of lines for the text field.
  final int? maxLines;

  /// Creates a new adaptive text field.
  const SentientTextField({
    super.key,
    this.controller,
    this.decorationConfig,
    this.style,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from an override or the current emotion.
    final InputDecorationConfig config =
        decorationConfig ?? emotionTheme.inputDecorationConfig;

    return TextField(
      controller: controller,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: config.border,
        hintText: config.hintText,
        hintStyle: config.hintStyle,
        contentPadding: config.contentPadding,
        prefixIcon: config.prefixIcon,
      ),
    );
  }
}
