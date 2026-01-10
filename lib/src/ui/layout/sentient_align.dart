import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive, emotion-aware alignment widget.
///
/// `SentientAlign` functions similarly to Flutter's [Align] widget but adapts its
/// alignment properties based on the user's emotional state. It leverages the
/// [AdaptationManager] to listen for changes in emotion and applies a predefined
/// configuration from [AlignConfig].
///
/// This widget supports custom overrides via [configOverride] while preserving
/// emotion-driven defaults for standard states.
class SentientAlign extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// Optional configuration to override the emotion-based defaults.
  final AlignConfig? configOverride;

  /// Creates a new emotion-aware alignment widget.
  const SentientAlign({
    super.key,
    required this.child,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    final AlignConfig config =
        configOverride ?? emotionTheme.alignConfig;

    return Align(
      alignment: config.alignment,
      child: child,
    );
  }
}
