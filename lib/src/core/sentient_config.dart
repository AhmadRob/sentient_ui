import 'dart:math';
import 'package:flutter/foundation.dart';

/// Defines the runtime configuration for the [SentientEngine].
///
/// This class acts as a policy container, allowing developers to explicitly
/// enable or disable specific sensing capabilities (vision, context, behavior)
/// and control operational parameters like sampling frequency.
///
/// Configuration is immutable; use [copyWith] to create modified instances.
class SentientConfig {
  /// Controls the active state of camera-based emotion detection.
  ///
  /// If set to `false`, the engine will:
  /// - Not request camera permissions.
  /// - Not access the camera hardware.
  /// - Bypass the vision analysis pipeline completely.
  ///
  /// Defaults to `true`.
  final bool enableEmotionDetection;

  /// Controls the active state of environmental context sensing.
  ///
  /// If set to `false`, the engine will not sample signals such as:
  /// - Ambient noise levels (microphone).
  /// - Device motion (accelerometer).
  /// - Network and battery status.
  ///
  /// Defaults to `true`.
  final bool enableContextSensing;

  /// Controls the active state of user behavior tracking.
  ///
  /// If set to `false`, the engine will ignore interaction metrics like:
  /// - Scroll velocity.
  /// - Tap intensity and frequency.
  /// - Gesture patterns.
  ///
  /// Defaults to `true`.
  final bool enableBehaviorTracking;

  /// The time interval between automatic sensing cycles.
  ///
  /// This duration dictates how often the engine wakes up to:
  /// 1. Sample environmental context.
  /// 2. Capture and analyze a camera frame (if enabled).
  /// 3. Update the global emotional state.
  ///
  /// A shorter interval increases responsiveness but consumes more battery.
  /// A longer interval is more efficient but may miss transient emotional reactions.
  ///
  /// **ENSURING NOT LESS THAN 30s Rule**: This minimum interval is critical for
  /// allowing emotions to be detected well. The Bayesian filter needs sufficient
  /// time between adaptations to accumulate enough data points from the fast
  /// emotion loop (5-second intervals) to produce reliable, smoothed emotion
  /// predictions. Shorter intervals would result in emotional "noise" and
  /// potentially incorrect adaptations.
  ///
  /// Defaults to `30 seconds`.
  final Duration captureInterval;

  /// Creates a configuration object for the [SentientEngine].
  ///
  /// **ENSURING NOT LESS THAN 30s Rule**: This constructor strictly enforces
  /// that the [captureInterval] must be at least 30 seconds to ensure the
  /// Bayesian filter has sufficient data (typically 5-6 samples from the fast
  /// loop) to accurately detect and smooth emotional states before triggering
  /// UI adaptations.
  ///
  /// If a duration less than 30 seconds is provided, it will be automatically
  /// clamped to 30 seconds and a debug warning will be printed.
  SentientConfig({
    this.enableEmotionDetection = true,
    this.enableContextSensing = true,
    this.enableBehaviorTracking = true,
    Duration captureInterval = const Duration(seconds: 30),
  }) : captureInterval = _clampInterval(captureInterval);

  /// Ensures the [captureInterval] is not less than 30 seconds.
  ///
  /// Prints a debug warning if clamping occurs. This guarantees the Bayesian
  /// filter can accumulate enough data points before adaptations.
  static Duration _clampInterval(Duration interval) {
    final clampedSeconds = max(30, interval.inSeconds);

    if (kDebugMode && interval.inSeconds < 30) {
      debugPrint(
          '[SentientConfig] ENSURING NOT LESS THAN 30s Rule: '
              'Capture interval of ${interval.inSeconds}s is too short for reliable emotion detection. '
              'Automatically clamping to 30s to allow the Bayesian filter to accumulate sufficient data.'
      );
    }

    return Duration(seconds: clampedSeconds);
  }

  /// Creates a copy of this configuration with the given fields replaced with new values.
  ///
  /// **ENSURING NOT LESS THAN 30s Rule**: When using [copyWith], if a new
  /// [captureInterval] is provided that is less than 30 seconds, it will be
  /// automatically clamped to 30 seconds. This maintains the minimum data
  /// collection window needed for accurate emotion detection.
  SentientConfig copyWith({
    bool? enableEmotionDetection,
    bool? enableContextSensing,
    bool? enableBehaviorTracking,
    Duration? captureInterval,
  }) {
    return SentientConfig(
      enableEmotionDetection: enableEmotionDetection ?? this.enableEmotionDetection,
      enableContextSensing: enableContextSensing ?? this.enableContextSensing,
      enableBehaviorTracking: enableBehaviorTracking ?? this.enableBehaviorTracking,
      captureInterval: captureInterval ?? this.captureInterval, // Constructor handles clamping
    );
  }

  @override
  String toString() =>
      'SentientConfig(emotion: $enableEmotionDetection, context: $enableContextSensing, behavior: $enableBehaviorTracking, interval: ${captureInterval.inSeconds}s)';
}
