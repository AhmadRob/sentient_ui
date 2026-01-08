import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

///Defines ScrollView styling for emotional states.
@immutable
class SingleChildScrollViewConfig {
  /// Scroll physics (default: BouncingScrollPhysics)
  final ScrollPhysics physics;

  /// Drag start behavior (default: DragStartBehavior.start)
  final DragStartBehavior dragStartBehavior;

  /// Optional scroll controller
  final ScrollController? controller;

  /// Always show scrollbar or not (helpful in desktop/web)
  final bool showScrollbar;

  const SingleChildScrollViewConfig({
    required this.physics,
    required this.dragStartBehavior,
    this.controller,
    this.showScrollbar = false,
  });

  /// ---- PRESETS ----

  /// Neutral scroll (default)
  static const SingleChildScrollViewConfig neutral = SingleChildScrollViewConfig(
    physics: BouncingScrollPhysics(),
    dragStartBehavior: DragStartBehavior.start,
    controller: null,
    showScrollbar: false,
  );

  /// Smooth scroll (slower)
  static const SingleChildScrollViewConfig smooth = SingleChildScrollViewConfig(
    physics: ClampingScrollPhysics(),
    dragStartBehavior: DragStartBehavior.start,
    controller: null,
    showScrollbar: false,
  );

  /// Fast & responsive scroll
  static const SingleChildScrollViewConfig fast = SingleChildScrollViewConfig(
    physics: AlwaysScrollableScrollPhysics(),
    dragStartBehavior: DragStartBehavior.down,
    controller: null,
    showScrollbar: false,
  );

  /// ---- HELPERS ----

  SingleChildScrollViewConfig copyWith({
    ScrollPhysics? physics,
    DragStartBehavior? dragStartBehavior,
    ScrollController? controller,
    bool? showScrollbar,
  }) {
    return SingleChildScrollViewConfig(
      physics: physics ?? this.physics,
      dragStartBehavior: dragStartBehavior ?? this.dragStartBehavior,
      controller: controller ?? this.controller,
      showScrollbar: showScrollbar ?? this.showScrollbar,
    );
  }
}
