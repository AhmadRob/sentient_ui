import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/src/input/emotion_detector.dart';
import 'package:sentient_ui/sentient_ui.dart';

void main() {
  group('EmotionDetector and EmotionResult Tests', () {
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

    test('EmotionDetector initialization fails without native library', () async {
      final detector = EmotionDetector();
      // Since this is a unit test on host machine, it will fail to load the TFLite asset/library.
      // We verify that it throws an exception rather than crashing silently.
      expect(() => detector.initialize(), throwsA(isA<Exception>()));
    });
  });
}
