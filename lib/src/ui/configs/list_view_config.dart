import 'package:flutter/material.dart';

/// Defines emotion-aware configuration for SentientListView.
@immutable
class ListViewConfig {
  /// Scroll physics for the ListView
  final ScrollPhysics physics;

  /// Padding inside the ListView
  final EdgeInsets padding;

  /// Optional background color
  final Color? backgroundColor;

  /// Scroll direction (vertical/horizontal)
  final Axis scrollDirection;

  const ListViewConfig({
    required this.physics,
    required this.padding,
    this.backgroundColor,
    this.scrollDirection = Axis.vertical,
  });

  /// Neutral configuration (calm/negative emotions)
  static const ListViewConfig neutral = ListViewConfig(
    physics: BouncingScrollPhysics(),
    padding: EdgeInsets.all(8),
    scrollDirection: Axis.vertical,
    backgroundColor: null,
  );

  /// Soft configuration (sadness)
  static const ListViewConfig soft = ListViewConfig(
    physics: ClampingScrollPhysics(),
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    scrollDirection: Axis.vertical,
    backgroundColor: null,
  );

  /// Lively configuration (enjoyment/surprise)
  static const ListViewConfig lively = ListViewConfig(
    physics: AlwaysScrollableScrollPhysics(),
    padding: EdgeInsets.all(16),
    scrollDirection: Axis.vertical,
    backgroundColor: null,
  );
}
