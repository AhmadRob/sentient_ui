import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'package:sentient_ui/src/logic/rule_engine.dart';

/// Unit tests for the [RuleEngine], which handles the conditional logic for UI adaptations.
/// 
/// These tests verify that the framework correctly maps combinations of 
/// Emotional States and Environmental Context to specific UI Theme adjustments.
void main() {
  group('RuleEngine Context-Aware Rules', () {
    late RuleEngine engine;
    late EmotionResult neutralEmotion;
    late ContextResult defaultContext;

    setUp(() {
      engine = RuleEngine.contextAware();
      neutralEmotion = EmotionResult(
        dominantEmotion: EmotionState.neutral,
        confidence: 1.0,
        probabilities: {EmotionState.neutral: 1.0},
        timestamp: DateTime.now(),
      );
      defaultContext = ContextResult(
        timestamp: DateTime.now(),
        isNight: false,
        batteryLevel: 0.8,
        isLowBattery: false,
        isCharging: false,
        isOnline: true,
        networkType: NetworkType.wifi,
        isMoving: false,
        noiseLevel: 0.3,
      );
    });

    /// Verifies that when no specific rules match, the engine falls back to 
    /// the standard theme for the detected emotion.
    test('Default case matches Standard Emotion', () {
      final adaptation = engine.evaluate(neutralEmotion, defaultContext);
      expect(adaptation.theme.emotionState, EmotionState.neutral);
      // Neutral has 0.0 adjustment
      expect(adaptation.theme.brightnessAdjustment, 0.0);
    });

    /// Tests complex rule matching: Sadness detected while it is night time.
    /// Expects a specific "calming/dark" theme override.
    test('Sadness at Night rule triggers', () {
      final sadEmotion = EmotionResult(
        dominantEmotion: EmotionState.sadness,
        confidence: 0.9,
        probabilities: {EmotionState.sadness: 0.9},
        timestamp: DateTime.now(),
      );
      final nightContext = defaultContext.copyWith(isNight: true);

      final adaptation = engine.evaluate(sadEmotion, nightContext);
      
      // Sadness at Night specific markers
      expect(adaptation.theme.surfaceColor, const Color(0xFF121212));
      expect(adaptation.theme.brightnessAdjustment, -0.4);
    });

    /// Verifies that low battery status overrides normal emotional themes 
    /// to apply energy-saving visual adjustments (e.g., pure black background).
    test('Low Battery Saver rule triggers', () {
      final lowBatteryContext = defaultContext.copyWith(isLowBattery: true);
      
      final adaptation = engine.evaluate(neutralEmotion, lowBatteryContext);
      
      // Low Battery specific markers
      expect(adaptation.theme.brightnessAdjustment, -0.5);
      expect(adaptation.theme.surfaceColor, const Color(0xFF000000));
    });

    /// Verifies that environmental context (Night) triggers adjustments 
    /// even for positive emotions like Enjoyment.
    test('General Night Mode triggers for any emotion when night', () {
      final happyEmotion = EmotionResult(
        dominantEmotion: EmotionState.enjoyment,
        confidence: 1.0,
        probabilities: {EmotionState.enjoyment: 1.0},
        timestamp: DateTime.now(),
      );
      final nightContext = defaultContext.copyWith(isNight: true);

      final adaptation = engine.evaluate(happyEmotion, nightContext);
      
      // General Night Mode markers (different from Sadness at Night)
      expect(adaptation.theme.surfaceColor, const Color(0xFF121212));
      expect(adaptation.theme.brightnessAdjustment, -0.3);
    });

    /// Tests safety rules designed to reduce visual intensity during 
    /// high-stress emotional states like Anger.
    test('High Stress Safety triggers for Anger', () {
      final angryEmotion = EmotionResult(
        dominantEmotion: EmotionState.anger,
        confidence: 0.8,
        probabilities: {EmotionState.anger: 0.8},
        timestamp: DateTime.now(),
      );

      final adaptation = engine.evaluate(angryEmotion, defaultContext);
      
      // High Stress specific marker
      expect(adaptation.theme.saturationAdjustment, -0.2);
    });
  });
}

/// Helper extension to simplify context manipulation in tests.
extension ContextResultCopy on ContextResult {
  ContextResult copyWith({
    bool? isNight,
    double? batteryLevel,
    bool? isLowBattery,
    double? noiseLevel,
  }) {
    return ContextResult(
      timestamp: timestamp,
      isNight: isNight ?? this.isNight,
      batteryLevel: batteryLevel ?? this.batteryLevel,
      isLowBattery: isLowBattery ?? this.isLowBattery,
      isCharging: isCharging,
      isOnline: isOnline,
      networkType: networkType,
      isMoving: isMoving,
      noiseLevel: noiseLevel ?? this.noiseLevel,
    );
  }
}
