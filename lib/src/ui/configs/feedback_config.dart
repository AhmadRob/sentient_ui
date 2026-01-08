import 'package:flutter/material.dart';

/// Defines feedback messaging tone for emotional states.
@immutable
class FeedbackConfig {
  /// Tone of feedback messages
  final FeedbackTone tone;

  /// Example supportive messages for this emotional state
  final List<String> supportiveMessages;

  /// Whether to use sound feedback
  final bool enableSoundFeedback;

  /// Sound intensity level (0.0 - 1.0)
  final double soundIntensity;

  const FeedbackConfig({
    required this.tone,
    required this.supportiveMessages,
    this.enableSoundFeedback = true,
    required this.soundIntensity,
  });
}

enum FeedbackTone { grounding, neutral, encouraging, reassuring, comforting }
