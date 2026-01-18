import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'package:sentient_ui/src/logic/rule_engine.dart';

/// Unit tests for the accessibility and safety logic within the [AdaptationManager].
/// 
/// These tests verify that the framework maintains high usability standards 
/// (like WCAG-compliant contrast) even as the UI adapts to complex 
/// emotional and environmental states.
void main() {
  group('AdaptationManager Logic', () {
    late StateManager stateManager;
    late AdaptationManager adaptationManager;

    setUp(() {
      stateManager = StateManager();
      adaptationManager = AdaptationManager(stateManager);
    });

    /// Verifies the "Safe Contrast" safeguard: When an adaptation results in a 
    /// very dark background, the system must automatically force text and 
    /// icon colors to white to maintain legibility.
    test('ensureReadableContrast forces white text on very dark background', () {
      final darkTheme = EmotionTheme.neutral().copyWith(
        surfaceColor: const Color(0xFF050505), // Extremely dark
      );

      final safeTheme = adaptationManager.ensureReadableContrast(darkTheme);

      expect(safeTheme.onSurfaceColor, Colors.white);
      expect(safeTheme.bodyTextStyle.color, Colors.white);
      expect(safeTheme.headingTextStyle.color, Colors.white);
    });

    /// Verifies the "Safe Contrast" safeguard for bright backgrounds: 
    /// Ensures that light-colored themes automatically use dark text 
    /// to remain readable.
    test('ensureReadableContrast forces black text on very bright background', () {
      final brightTheme = EmotionTheme.neutral().copyWith(
        surfaceColor: const Color(0xFFFAFAFA), // Extremely bright
      );

      final safeTheme = adaptationManager.ensureReadableContrast(brightTheme);

      expect(safeTheme.onSurfaceColor, Colors.black);
      expect(safeTheme.bodyTextStyle.color, Colors.black);
      expect(safeTheme.headingTextStyle.color, Colors.black);
    });
  });
}
