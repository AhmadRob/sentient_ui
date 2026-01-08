import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/sentient_ui.dart';

void main() {
  group('SentientConfig Tests', () {
    test('Defaults are correct', () {
      const config = SentientConfig();
      expect(config.enableEmotionDetection, true);
      expect(config.enableContextSensing, true);
      expect(config.enableBehaviorTracking, true);
      expect(config.captureInterval, const Duration(seconds: 10));
    });

    test('copyWith updates values correctly', () {
      const config = SentientConfig();
      final newConfig = config.copyWith(
        enableEmotionDetection: false,
        captureInterval: const Duration(seconds: 5),
      );

      expect(newConfig.enableEmotionDetection, false);
      expect(newConfig.enableContextSensing, true); // Should remain same
      expect(newConfig.captureInterval, const Duration(seconds: 5));
    });
  });

  group('EmotionTheme Tests', () {
    test('Factory constructors return valid themes', () {
      final happyTheme = EmotionTheme.enjoyment();
      expect(happyTheme.emotionState, EmotionState.enjoyment);
      expect(happyTheme.isPositive, true);
      expect(happyTheme.isNegative, false);

      final sadTheme = EmotionTheme.sadness();
      expect(sadTheme.emotionState, EmotionState.sadness);
      expect(sadTheme.isPositive, false);
      expect(sadTheme.isNegative, true);
    });

    test('Lerp interpolates correctly', () {
      final t1 = EmotionTheme.neutral();
      final t2 = EmotionTheme.anger();

      // At 0.0, should be t1
      final lerp0 = EmotionTheme.lerp(t1, t2, 0.0);
      expect(lerp0.surfaceColor, t1.surfaceColor);

      // At 1.0, should be t2
      final lerp1 = EmotionTheme.lerp(t1, t2, 1.0);
      expect(lerp1.surfaceColor, t2.surfaceColor);
      
      // At 0.5, color should be mixed
      final lerpMid = EmotionTheme.lerp(t1, t2, 0.5);
      expect(
        lerpMid.surfaceColor, 
        Color.lerp(t1.surfaceColor, t2.surfaceColor, 0.5)!
      );
    });
  });

  group('StateManager Tests', () {
    test('Updates trigger listeners', () {
      final manager = StateManager();
      bool notified = false;
      manager.addListener(() {
        notified = true;
      });

      final result = EmotionResult(
        dominantEmotion: EmotionState.enjoyment,
        confidence: 0.9,
        probabilities: {},
        timestamp: DateTime.now(),
      );

      manager.updateEmotion(result);

      expect(notified, true);
      expect(manager.currentEmotion.dominantEmotion, EmotionState.enjoyment);
    });
  });
  
  group('AdaptationManager Tests', () {
    test('Responds to StateManager changes', () {
      final stateManager = StateManager();
      final adaptationManager = AdaptationManager(stateManager);
      
      // Update state
       final result = EmotionResult(
        dominantEmotion: EmotionState.anger,
        confidence: 0.9,
        probabilities: {},
        timestamp: DateTime.now(),
      );
      stateManager.updateEmotion(result);
      
      // AdaptationManager should have updated its theme
      expect(adaptationManager.currentTheme.emotionState, EmotionState.anger);
    });
  });
}
