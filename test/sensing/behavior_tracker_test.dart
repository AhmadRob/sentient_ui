import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/src/input/behavior_tracker.dart';
import 'package:sentient_ui/sentient_ui.dart';

/// Unit tests for the [BehaviorTracker], which monitors user interaction patterns.
/// 
/// These tests verify the heuristic logic that converts low-level inputs 
/// (like taps) into emotional markers (like frustration/anger).
void main() {
  group('BehaviorTracker Tests', () {
    late BehaviorTracker tracker;

    setUp(() {
      tracker = BehaviorTracker();
    });

    /// Ensures that the tracker starts in a neutral state with no detection.
    test('Initial analysis returns null', () {
      expect(tracker.analyze(), isNull);
    });

    /// Verifies that standard usage (single taps) does not trigger 
    /// false positive emotional markers.
    test('Single tap does not trigger anger', () {
      tracker.registerTap();
      expect(tracker.analyze(), isNull);
    });

    /// Tests the "Rage Tapping" heuristic: 3 or more taps within a 
    /// 1-second window are interpreted as a sign of frustration or anger.
    test('Rapid tapping (3 taps) triggers anger', () {
      // Threshold is 2 (so 3 taps total within the sliding window)
      tracker.registerTap();
      tracker.registerTap();
      tracker.registerTap();

      final result = tracker.analyze();
      expect(result, isNotNull);
      expect(result!.detectedEmotion, EmotionState.anger);
      expect(result.reason, contains('Rapid tapping'));
    });

    /// Ensures that interaction history is correctly purged after the 
    /// time window (1 second) expires, preventing stale data from 
    /// influencing future detections.
    test('Taps expire after the window', () async {
      tracker.registerTap();
      tracker.registerTap();
      
      // Wait for window to expire (window is 1000ms)
      await Future.delayed(const Duration(milliseconds: 1100));
      
      // Analysis should now be null as taps expired
      expect(tracker.analyze(), isNull);
      
      // One more tap (making it 3 total across all time, but not within 1s) 
      // should still be null.
      tracker.registerTap();
      expect(tracker.analyze(), isNull);
    });
  });
}
