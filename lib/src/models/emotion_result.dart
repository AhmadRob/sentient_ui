import 'package:flutter/foundation.dart';

import 'emotion_state.dart';

/// Represents the raw output of a single emotion detection analysis cycle.
///
/// This class encapsulates the results from the machine learning model (vision)
/// or the behavioral analysis engine. It contains the primary detected emotion,
/// the confidence score, and the probability distribution across all possible emotions.
@immutable
class EmotionResult {
  /// The emotion with the highest probability score in this result set.
  final EmotionState dominantEmotion;

  /// The confidence score of the [dominantEmotion], typically between 0.0 and 1.0.
  final double confidence;

  /// A map of all supported emotions and their respective probability scores.
  ///
  /// This distribution allows for more nuanced analysis (e.g., detecting "mixed" states).
  final Map<EmotionState, double> probabilities;

  /// The exact time when this detection occurred.
  final DateTime timestamp;

  /// Creates a new [EmotionResult].
  const EmotionResult({
    required this.dominantEmotion,
    required this.confidence,
    required this.probabilities,
    required this.timestamp,
  });

  @override
  String toString() {
    return 'EmotionResult(dominant: $dominantEmotion, confidence: ${confidence.toStringAsFixed(2)}, probabilities: $probabilities, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is EmotionResult &&
        other.dominantEmotion == dominantEmotion &&
        other.confidence == confidence &&
        mapEquals(other.probabilities, probabilities);
  }

  @override
  int get hashCode {
    return dominantEmotion.hashCode ^ confidence.hashCode ^ probabilities.hashCode;
  }
}
