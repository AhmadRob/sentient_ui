import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'package:sentient_ui/src/logic/rule_engine.dart';

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

    test('Default case matches Standard Emotion', () {
      final adaptation = engine.evaluate(neutralEmotion, defaultContext);
      expect(adaptation.theme.emotionState, EmotionState.neutral);
      // Neutral has 0.0 adjustment
      expect(adaptation.theme.brightnessAdjustment, 0.0);
    });

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

    test('High Noise Environment rule triggers', () {
      final noisyContext = defaultContext.copyWith(noiseLevel: 0.85);
      
      final adaptation = engine.evaluate(neutralEmotion, noisyContext);
      
      // High Noise specific markers
      expect(adaptation.theme.animation, AnimationConfig.minimal);
      expect(adaptation.theme.surfaceColor, const Color(0xFF111111));
    });

    test('Low Battery Saver rule triggers', () {
      final lowBatteryContext = defaultContext.copyWith(isLowBattery: true);
      
      final adaptation = engine.evaluate(neutralEmotion, lowBatteryContext);
      
      // Low Battery specific markers
      expect(adaptation.theme.brightnessAdjustment, -0.5);
      expect(adaptation.theme.surfaceColor, const Color(0xFF000000));
    });

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
