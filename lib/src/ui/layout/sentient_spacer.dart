import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive, emotion-aware spacer that adapts its flexibility based on the
/// user's emotional state.
///
/// `SentientSpacer` functions as a drop-in replacement for Flutter's [Spacer]
/// but automatically adjusts its [flex] value based on the active [EmotionTheme]
/// provided by the [AdaptationManager]. It applies a predefined configuration from
/// [SpacerConfig] to create more or less negative space depending on the emotional context.
///
/// This widget supports a custom [configOverride] to disable emotional adaptation.
///
/// ## Example Usage
/// ```dart
/// Row(
///   children: [
///     Text('Left'),
///     SentientSpacer(), // Adapts space based on emotion
///     Text('Right'),
///   ],
/// )
/// ```
class SentientSpacer extends StatelessWidget {
  /// An optional configuration to override the emotion-based defaults.
  ///
  /// If provided, this configuration is used directly, and the emotion-aware
  /// adaptation decision is disabled.
  final SpacerConfig? configOverride;

  /// Creates a new adaptive `SentientSpacer`.
  const SentientSpacer({super.key, this.configOverride});

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from an override or the current emotion.
    final SpacerConfig config =
        configOverride ?? emotionTheme.spacerConfig;

    return Spacer(flex: config.flex);
  }
}
