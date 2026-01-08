import 'package:flutter/material.dart';

import '../../sentient_ui.dart';

/// A data model representing a detected behavioral pattern.
@immutable
class BehavioralEmotionResult {
  final EmotionState detectedEmotion;
  final double confidence;
  final String reason;

  const BehavioralEmotionResult({
    required this.detectedEmotion,
    required this.confidence,
    required this.reason,
  });
}