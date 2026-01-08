import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive, emotion-aware stack that allows for overlapping widgets.
///
/// `SentientStack` functions as a drop-in replacement for Flutter's [Stack]
/// but automatically adapts its [alignment] and [fit] based on the user's
/// emotional state. It leverages the [AdaptationManager] to listen for changes
/// and applies a predefined configuration from [StackConfig].
///
/// This widget supports custom overrides for its properties while preserving
/// emotion-driven defaults for any unspecified values.
///
/// ## Example Usage
/// ```dart
/// SentientStack(
///   children: [
///     SentientContainer(width: 200, height: 200),
///     SentientPositioned(top: 10, right: 10, child: Icon(Icons.star)),
///   ],
/// )
/// ```
class SentientStack extends StatelessWidget {
  /// The widgets below this widget in the tree.
  final List<Widget> children;

  /// How to size the non-positioned children in the stack.
  ///
  /// If not provided, the fit is determined by the active [StackConfig].
  final StackFit? fit;

  /// How to align the non-positioned and partially-positioned children in the stack.
  ///
  /// If not provided, the alignment is determined by the active [StackConfig].
  final Alignment? alignment;

  /// An optional configuration to override the emotion-based defaults.
  ///
  /// If provided, this configuration is used directly, and the emotion-aware
  /// adaptation decision is disabled for the overridden properties.
  final StackConfig? configOverride;

  /// Creates a new adaptive `SentientStack`.
  const SentientStack({
    super.key,
    required this.children,
    this.fit,
    this.alignment,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from an override or the current emotion.
    final StackConfig config =
        configOverride ?? emotionTheme.stackConfig;

    return Stack(
      fit: fit ?? config.fit,
      alignment: alignment ?? config.alignment,
      children: children,
    );
  }
}
