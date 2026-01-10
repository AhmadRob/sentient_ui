import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive draggable scrollable sheet that adapts its behavior and appearance based on the
/// user's emotional state.
///
/// `SentientDraggableScrollableSheet` functions similarly to Flutter's [DraggableScrollableSheet]
/// but introduces emotion-aware sizing, animation, and styling, using values from
/// the active [EmotionTheme] to determine optimal sheet characteristics.
///
/// The widget listens to the [AdaptationManager] automatically and rebuilds
/// when the user's emotional state changes, potentially adjusting sheet behavior.
///
/// ## Features
/// - Emotion-aware sheet sizing and proportions.
/// - Adaptive animation timing and curves.
/// - Dynamic shadow and color effects.
/// - Follows Sentient Adaptation Guidelines for safe interactions.
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientDraggableScrollableSheet(
///   builder: (context, scrollController) {
///     return Container(
///       child: Text('Adaptive sheet content'),
///     );
///   },
/// )
/// ```
///
/// With custom size overrides:
/// ```dart
/// SentientDraggableScrollableSheet(
///   maxChildSize: 0.8,
///   initialChildSize: 0.5,
///   builder: (context, scrollController) {
///     return Container(
///       child: Text('Custom sized sheet'),
///     );
///   },
/// )
/// ```
class SentientDraggableScrollableSheet extends StatelessWidget {
  /// The builder function that creates the sheet content.
  final Widget Function(BuildContext context, ScrollController scrollController) builder;

  /// The maximum size of the sheet (0.0 to 1.0).
  ///
  /// If null, this is determined by the active [EmotionTheme].
  final double? maxChildSize;

  /// The initial size of the sheet when first shown (0.0 to 1.0).
  ///
  /// If null, this is determined by the active [EmotionTheme].
  final double? initialChildSize;

  /// The minimum size of the sheet (0.0 to 1.0).
  ///
  /// If null, this is determined by the active [EmotionTheme].
  final double? minChildSize;

  /// Whether the sheet can be expanded to full screen.
  ///
  /// If null, this is determined by the active [EmotionTheme].
  final bool? expand;

  /// Whether to add a snap-to-size animation.
  final bool snap;

  /// List of snap sizes the sheet can snap to.
  final List<double>? snapSizes;

  /// An optional configuration to override the emotion-based defaults.
  final DraggableScrollableSheetConfig? configOverride;

  /// Creates a new adaptive draggable scrollable sheet.
  const SentientDraggableScrollableSheet({
    super.key,
    required this.builder,
    this.maxChildSize,
    this.initialChildSize,
    this.minChildSize,
    this.expand,
    this.snap = false,
    this.snapSizes,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Get emotion-driven sheet behavior.
    final DraggableScrollableSheetConfig config = configOverride ?? emotionTheme.draggableScrollableSheetConfig;

    return DraggableScrollableSheet(
      maxChildSize: maxChildSize ?? config.maxChildSize,
      initialChildSize: initialChildSize ?? config.initialChildSize,
      minChildSize: minChildSize ?? config.minChildSize,
      expand: expand ?? config.expand,
      snap: snap,
      snapSizes: snapSizes,
      builder: (context, scrollController) {
        return _buildSheetContent(
          context,
          scrollController,
          emotionTheme,
          config,
        );
      },
    );
  }

  /// Builds the sheet content with emotion-aware styling.
  Widget _buildSheetContent(
    BuildContext context,
    ScrollController scrollController,
    EmotionTheme theme,
    DraggableScrollableSheetConfig config,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: theme.surfaceColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(config.borderRadius),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withAlpha(26),
            blurRadius: config.shadowBlur,
            offset: Offset(0, config.shadowOffset),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(config.borderRadius),
        ),
        child: builder(context, scrollController),
      ),
    );
  }
}
