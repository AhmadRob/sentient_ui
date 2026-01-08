import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../foundation/emotion_theme.dart' hide EmotionTheme;

/// A reactive, emotion-aware [Expanded] widget that wraps its child in an
/// adaptive container.
///
/// `SentientExpanded` functions as a drop-in replacement for Flutter's [Expanded]
/// widget but also wraps its [child] in a [Container] whose styling adapts based
/// on the user's emotional state. It leverages the [AdaptationManager] to
/// listen for changes and applies a predefined configuration from [ExpandedConfig].
///
/// This allows for flexible space allocation within a layout while still respecting
/// emotion-driven design principles for padding, color, and shape.
///
/// ## Example Usage
/// ```dart
/// Row(
///   children: [
///     SentientExpanded(
///       child: SentientText('This will expand and adapt!'),
///     ),
///   ],
/// )
/// ```
class SentientExpanded extends StatelessWidget {
  /// The child widget to be expanded and styled within the container.
  final Widget child;

  /// The flex factor to use for this child in a [Row] or [Column].
  ///
  /// Defaults to 1.
  final int flex;

  /// An optional override for the internal padding of the container.
  ///
  /// If not provided, the padding is determined by the active [ExpandedConfig].
  final EdgeInsets? padding;

  /// An optional override for the container's background color.
  ///
  /// If not provided, the color is determined by the active [ExpandedConfig]
  /// or falls back to the theme's `surfaceColor`.
  final Color? color;

  /// An optional override for the container's corner radius.
  final double? borderRadius;

  /// An optional override for the container's box shadow.
  final List<BoxShadow>? boxShadow;

  /// An optional override for the alignment of the child within the container.
  final Alignment? alignment;

  /// Creates a new adaptive `SentientExpanded` widget.
  ///
  /// Its container styling changes based on the current emotional state
  /// defined by the [AdaptationManager].
  const SentientExpanded({
    super.key,
    required this.child,
    this.flex = 1,
    this.padding,
    this.color,
    this.borderRadius,
    this.boxShadow,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Retrieve the container configuration for the current emotion.
    final ExpandedConfig config = emotionTheme.expandedConfig;

    return Expanded(
      flex: flex,
      child: Container(
        padding: padding ?? config.padding,
        alignment: alignment ?? config.alignment,
        decoration: BoxDecoration(
          color: color ?? config.backgroundColor ?? emotionTheme.surfaceColor,
          borderRadius: BorderRadius.circular(borderRadius ?? config.borderRadius),
          boxShadow: boxShadow ?? config.boxShadow,
        ),
        child: child,
      ),
    );
  }
}
