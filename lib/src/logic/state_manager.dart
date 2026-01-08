import 'package:flutter/foundation.dart';
import 'package:sentient_ui/sentient_ui.dart';

import '../models/emotion_state.dart';

/// Manages the global emotional state of the application.
///
/// This class follows the singleton pattern to provide a single source of truth
/// for the user's current emotional state. It uses the `ChangeNotifier` mixin
/// to allow UI widgets to listen for and react to state changes.
///
/// The [SentientEngine] is responsible for updating this state after processing
/// and filtering the raw emotion data.
class StateManager extends ChangeNotifier {
  // --- Singleton Setup ---
  static final StateManager _instance = StateManager._internal();

  /// Provides access to the singleton instance of the StateManager.
  factory StateManager() {
    return _instance;
  }

  StateManager._internal();
  // --- End Singleton Setup ---

  // The current emotional state, initialized to neutral.
  EmotionResult _currentEmotion = EmotionResult(
    dominantEmotion: EmotionState.neutral,
    confidence: 1.0,
    // Initialize with neutral having full probability.
    probabilities: {for (var e in EmotionState.values) e: 0.0}
      ..[EmotionState.neutral] = 1.0,
    timestamp: DateTime.now(),
  );

  /// The current, stable emotional state of the user.
  ///
  /// Widgets can listen to the [StateManager] and use this property
  /// to get the most up-to-date emotional data.
  EmotionResult get currentEmotion => _currentEmotion;

  /// The dominant emotion from the current state.
  ///
  /// A convenience getter for accessing `currentEmotion.dominantEmotion`.
  EmotionState get dominantEmotion => _currentEmotion.dominantEmotion;

  /// Updates the current emotional state and notifies all listeners.
  ///
  /// This method should typically be called by the [SentientEngine] after it has
  /// derived a stable emotion reading from its internal processing pipeline
  /// (e.g., after applying the BayesianFilter).
  ///
  /// [newResult] The new emotional state to set.
  void updateEmotion(EmotionResult newResult) {
    // To prevent unnecessary rebuilds, only notify listeners if the
    // dominant emotion has actually changed.
    if (_currentEmotion.dominantEmotion == newResult.dominantEmotion) {
      return;
    }

    _currentEmotion = newResult;

    // This is the core of the ChangeNotifier pattern. It tells all listening
    // widgets that they need to rebuild with the new state.
    notifyListeners();
  }
}
