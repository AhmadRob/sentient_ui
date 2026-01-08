import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive scroll view that adapts its scrolling physics and behavior based on
/// the user's emotional state.
///
/// `SentientScrollView` functions as a drop-in replacement for Flutter's
/// [SingleChildScrollView] but automatically adjusts its physics, drag behavior,
/// and scrollbar visibility based on the active [EmotionTheme] provided by the
/// [AdaptationManager]. It applies a predefined configuration from [SingleChildScrollViewConfig]
/// to create a scrolling experience that feels natural for the current context.
///
/// This widget supports custom overrides for properties like [physics] and
/// [controller] while preserving emotion-driven defaults for any unspecified values.
///
/// ## Example Usage
/// ```dart
/// SentientScrollView(
///   child: Column(
///     children: List.generate(20, (index) => Text('Item $index')),
///   ),
/// )
/// ```
class SentientSingleChildScrollView extends StatelessWidget {
  /// The widget that scrolls.
  final Widget child;

  /// An optional configuration to override the emotion-based defaults.
  ///
  /// If provided, this configuration takes precedence over the adaptive
  /// behavior derived from [EmotionState].
  final SingleChildScrollViewConfig? config;

  /// An optional override for the scroll physics.
  ///
  /// If provided, this value overrides both the [config] and the emotion-based default.
  final ScrollPhysics? physics;

  /// An optional override for the drag start behavior.
  ///
  /// If provided, this value overrides both the [config] and the emotion-based default.
  final DragStartBehavior? dragStartBehavior;

  /// An optional controller for the scroll view.
  final ScrollController? controller;

  /// Creates a new adaptive `SentientScrollView`.
  const SentientSingleChildScrollView({
    super.key,
    required this.child,
    this.config,
    this.physics,
    this.dragStartBehavior,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Determine the effective configuration (emotion-based or overridden).
    final SingleChildScrollViewConfig finalConfig =
        config ?? emotionTheme.scrollViewConfig;
    final ScrollPhysics finalPhysics = physics ?? finalConfig.physics;
    final DragStartBehavior finalDrag =
        dragStartBehavior ?? finalConfig.dragStartBehavior;
    final ScrollController? finalController =
        controller ?? finalConfig.controller;

    Widget scrollView = SingleChildScrollView(
      physics: finalPhysics,
      dragStartBehavior: finalDrag,
      controller: finalController,
      child: child,
    );

    if (finalConfig.showScrollbar) {
      scrollView = Scrollbar(child: scrollView);
    }

    return scrollView;
  }
}
