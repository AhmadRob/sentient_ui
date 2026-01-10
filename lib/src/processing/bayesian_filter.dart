import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';

import '../models/emotion_state.dart';

/// A Bayesian filter with smoothing for emotion predictions over time.
///
/// This filter maintains a probability distribution over a set of possible emotions
/// and updates these probabilities based on new evidence (emotion measurements).
/// Smoothing ensures that the dominant emotion can shift realistically
/// without being “locked” by past strong priors.
class BayesianFilter {
  // A map to hold the current probability of each emotion state.
  late Map<EmotionState, double> _probabilities;

  // A list of all possible emotion states the filter can handle.
  final List<EmotionState> _emotionStates = EmotionState.values;

  // Small constant to prevent "Zero-locking".
  // Represents the 1% chance the sensor input is noise/incorrect.
  static const double _epsilon = 0.01;

  // Smoothing factor for blending new evidence with prior belief.
  // 0.0 = ignore new evidence, 1.0 = full trust in new evidence.
  final double _alpha = 0.5;

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

  /// Updates the emotion probabilities based on new evidence with smoothing.
  ///
  /// [measuredProbabilities] A map of emotion probabilities from the emotion detector.
  void update(Map<EmotionState, double> measuredProbabilities) {
    // 1. Log the current best guess (Prior)
    final priorEmotion = currentEmotion;
    final priorConf = _probabilities[priorEmotion]!;

    debugPrint('📊 [BayesianFilter] Current beliefs: ${priorEmotion.name}: ${(priorConf * 100).toStringAsFixed(1)}%');

    double totalProbability = 0.0;
    final newProbabilities = <EmotionState, double>{};

    // --- Bayesian update with smoothing ---
    // posterior = alpha * likelihood + (1 - alpha) * prior
    for (final emotion in _emotionStates) {
      final prior = _probabilities[emotion]!;
      final likelihood = (measuredProbabilities[emotion] ?? 0.0) + _epsilon;

      // Apply smoothing to prevent locking
      final posterior = (_alpha * likelihood) + ((1 - _alpha) * prior);

      newProbabilities[emotion] = posterior;
      totalProbability += posterior;
    }

    // --- Normalization Step ---
    if (totalProbability > 0) {
      for (final emotion in _emotionStates) {
        _probabilities[emotion] = newProbabilities[emotion]! / totalProbability;
      }

      // 2. Log the Shift
      final newEmotion = currentEmotion;
      final newConf = _probabilities[newEmotion]!;

      debugPrint('📊 [BayesianFilter] New beliefs: ${newEmotion.name}: ${(newConf * 100).toStringAsFixed(1)}%');

      if (priorEmotion != newEmotion) {
        debugPrint('🔄 [BayesianFilter] State SHIFT: ${priorEmotion.name} → ${newEmotion.name}');
      }

      final sorted = _probabilities.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));
      final top3 = sorted.take(3).map((e) => '${e.key.name}: ${(e.value * 100).toStringAsFixed(1)}%').join(', ');
      debugPrint('📊 [BayesianFilter] Beliefs: $top3');

    } else {
      debugPrint('⚠️ [BayesianFilter] Signal lost, resetting to uniform distribution.');
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
