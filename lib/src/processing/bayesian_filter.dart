import 'dart:math';
import 'package:sentient_ui/sentient_ui.dart';

import '../models/emotion_state.dart';

/// A Bayesian filter for smoothing emotion predictions over time.
///
/// This filter maintains a probability distribution over a set of possible emotions
/// and updates these probabilities based on new evidence (emotion measurements).
/// This helps to reduce noise and create a more stable emotion reading.
class BayesianFilter {
  // A map to hold the current probability of each emotion state.
  late Map<EmotionState, double> _probabilities;

  // A list of all possible emotion states the filter can handle.
  final List<EmotionState> _emotionStates = EmotionState.values;

  // Small constant to prevent "Zero-locking".
  // Represents the 1% chance the sensor input is noise/incorrect.
  static const double _epsilon = 0.01;

  /// Initializes the filter with a uniform prior distribution.
  BayesianFilter() {
    _reset();
  }

  /// Resets the filter to its initial state (uniform distribution).
  void _reset() {
    final double initialProbability = 1.0 / _emotionStates.length;
    _probabilities = {
      for (var emotion in _emotionStates) emotion: initialProbability
    };
  }

  /// Updates the emotion probabilities based on new evidence.
  ///
  /// [measuredProbabilities] A map of emotion probabilities from the emotion detector.
  void update(Map<EmotionState, double> measuredProbabilities) {
    double totalProbability = 0.0;
    final newProbabilities = <EmotionState, double>{};

    // --- Bayes' Theorem Application ---
    // P(Emotion | Evidence) = P(Evidence | Emotion) * P(Emotion)
    // posterior = (likelihood + epsilon) * prior

    for (final emotion in _emotionStates) {
      final prior = _probabilities[emotion]!;

      // We add _epsilon to the likelihood. This ensures that even if the
      // model reports 0.0 for an emotion, it doesn't get multiplied to absolute zero.
      // This allows the filter to switch between emotions when evidence changes.
      final likelihood = (measuredProbabilities[emotion] ?? 0.0) + _epsilon;

      final posterior = likelihood * prior;

      newProbabilities[emotion] = posterior;
      totalProbability += posterior;
    }

    // --- Normalization Step ---
    if (totalProbability > 0) {
      for (final emotion in _emotionStates) {
        _probabilities[emotion] = newProbabilities[emotion]! / totalProbability;
      }
    } else {
      _reset();
    }
  }

  /// Returns the emotion with the highest current probability.
  EmotionState get currentEmotion {
    return _probabilities.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  /// Returns the full probability distribution.
  Map<EmotionState, double> get probabilities => Map.unmodifiable(_probabilities);
}
