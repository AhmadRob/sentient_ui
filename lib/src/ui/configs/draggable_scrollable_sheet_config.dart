import 'package:flutter/material.dart';

/// Configuration for [SentientDraggableScrollableSheet] appearance.
@immutable
class DraggableScrollableSheetConfig {
  /// The resolved maximum child size.
  final double maxChildSize;

  /// The resolved initial child size.
  final double initialChildSize;

  /// The resolved minimum child size.
  final double minChildSize;

  /// Whether to allow full expansion.
  final bool expand;

  /// The resolved border radius.
  final double borderRadius;

  /// The resolved shadow blur radius.
  final double shadowBlur;

  /// The resolved shadow offset.
  final double shadowOffset;

  const DraggableScrollableSheetConfig({
    required this.maxChildSize,
    required this.initialChildSize,
    required this.minChildSize,
    required this.expand,
    required this.borderRadius,
    required this.shadowBlur,
    required this.shadowOffset,
  });

  /// Structured styling for anger.
  static const DraggableScrollableSheetConfig structured = DraggableScrollableSheetConfig(
    maxChildSize: 0.6,
    initialChildSize: 0.3,
    minChildSize: 0.2,
    expand: false,
    borderRadius: 8.0,
    shadowBlur: 4.0,
    shadowOffset: 2.0,
  );

  /// Standard styling for contempt/neutral.
  static const DraggableScrollableSheetConfig standard = DraggableScrollableSheetConfig(
    maxChildSize: 0.7,
    initialChildSize: 0.4,
    minChildSize: 0.25,
    expand: true,
    borderRadius: 12.0,
    shadowBlur: 6.0,
    shadowOffset: 3.0,
  );

  /// Clean styling for disgust.
  static const DraggableScrollableSheetConfig clean = DraggableScrollableSheetConfig(
    maxChildSize: 0.75,
    initialChildSize: 0.35,
    minChildSize: 0.3,
    expand: true,
    borderRadius: 16.0,
    shadowBlur: 8.0,
    shadowOffset: 4.0,
  );

  /// Flexible styling for enjoyment.
  static const DraggableScrollableSheetConfig flexible = DraggableScrollableSheetConfig(
    maxChildSize: 0.9,
    initialChildSize: 0.5,
    minChildSize: 0.2,
    expand: true,
    borderRadius: 20.0,
    shadowBlur: 12.0,
    shadowOffset: 6.0,
  );

  /// Contained styling for fear.
  static const DraggableScrollableSheetConfig contained = DraggableScrollableSheetConfig(
    maxChildSize: 0.65,
    initialChildSize: 0.4,
    minChildSize: 0.35,
    expand: false,
    borderRadius: 10.0,
    shadowBlur: 3.0,
    shadowOffset: 1.5,
  );

  /// Gentle styling for sadness.
  static const DraggableScrollableSheetConfig gentle = DraggableScrollableSheetConfig(
    maxChildSize: 0.7,
    initialChildSize: 0.45,
    minChildSize: 0.3,
    expand: true,
    borderRadius: 14.0,
    shadowBlur: 5.0,
    shadowOffset: 2.5,
  );

  /// Dynamic styling for surprise.
  static const DraggableScrollableSheetConfig dynamic = DraggableScrollableSheetConfig(
    maxChildSize: 0.95,
    initialChildSize: 0.6,
    minChildSize: 0.15,
    expand: true,
    borderRadius: 18.0,
    shadowBlur: 15.0,
    shadowOffset: 8.0,
  );
}
