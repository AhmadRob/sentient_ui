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
  /// Defaults to `10 seconds`.
  final Duration captureInterval;

  /// Creates a configuration object for the [SentientEngine].
  const SentientConfig({
    this.enableEmotionDetection = true,
    this.enableContextSensing = true,
    this.enableBehaviorTracking = true,
    this.captureInterval = const Duration(seconds: 10),
  });

  /// Creates a copy of this configuration with the given fields replaced with new values.
  SentientConfig copyWith({
    bool? enableEmotionDetection,
    bool? enableContextSensing,
    bool? enableBehaviorTracking,
    Duration? captureInterval,
  }) {
    return SentientConfig(
      enableEmotionDetection:
          enableEmotionDetection ?? this.enableEmotionDetection,
      enableContextSensing: enableContextSensing ?? this.enableContextSensing,
      enableBehaviorTracking:
          enableBehaviorTracking ?? this.enableBehaviorTracking,
      captureInterval: captureInterval ?? this.captureInterval,
    );
  }

  @override
  String toString() =>
      'SentientConfig(emotion: $enableEmotionDetection, context: $enableContextSensing, behavior: $enableBehaviorTracking, interval: ${captureInterval.inSeconds}s)';
}
