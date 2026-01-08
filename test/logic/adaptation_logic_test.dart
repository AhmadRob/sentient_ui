import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'package:sentient_ui/src/logic/rule_engine.dart';

void main() {
  group('AdaptationManager Logic', () {
    late StateManager stateManager;
    late AdaptationManager adaptationManager;

    setUp(() {
      stateManager = StateManager();
      adaptationManager = AdaptationManager(stateManager);
    });

    test('ensureReadableContrast forces white text on very dark background', () {
      final darkTheme = EmotionTheme.neutral().copyWith(
        surfaceColor: const Color(0xFF050505), // Extremely dark
      );

      final safeTheme = adaptationManager.ensureReadableContrast(darkTheme);

      expect(safeTheme.onSurfaceColor, Colors.white);
      expect(safeTheme.bodyTextStyle.color, Colors.white);
      expect(safeTheme.headingTextStyle.color, Colors.white);
    });

    test('ensureReadableContrast forces black text on very bright background', () {
      final brightTheme = EmotionTheme.neutral().copyWith(
        surfaceColor: const Color(0xFFFAFAFA), // Extremely bright
      );

      final safeTheme = adaptationManager.ensureReadableContrast(brightTheme);

      expect(safeTheme.onSurfaceColor, Colors.black);
      expect(safeTheme.bodyTextStyle.color, Colors.black);
      expect(safeTheme.headingTextStyle.color, Colors.black);
    });

    test('ensureReadableContrast leaves mid-luminance backgrounds alone', () {
      // Gray with luminance around 0.5
      const midColor = Color(0xFF808080);
      final midTheme = EmotionTheme.neutral().copyWith(
        surfaceColor: midColor,
        onSurfaceColor: Colors.blue, // Custom color
      );

      final safeTheme = adaptationManager.ensureReadableContrast(midTheme);

      // Should not have been overridden
      expect(safeTheme.surfaceColor, midColor);
    });
  });
}
