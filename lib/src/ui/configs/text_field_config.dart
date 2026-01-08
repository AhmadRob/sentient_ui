import 'package:flutter/material.dart';

/// Defines container styling for [SentientTextField] based on emotion.
@immutable
class TextFieldConfig {
  /// Internal padding inside the TextField container.
  final EdgeInsets padding;

  /// Background color of the TextField container.
  final Color? backgroundColor;

  /// Corner radius of the container.
  final double borderRadius;

  /// Optional box shadow.
  final List<BoxShadow>? boxShadow;

  /// Default text alignment.
  final TextAlign textAlign;

  /// Default InputDecoration if none provided.
  final InputDecoration decoration;

  const TextFieldConfig({
    required this.padding,
    this.backgroundColor,
    required this.borderRadius,
    this.boxShadow,
    this.textAlign = TextAlign.start,
    required this.decoration,
  });

  /// Neutral style (for anger, fear)
  static final TextFieldConfig neutral = TextFieldConfig(
    padding: const EdgeInsets.all(12),
    borderRadius: 8.0,
    backgroundColor: Colors.grey.shade200,
    boxShadow: null,
    textAlign: TextAlign.start,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter text',
    ),
  );

  /// Soft style (for sadness)
  static final TextFieldConfig soft = TextFieldConfig(
    padding: const EdgeInsets.all(16),
    borderRadius: 12.0,
    backgroundColor: Colors.grey.shade100,
    boxShadow: null,
    textAlign: TextAlign.start,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Enter text gently',
    ),
  );

  /// Lively style (for enjoyment, surprise)
  static final TextFieldConfig lively = TextFieldConfig(
    padding: const EdgeInsets.all(20),
    borderRadius: 16.0,
    backgroundColor: Colors.white,
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6,
        offset: Offset(0, 2),
      ),
    ],
    textAlign: TextAlign.start,
    decoration: const InputDecoration(
      border: OutlineInputBorder(),
      hintText: 'Type something fun!',
    ),
  );
}
