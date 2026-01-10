import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive, emotion-aware [Row] that wraps its children in an adaptive
/// container.
///
/// `SentientRow` functions as a drop-in replacement for Flutter's [Row] but
/// automatically adapts its container styling (e.g., padding, color, and
/// border radius) based on the user's emotional state. It leverages the
/// [AdaptationManager] to listen for changes and applies a predefined
/// configuration from [RowConfig].
///
/// This widget preserves all standard [Row] layout behaviors while supporting
/// custom overrides for its container properties.
///
/// ## Example Usage
/// ```dart
/// SentientRow(
///   mainAxisAlignment: MainAxisAlignment.spaceBetween,
///   children: [
///     Icon(Icons.home),
///     SentientText('Dashboard'),
///     Icon(Icons.settings),
///   ],
/// )
/// ```
class SentientRow extends StatelessWidget {
  /// The list of widgets to display horizontally within the row.
  final List<Widget> children;

  /// How the children should be placed along the main axis (horizontal).
  ///
  /// Defaults to [MainAxisAlignment.start].
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be aligned along the cross axis (vertical).
  ///
  /// Defaults to [CrossAxisAlignment.center].
  final CrossAxisAlignment crossAxisAlignment;

  /// How much space should be occupied in the main axis.
  ///
  /// Defaults to [MainAxisSize.max].
  final MainAxisSize mainAxisSize;

  /// An optional override for the internal padding of the container.
  ///
  /// If not provided, the padding is determined by the active [RowConfig].
  final EdgeInsets? padding;

  /// An optional override for the container's background color.
  ///
  /// If not provided, the color is determined by the active [RowConfig]
  /// or falls back to the theme's `surfaceColor`.
  final Color? color;

  /// An optional override for the container's corner radius.
  final double? borderRadius;

  /// An optional override for the container's box shadow.
  final List<BoxShadow>? boxShadow;

  /// An optional override for the alignment of the child [Row] within the container.
  final Alignment? alignment;

  /// An optional configuration to override the emotion-based defaults.
  final RowConfig? configOverride;

  /// Creates a new reactive `SentientRow`.
  ///
  /// All container properties are emotion-driven by default but can be overridden
  /// with explicit values.
  const SentientRow({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
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
    // Listen for emotion state changes to rebuild the container adaptively.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Retrieve container configuration based on emotion.
    final RowConfig config = configOverride ?? emotionTheme.rowConfig;

    return Container(
      padding: padding ?? config.padding,
      alignment: alignment ?? config.alignment,
      decoration: BoxDecoration(
        color: color ?? config.backgroundColor ?? emotionTheme.surfaceColor,
        borderRadius: BorderRadius.circular(borderRadius ?? config.borderRadius),
        boxShadow: boxShadow ?? config.boxShadow,
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: children,
      ),
    );
  }
}
