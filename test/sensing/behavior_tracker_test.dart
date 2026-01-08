import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/src/input/behavior_tracker.dart';
import 'package:sentient_ui/sentient_ui.dart';

void main() {
  group('BehaviorTracker Tests', () {
    late BehaviorTracker tracker;

    setUp(() {
      tracker = BehaviorTracker();
    });

    test('Initial analysis returns null', () {
      expect(tracker.analyze(), isNull);
    });

    test('Single tap does not trigger anger', () {
      tracker.registerTap();
      expect(tracker.analyze(), isNull);
    });

    test('Rapid tapping (3 taps) triggers anger', () {
      // Threshold is 2 (so 3 taps total)
      tracker.registerTap();
      tracker.registerTap();
      tracker.registerTap();

      final result = tracker.analyze();
      expect(result, isNotNull);
      expect(result!.detectedEmotion, EmotionState.anger);
      expect(result.reason, contains('Rapid tapping'));
    });

    test('Taps expire after the window', () async {
      tracker.registerTap();
      tracker.registerTap();
      
      // Wait for window to expire (window is 1000ms)
      await Future.delayed(const Duration(milliseconds: 1100));
      
      // Analysis should now be null as taps expired
      expect(tracker.analyze(), isNull);
      
      // One more tap (making it 3 total but spread out) should still be null
      tracker.registerTap();
      expect(tracker.analyze(), isNull);
    });
  });
}
