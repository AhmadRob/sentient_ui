import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../../models/emotion_state.dart';

/// A reactive animated switcher that adapts its transition behavior based on the
/// user's emotional state.
///
/// `SentientAnimatedSwitcher` functions as a drop-in replacement for Flutter's
/// [AnimatedSwitcher] but automatically adjusts its [duration], [switchInCurve],
/// and [switchOutCurve] based on the active [EmotionTheme] provided by the
/// [AdaptationManager]. It applies a predefined configuration from
/// [AnimatedSwitcherConfig].
///
/// This widget ensures that layout transitions feel consistent with the emotional
/// context—smooth and slow for sadness, snappy and bouncy for enjoyment.
///
/// ## Example Usage
/// ```dart
/// SentientAnimatedSwitcher(
///   child: _showFirstWidget ? FirstWidget() : SecondWidget(),
/// )
/// ```
class SentientAnimatedSwitcher extends StatelessWidget {
  /// The widget to display.
  ///
  /// The widget should have a distinct [Key] to trigger the animation when it changes.
  final Widget child;

  /// An optional configuration to override the emotion-based defaults.
  ///
  /// If provided, this configuration is used directly, and the emotion-aware
  /// adaptation decision is disabled.
  final AnimatedSwitcherConfig? configOverride;

  /// Creates a new adaptive `SentientAnimatedSwitcher`.
  const SentientAnimatedSwitcher({
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
    final AnimatedSwitcherConfig config =
        configOverride ?? _getConfigForEmotion(emotionTheme);

    return AnimatedSwitcher(
      duration: config.duration,
      switchInCurve: config.switchInCurve,
      switchOutCurve: config.switchOutCurve,
      child: child,
    );
  }

  /// Returns the appropriate [AnimatedSwitcherConfig] for the given [EmotionTheme].
  ///
  /// This method maps emotional states to specific animation presets:
  /// - [EmotionState.sadness] → `soft` (slower, gentler curves).
  /// - [EmotionState.enjoyment], [EmotionState.surprise] → `lively` (faster, playful curves).
  /// - All other states → `neutral` (standard speed and smoothness).
  AnimatedSwitcherConfig _getConfigForEmotion(EmotionTheme theme) {
    switch (theme.emotionState) {
      case EmotionState.sadness:
        return AnimatedSwitcherConfig.soft;

      case EmotionState.enjoyment:
      case EmotionState.surprise:
        return AnimatedSwitcherConfig.lively;

      case EmotionState.anger:
      case EmotionState.fear:
      case EmotionState.disgust:
      default:
        return AnimatedSwitcherConfig.neutral;
    }
  }
}
