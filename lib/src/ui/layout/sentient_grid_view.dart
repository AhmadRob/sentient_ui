import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive `GridView` that adapts its layout characteristics based on the
/// user's emotional state.
///
/// `SentientGridView` functions as a wrapper for [GridView.count] but automatically
/// adjusts its padding, scroll physics, and grid density based on the active
/// [EmotionTheme] provided by the [AdaptationManager].
///
/// This widget supports custom overrides for its properties while preserving
/// emotion-driven defaults for any unspecified values.
///
/// ## Example Usage
/// ```dart
/// SentientGridView(
///   children: List.generate(20, (i) => SentientContainer()),
/// )
/// ```
class SentientGridView extends StatelessWidget {
  /// The list of widgets to display in the grid.
  final List<Widget> children;

  /// A custom configuration that overrides the emotion-based defaults.
  final GridViewConfig? configOverride;

  /// An optional override for the number of columns in the grid.
  ///
  /// If not provided, the value is determined by the active [GridViewConfig].
  final int? crossAxisCount;

  /// An optional override for the aspect ratio of each grid item.
  ///
  /// If not provided, the value is determined by the active [GridViewConfig].
  final double? childAspectRatio;

  /// An optional override for the padding around the grid.
  final EdgeInsets? padding;

  /// An optional override for the scroll direction.
  final Axis? scrollDirection;

  /// An optional override for the scroll physics.
  ///
  /// If not provided, the physics are determined by the active [GridViewConfig].
  final ScrollPhysics? physics;

  /// Creates a new adaptive `SentientGridView`.
  const SentientGridView({
    super.key,
    required this.children,
    this.configOverride,
    this.crossAxisCount,
    this.childAspectRatio,
    this.padding,
    this.scrollDirection,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from an override or the current emotion.
    final GridViewConfig config =
        configOverride ?? emotionTheme.gridViewConfig;

    return GridView.count(
      padding: padding ?? config.padding,
      scrollDirection: scrollDirection ?? config.scrollDirection,
      physics: physics ?? config.physics,
      crossAxisCount: crossAxisCount ?? config.crossAxisCount,
      childAspectRatio: childAspectRatio ?? config.childAspectRatio,
      children: children,
    );
  }
}
