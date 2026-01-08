import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'package:sentient_ui/src/logic/rule_engine.dart';

import '../input/context_manager.dart';

/// Manages the application's UI adaptations in response to emotional state changes.
///
/// This class acts as a bridge between the [StateManager] (which holds the user's
/// current emotion) and the UI. It listens for emotion changes and uses a
/// rule-based system to select an appropriate [EmotionTheme] to apply.
///
/// This is a [ChangeNotifier], allowing widgets to subscribe to theme changes.
class AdaptationManager extends ChangeNotifier {
  final StateManager _stateManager;
  final ContextManager _contextManager = ContextManager(); // Singleton instance
  
  // Use the context-aware rule engine
  final RuleEngine ruleEngine = RuleEngine.contextAware();

  // The current theme, initialized to the theme for the 'neutral' state.
  EmotionTheme _currentTheme = EmotionTheme.neutral();

  /// The active [EmotionTheme] that the UI should be using.
  EmotionTheme get currentTheme => _currentTheme;

  AdaptationManager(this._stateManager) {
    // Start listening to the StateManager as soon as this manager is created.
    _stateManager.addListener(_onStateChanged);
    
    // Also listen to context changes (e.g., Night Mode, Battery)
    _contextManager.addListener(_onStateChanged);

    // Initialize the theme based on the current emotion and context.
    _updateTheme();
  }

  /// The listener that is called whenever the emotional state OR context changes.
  void _onStateChanged() {
    _updateTheme();
  }

  void _updateTheme() {
    final emotionResult = _stateManager.currentEmotion;
    final contextResult = _contextManager.currentState.result;

    final adaptation = ruleEngine.evaluate(emotionResult, contextResult);

    final safeTheme = ensureReadableContrast(adaptation.theme);

    // Only update and notify if the theme actually changed.
    if (_currentTheme != safeTheme) {
      _currentTheme = safeTheme;
      notifyListeners();
    }
  }

  /// Ensures that text remains readable by checking the contrast against the surface color.
  /// 
  /// If the surface is too dark, it forces text and icons to a light color.
  /// If the surface is too bright, it forces them to a dark color.
  /// 
  /// This method uses .copyWith() on existing styles to preserve typography properties 
  /// (like fontSize and fontWeight) while only overriding the color.
  EmotionTheme ensureReadableContrast(EmotionTheme theme) {
    final surfaceLuminance = theme.surfaceColor.computeLuminance();

    // If background is dark → force light text
    if (surfaceLuminance < 0.25) {
      return theme.copyWith(
        onSurfaceColor: Colors.white,
        bodyTextStyle: theme.bodyTextStyle.copyWith(color: Colors.white),
        headingTextStyle: theme.headingTextStyle.copyWith(color: Colors.white),
        captionTextStyle: theme.captionTextStyle.copyWith(color: const Color(0xFFB0B0B0)),
        iconColor: Colors.white,
      );
    }

    // If background is bright → force dark text
    if (surfaceLuminance > 0.8) {
      return theme.copyWith(
        onSurfaceColor: Colors.black,
        bodyTextStyle: theme.bodyTextStyle.copyWith(color: Colors.black),
        headingTextStyle: theme.headingTextStyle.copyWith(color: Colors.black),
        captionTextStyle: theme.captionTextStyle.copyWith(color: const Color(0xFF444444)),
        iconColor: Colors.black,
      );
    }

    return theme;
  }

  @override
  void dispose() {
    // Clean up by removing the listeners when the manager is disposed.
    _stateManager.removeListener(_onStateChanged);
    _contextManager.removeListener(_onStateChanged);
    super.dispose();
  }
}
