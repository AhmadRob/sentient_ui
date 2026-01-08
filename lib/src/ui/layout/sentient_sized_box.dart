import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive, emotion-aware box that enforces specific dimensions based on the
/// user's emotional state.
///
/// `SentientSizedBox` functions as a drop-in replacement for Flutter's [SizedBox]
/// but automatically adjusts its width and height based on the active [EmotionTheme]
/// provided by the [AdaptationManager]. It applies a predefined configuration from
/// [SizedBoxConfig] to enforce consistent spacing or sizing rules that align with
/// the emotional context.
///
/// This widget supports custom overrides for [width] and [height] while preserving
/// emotion-driven defaults for any unspecified values.
///
/// ## Example Usage
///
/// As a spacer:
/// ```dart
/// SentientSizedBox()
/// ```
///
/// Wrapping a child with adaptive dimensions:
/// ```dart
/// SentientSizedBox(
///   child: MyWidget(),
/// )
/// ```
class SentientSizedBox extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget? child;

  /// If non-null, requires the child to have exactly this width.
  ///
  /// If null, the width is determined by the active [SizedBoxConfig].
  final double? width;

  /// If non-null, requires the child to have exactly this height.
  ///
  /// If null, the height is determined by the active [SizedBoxConfig].
  final double? height;

  /// Creates a new adaptive `SentientSizedBox`.
  const SentientSizedBox({
    super.key,
    this.child,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from the current emotion.
    final SizedBoxConfig config = emotionTheme.sizedBoxConfig;

    return SizedBox(
      width: width ?? config.width,
      height: height ?? config.height,
      child: child,
    );
  }
}
