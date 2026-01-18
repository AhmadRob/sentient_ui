import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'package:sentient_ui/src/processing/bayesian_filter.dart';

/// Unit tests for the [BayesianFilter], which provides temporal smoothing 
/// for emotion detections.
/// 
/// These tests verify the mathematical consistency of the probability updates 
/// and ensure that the filter correctly accumulates evidence over time to 
/// provide a stable "belief" about the user's emotional state.
void main() {
  group('BayesianFilter Tests', () {
    late BayesianFilter filter;

    setUp(() {
      filter = BayesianFilter();
    });

    /// Ensures the filter starts with a "Uniform Prior", meaning all emotions 
    /// are considered equally likely until the first piece of evidence is received.
    test('Initial state is uniform', () {
      final initialProbs = filter.probabilities;
      final expected = 1.0 / EmotionState.values.length;
      
      for (var prob in initialProbs.values) {
        expect(prob, closeTo(expected, 0.0001));
      }
    });

    /// Verifies that a single piece of high-confidence evidence is enough to 
    /// shift the dominant "belief" of the filter.
    test('Single high confidence update shifts currentEmotion', () {
      // Provide strong evidence for 'enjoyment'
      filter.update({
        EmotionState.enjoyment: 0.9,
        EmotionState.neutral: 0.1,
      });

      expect(filter.currentEmotion, EmotionState.enjoyment);
      expect(filter.probabilities[EmotionState.enjoyment]! > 0.5, true);
    });

    /// Tests the accumulation of evidence: repeating the same observation 
    /// should mathematically increase the filter's confidence in that state.
    test('Consecutive updates increase confidence', () {
      final evidence = {EmotionState.sadness: 0.8, EmotionState.neutral: 0.2};
      
      filter.update(evidence);
      final firstProb = filter.probabilities[EmotionState.sadness]!;
      
      filter.update(evidence);
      final secondProb = filter.probabilities[EmotionState.sadness]!;
      
      // The posterior probability should increase after the second confirming sample.
      expect(secondProb > firstProb, true);
    });
  });
}
