import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive `ListView` that adapts its scroll behavior, padding, and
/// background color based on the user's emotional state.
///
/// `SentientListView` functions as a drop-in replacement for Flutter's [ListView]
/// but automatically adjusts its styling based on the active [EmotionTheme]
/// provided by the [AdaptationManager]. It applies a predefined configuration from
/// [ListViewConfig] to modify its appearance and feel.
///
/// This widget supports custom overrides for its properties while preserving
/// emotion-driven defaults for any unspecified values.
///
/// ## Example Usage
/// ```dart
/// SentientListView(
///   children: List.generate(20, (i) => SentientListTile(title: Text('Item $i'))),
/// )
/// ```
class SentientListView extends StatelessWidget {
  /// The list of widgets to display in the scrollable list.
  final List<Widget> children;

  /// An optional override for the scroll direction of the list.
  ///
  /// If not provided, the value is determined by the active [ListViewConfig].
  final Axis? scrollDirection;

  /// An optional override for the scroll physics.
  ///
  /// If not provided, the physics are determined by the active [ListViewConfig].
  final ScrollPhysics? physics;

  /// An optional override for the internal padding of the list.
  final EdgeInsets? padding;

  /// An optional override for the background color of the list area.
  final Color? backgroundColor;

  /// Creates a new adaptive `SentientListView`.
  const SentientListView({
    super.key,
    required this.children,
    this.scrollDirection,
    this.physics,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from the current emotion.
    final ListViewConfig config = emotionTheme.listViewConfig;

    // The ListView is wrapped in a Container to support adaptive background color.
    return Container(
      color: backgroundColor ?? config.backgroundColor,
      child: ListView(
        scrollDirection: scrollDirection ?? config.scrollDirection,
        physics: physics ?? config.physics,
        padding: padding ?? config.padding,
        children: children,
      ),
    );
  }
}
