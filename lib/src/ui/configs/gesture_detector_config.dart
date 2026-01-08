import 'package:flutter/material.dart';

/// Configuration for [SentientGestureDetector] feedback behavior.
@immutable
class GestureDetectorConfig {
  /// Whether visual feedback (scale/opacity) is enabled.
  final bool enableVisualFeedback;

  /// Whether haptic feedback is enabled.
  final bool enableHapticFeedback;

  /// The duration of the feedback animation.
  final Duration feedbackDuration;

  /// The scale factor for visual feedback (1.0 = no scale).
  final double visualScaleFactor;

  /// The opacity factor for visual feedback (1.0 = no opacity change).
  final double visualOpacityFactor;

  const GestureDetectorConfig({
    required this.enableVisualFeedback,
    required this.enableHapticFeedback,
    required this.feedbackDuration,
    required this.visualScaleFactor,
    required this.visualOpacityFactor,
  });

  /// Minimal feedback for anger.
  static const GestureDetectorConfig minimal = GestureDetectorConfig(
    enableVisualFeedback: false,
    enableHapticFeedback: false,
    feedbackDuration: Duration(milliseconds: 300),
    visualScaleFactor: 1.0,
    visualOpacityFactor: 1.0,
  );

  /// Standard feedback for neutral/contempt.
  static const GestureDetectorConfig standard = GestureDetectorConfig(
    enableVisualFeedback: true,
    enableHapticFeedback: true, // Assuming sound enabled globally
    feedbackDuration: Duration(milliseconds: 150),
    visualScaleFactor: 0.98,
    visualOpacityFactor: 0.9,
  );

  /// Subtle feedback for disgust/fear.
  static const GestureDetectorConfig subtle = GestureDetectorConfig(
    enableVisualFeedback: true,
    enableHapticFeedback: true,
    feedbackDuration: Duration(milliseconds: 250),
    visualScaleFactor: 0.99,
    visualOpacityFactor: 0.95,
  );

  /// Expressive feedback for enjoyment.
  static const GestureDetectorConfig expressive = GestureDetectorConfig(
    enableVisualFeedback: true,
    enableHapticFeedback: true,
    feedbackDuration: Duration(milliseconds: 100), // Quick
    visualScaleFactor: 0.95,
    visualOpacityFactor: 0.8,
  );

  /// Gentle feedback for sadness.
  static const GestureDetectorConfig gentle = GestureDetectorConfig(
    enableVisualFeedback: false, // Or very subtle
    enableHapticFeedback: true,
    feedbackDuration: Duration(milliseconds: 200),
    visualScaleFactor: 0.99,
    visualOpacityFactor: 0.95,
  );

  /// Dynamic feedback for surprise.
  static const GestureDetectorConfig dynamic = GestureDetectorConfig(
    enableVisualFeedback: true,
    enableHapticFeedback: true,
    feedbackDuration: Duration(milliseconds: 80), // Very quick
    visualScaleFactor: 0.92, // Noticeable scale
    visualOpacityFactor: 0.7,
  );
}
