import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'package:sentient_ui/src/processing/bayesian_filter.dart';

void main() {
  group('BayesianFilter Tests', () {
    late BayesianFilter filter;

    setUp(() {
      filter = BayesianFilter();
    });

    test('Initial state is uniform', () {
      final initialProbs = filter.probabilities;
      final expected = 1.0 / EmotionState.values.length;
      
      for (var prob in initialProbs.values) {
        expect(prob, closeTo(expected, 0.0001));
      }
    });

    test('Single high confidence update shifts currentEmotion', () {
      // Initially neutral (or first in enum)
      // Provide strong evidence for 'enjoyment'
      filter.update({
        EmotionState.enjoyment: 0.9,
        EmotionState.neutral: 0.1,
      });

      expect(filter.currentEmotion, EmotionState.enjoyment);
      expect(filter.probabilities[EmotionState.enjoyment]! > 0.5, true);
    });

    test('Consecutive updates increase confidence', () {
      final evidence = {EmotionState.sadness: 0.8, EmotionState.neutral: 0.2};
      
      filter.update(evidence);
      final firstProb = filter.probabilities[EmotionState.sadness]!;
      
      filter.update(evidence);
      final secondProb = filter.probabilities[EmotionState.sadness]!;
      
      expect(secondProb > firstProb, true);
    });

    test('Conflicting evidence stabilizes distribution', () {
      // Strong enjoyment
      filter.update({EmotionState.enjoyment: 0.9});
      
      // Then strong anger
      filter.update({EmotionState.anger: 0.9});
      
      final probs = filter.probabilities;
      // Both should be significantly higher than others
      expect(
          probs[EmotionState.enjoyment]!,
          closeTo(probs[EmotionState.anger]!, 0.000001),
      );

      expect(probs[EmotionState.enjoyment]! > 0.4, true);
    });

    test('Zero probability update resets the filter', () {
      // Push it to one side
      filter.update({EmotionState.fear: 1.0});
      expect(filter.probabilities[EmotionState.fear], 1.0);

      // Provide impossible evidence (all zero)
      filter.update({});

      // Should be uniform again
      final expected = 1.0 / EmotionState.values.length;
      expect(filter.probabilities[EmotionState.fear], closeTo(expected, 0.0001));
    });
  });
}
