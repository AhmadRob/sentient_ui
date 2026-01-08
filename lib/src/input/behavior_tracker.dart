import 'package:flutter/foundation.dart';
import '../../sentient_ui.dart';
import '../models/behavioral_emotion_result.dart';
import '../models/emotion_state.dart';

// --- Tracker ---

/// Monitors user interaction patterns to deduce emotional context.
///
/// The [BehaviorTracker] analyzes low-level input events (like taps, gestures, 
/// and scroll velocity) to identify high-level behavioral markers.
///
/// For example, rapid, repetitive tapping often indicates frustration or anger.
class BehaviorTracker {
  BehaviorState _state = BehaviorState.initial();
  
  // Configuration
  static const Duration _window = Duration(milliseconds: 1000);
  static const int _tapThreshold = 2; // 3 taps within 1s -> Frustration/Anger

  /// Registers a tap event for analysis.
  ///
  /// This method should be called by input widgets (e.g., [SentientGestureDetector])
  /// whenever a user interaction occurs. It automatically manages the time window
  /// for pattern recognition.
  void registerTap() {
    final now = DateTime.now();
    _state = _state.resetIfWindowExpired(_window, now);
    _state = _state.registerTap();
  }

  /// Evaluates the current interaction history for recognized behavioral patterns.
  ///
  /// Returns a [BehavioralEmotionResult] if a pattern (e.g., rage tapping) is detected,
  /// or `null` if the behavior is neutral.
  BehavioralEmotionResult? analyze() {
    // Ensure state is current before analysis
    _state = _state.resetIfWindowExpired(_window, DateTime.now());

    // Logic: If tap count exceeds threshold within the window -> Anger
    if (_state.tapCount >= _tapThreshold) {
      // Basic heuristic: Rapid tapping suggests frustration or anger.
      debugPrint('[BehaviorTracker] Rapid tapping suggests frustration or anger.');
      return const BehavioralEmotionResult(
        detectedEmotion: EmotionState.anger,
        confidence: 0.8,
        reason: 'Rapid tapping detected',
      );
    }
    return null;
  }
}
