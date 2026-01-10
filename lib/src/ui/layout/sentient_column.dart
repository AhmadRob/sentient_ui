import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive, emotion-aware column that wraps its children in an adaptive container.
///
/// `SentientColumn` functions as a drop-in replacement for Flutter's [Column]
/// but automatically adapts its container styling (e.g., padding, color, and
/// border radius) based on the user's emotional state. It leverages the
/// [AdaptationManager] to listen for changes and applies a predefined
/// configuration from [ColumnConfig].
///
/// This widget preserves all standard [Column] layout behaviors while supporting
/// custom overrides for its container properties.
///
/// ## Example Usage
/// ```dart
/// SentientColumn(
///   children: [
///     SentientText('This column has adaptive padding!'),
///   ],
/// )
/// ```
class SentientColumn extends StatelessWidget {
  /// The list of widgets to display vertically within the column.
  final List<Widget> children;

  /// How the children should be placed along the main axis (vertical).
  ///
  /// Defaults to [MainAxisAlignment.start].
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be aligned along the cross axis (horizontal).
  ///
  /// Defaults to [CrossAxisAlignment.start].
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space should be occupied in the main axis.
  ///
  /// Defaults to [MainAxisSize.max].
  final MainAxisSize mainAxisSize;

  /// An optional override for the internal padding around the children.
  ///
  /// If not provided, the padding is determined by the active [ColumnConfig].
  final EdgeInsets? padding;

  /// An optional override for the container's background color.
  ///
  /// If not provided, the color is determined by the active [ColumnConfig]
  /// or falls back to the theme's `surfaceColor`.
  final Color? color;

  /// An optional override for the container's corner radius.
  final double? borderRadius;

  /// An optional override for the container's box shadows.
  final List<BoxShadow>? boxShadow;

  /// An optional override for the alignment of the child [Column] within the container.
  final Alignment? alignment;

  /// An optional configuration to override the emotion-based defaults.
  final ColumnConfig? configOverride;

  /// Creates a new reactive `SentientColumn`.
  ///
  /// All container properties (padding, color, borderRadius, boxShadow, and alignment)
  /// are emotion-driven by default but can be overridden with explicit values.
  const SentientColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.padding,
    this.color,
    this.borderRadius,
    this.boxShadow,
    this.alignment,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen to the AdaptationManager to respond to emotion changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Retrieve the appropriate column configuration for the current emotion.
    final ColumnConfig config = configOverride ?? emotionTheme.columnConfig;

    // Wrap the column in a Container to apply padding, color, radius, shadows, etc.
    return Container(
      padding: padding ?? config.padding,
      alignment: alignment ?? config.alignment,
      decoration: BoxDecoration(
        color: color ?? config.backgroundColor ?? emotionTheme.surfaceColor,
        borderRadius: BorderRadius.circular(borderRadius ?? config.borderRadius),
        boxShadow: boxShadow ?? config.boxShadow,
      ),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: children,
      ),
    );
  }
}
