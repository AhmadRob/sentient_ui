import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/src/processing/normalization_utils.dart';

/// Unit tests for [NormalizationUtils], which provides the mathematical foundation 
/// for data processing in the Sentient UI framework.
/// 
/// These tests verify the accuracy and stability of scaling, clamping, 
/// and probability normalization (softmax) functions.
void main() {
  group('NormalizationUtils Tests', () {
    
    /// Verifies the Min-Max scaling logic used to normalize sensor data 
    /// from varied ranges into a standard [0.0, 1.0] interval.
    test('minMaxScale scales values correctly', () {
      // Scale 5 from [0, 10] to [0, 1]
      expect(
        NormalizationUtils.minMaxScale(5.0, sourceMin: 0.0, sourceMax: 10.0),
        0.5,
      );

      // Scale 0.5 from [0, 1] to [0, 100]
      expect(
        NormalizationUtils.minMaxScale(
            0.5,
            sourceMin: 0.0,
            sourceMax: 1.0,
            targetMin: 0.0,
            targetMax: 100.0,
          ),
        50.0,
      );
    });

    /// Ensures the scaling function handles edge cases where the source range 
    /// is zero (preventing division by zero errors).
    test('minMaxScale handles zero source range', () {
      expect(
        NormalizationUtils.minMaxScale(5, sourceMin: 10, sourceMax: 10, targetMin: 0.2),
        0.2,
      );
    });

    /// Verifies the clamping logic used to keep variables within safe operational bounds.
    test('clamp restricts values to range', () {
      expect(NormalizationUtils.clamp(5, 0, 10), 5);
      expect(NormalizationUtils.clamp(-5, 0, 10), 0);
      expect(NormalizationUtils.clamp(15, 0, 10), 10);
    });

    /// Tests the [softmax] implementation, which is used to convert 
    /// raw ML model output logits into a valid probability distribution.
    test('softmax converts values to probabilities', () {
      final values = [1.0, 2.0, 3.0];
      final probs = NormalizationUtils.softmax(values);

      expect(probs.length, 3);
      // Probabilities must always sum to 1.0.
      expect(probs.reduce((a, b) => a + b), closeTo(1.0, 0.0001));
      // Softmax should preserve the order of the original logits.
      expect(probs[2] > probs[1], true);
      expect(probs[1] > probs[0], true);
    });

    /// Verifies that our softmax implementation includes numerical stability 
    /// optimizations (e.g., using the max-shift trick) to prevent 
    /// exponential overflow with large inputs.
    test('softmax is numerically stable with large values', () {
      final values = [1000.0, 1001.0, 1002.0];
      final probs = NormalizationUtils.softmax(values);
      expect(probs.reduce((a, b) => a + b), closeTo(1.0, 0.0001));
    });

    /// Tests the linear interpolation helper used for smooth visual transitions.
    test('lerpDouble interpolates correctly', () {
      expect(NormalizationUtils.lerpDouble(0, 100, 0.5), 50.0);
      expect(NormalizationUtils.lerpDouble(0, 100, 0.0), 0.0);
      expect(NormalizationUtils.lerpDouble(0, 100, 1.0), 100.0);
    });
  });
}
