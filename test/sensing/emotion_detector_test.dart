import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/src/input/emotion_detector.dart';
import 'package:sentient_ui/sentient_ui.dart';

/// Unit tests for the [EmotionDetector] and its output model [EmotionResult].
/// 
/// These tests verify the data integrity of the emotion detection outputs 
/// and check the robustness of the service initialization.
void main() {
  group('EmotionDetector and EmotionResult Tests', () {
    
    /// Verifies that [EmotionResult] correctly encapsulates the model's 
    /// probability distribution and identifying metadata (timestamp, mode).
    test('EmotionResult properties are set correctly', () {
      final now = DateTime.now();
      final result = EmotionResult(
        dominantEmotion: EmotionState.enjoyment,
        confidence: 0.95,
        probabilities: {
          EmotionState.enjoyment: 0.95,
          EmotionState.surprise: 0.05,
        },
        timestamp: now,
      );

      expect(result.dominantEmotion, EmotionState.enjoyment);
      expect(result.confidence, 0.95);
      expect(result.timestamp, now);
    });

    /// Ensures that value-based equality is correctly implemented for detections.
    /// This is vital for the framework to avoid redundant UI re-paints when 
    /// the emotional state is stable.
    test('EmotionResult equality', () {
      final now = DateTime.now();
      final r1 = EmotionResult(
        dominantEmotion: EmotionState.anger,
        confidence: 0.8,
        probabilities: {EmotionState.anger: 0.8},
        timestamp: now,
      );

      final r2 = EmotionResult(
        dominantEmotion: EmotionState.anger,
        confidence: 0.8,
        probabilities: {EmotionState.anger: 0.8},
        timestamp: now,
      );

      expect(r1, equals(r2));
    });

    /// Verifies the error-handling behavior of the ML service. 
    /// 
    /// Native ML libraries (TFLite) cannot be initialized in a standard 
    /// host-side unit test environment. This test ensures the code handles 
    /// the missing native environment gracefully by throwing an [Exception].
    test('EmotionDetector initialization fails without native library', () async {
      final detector = EmotionDetector();
      // Expect failure when attempting to load bundled TFLite assets on the host machine.
      expect(() => detector.initialize(), throwsA(isA<Exception>()));
    });
  });
}
