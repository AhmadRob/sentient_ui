import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/sentient_ui.dart';

/// Integration and high-level unit tests for the core classes of the Sentient UI package.
/// 
/// These tests verify the base configuration logic, theme construction, 
/// and the interaction between the StateManager and AdaptationManager.
void main() {
  group('SentientConfig Tests', () {
    /// Verifies that the SentientConfig initializes with safe and expected values.
    test('Defaults are correct', () {
      final config = SentientConfig();
      expect(config.enableEmotionDetection, true);
      expect(config.enableContextSensing, true);
      expect(config.enableBehaviorTracking, true);
      // Default should now be clamped to 30s minimum for stability.
      expect(config.captureInterval, const Duration(seconds: 30));
    });

    /// Ensures that the internal constraint for a minimum 30-second adaptation 
    /// interval is strictly enforced at the constructor level.
    test('captureInterval is clamped to 30s minimum in constructor', () {
      final config = SentientConfig(captureInterval: const Duration(seconds: 10));
      expect(config.captureInterval, const Duration(seconds: 30));
    });

    /// Verifies that the immutability helper (copyWith) also respects 
    /// the minimum interval constraints.
    test('copyWith clamps captureInterval correctly', () {
      final config = SentientConfig();
      final newConfig = config.copyWith(
        enableEmotionDetection: false,
        captureInterval: const Duration(seconds: 5),
      );

      expect(newConfig.enableEmotionDetection, false);
      expect(newConfig.captureInterval, const Duration(seconds: 30));
    });
  });

  group('EmotionTheme Tests', () {
    /// Verifies that each emotion factory correctly sets its identifying [EmotionState].
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

    /// Tests the linear interpolation (lerp) of [EmotionTheme] objects.
    /// This is critical for smooth visual transitions when the user's emotion changes.
    test('Lerp interpolates correctly', () {
      final t1 = EmotionTheme.neutral();
      final t2 = EmotionTheme.anger();

      // At 0.0, the result should be identical to the starting theme.
      final lerp0 = EmotionTheme.lerp(t1, t2, 0.0);
      expect(lerp0.surfaceColor, t1.surfaceColor);

      // At 1.0, the result should be identical to the target theme.
      final lerp1 = EmotionTheme.lerp(t1, t2, 1.0);
      expect(lerp1.surfaceColor, t2.surfaceColor);
      
      // At 0.5, colors and values should be blended.
      final lerpMid = EmotionTheme.lerp(t1, t2, 0.5);
      expect(
        lerpMid.surfaceColor, 
        Color.lerp(t1.surfaceColor, t2.surfaceColor, 0.5)!
      );
    });
  });

  group('StateManager Tests', () {
    /// Verifies that the [StateManager] correctly follows the Observer pattern, 
    /// notifying the system only when a valid emotional update occurs.
    test('Updates trigger listeners', () {
      final manager = StateManager();
      bool notified = false;
      manager.addListener(() {
        notified = true;
      });

      final result = EmotionResult(
        dominantEmotion: EmotionState.enjoyment,
        confidence: 0.9,
        probabilities: {EmotionState.enjoyment: 0.9},
        timestamp: DateTime.now(),
      );

      manager.updateEmotion(result);

      expect(notified, true);
      expect(manager.currentEmotion.dominantEmotion, EmotionState.enjoyment);
    });
  });
  
  group('AdaptationManager Tests', () {
    /// Verifies the reactive link: StateManager changes should immediately 
    /// cause the AdaptationManager to re-evaluate and update the current theme.
    test('Responds to StateManager changes', () {
      final stateManager = StateManager();
      final adaptationManager = AdaptationManager(stateManager);
      
      // Update state to trigger adaptation
       final result = EmotionResult(
        dominantEmotion: EmotionState.anger,
        confidence: 0.9,
        probabilities: {EmotionState.anger: 0.9},
        timestamp: DateTime.now(),
      );
      stateManager.updateEmotion(result);
      
      // AdaptationManager should have updated its internal theme state.
      expect(adaptationManager.currentTheme.emotionState, EmotionState.anger);
    });
  });
}
