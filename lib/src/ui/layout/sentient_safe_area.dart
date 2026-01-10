import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive widget that applies adaptive padding within the safe area of the screen
/// based on the user's emotional state.
///
/// `SentientSafeArea` functions as a wrapper around Flutter's [SafeArea] and [Padding]
/// widgets. It automatically adjusts its internal padding based on the active
/// [EmotionTheme] provided by the [AdaptationManager], creating more or less
/// breathing room in the UI to align with the emotional context.
///
/// This widget supports a custom `configOverride` to disable emotional adaptation.
///
/// ## Example Usage
/// ```dart
/// SentientSafeArea(
///   child: Scaffold(...),
/// )
/// ```
class SentientSafeArea extends StatelessWidget {
  /// The widget to be rendered within the adaptive safe area.
  final Widget child;

  /// An optional configuration to override the emotion-based defaults.
  ///
  /// If provided, this value is used directly, and the emotion-aware
  /// adaptation decision is disabled.
  final SafeAreaConfig? configOverride;

  /// Creates a new adaptive `SentientSafeArea` widget.
  const SentientSafeArea({
    super.key,
    required this.child,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from an override or the current emotion.
    final SafeAreaConfig config =
        configOverride ?? emotionTheme.safeAreaConfig;

    return SafeArea(
      child: Padding(
        padding: config.padding,
        child: child,
      ),
    );
  }
}
