import 'package:flutter/material.dart';

/// Defines how the SafeArea should behave for different emotional states.
@immutable
class SafeAreaConfig {
  final EdgeInsets padding;

  const SafeAreaConfig({
    required this.padding,
  });

  /// Neutral state — balanced, default spacing.
  static const SafeAreaConfig neutral = SafeAreaConfig(
    padding: EdgeInsets.all(0),
  );

  /// Soft state — sadness & calm modes → more whitespace.
  static const SafeAreaConfig soft = SafeAreaConfig(
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
  );

  /// Lively state — enjoyment/surprise → tighter layout feel.
  static const SafeAreaConfig lively = SafeAreaConfig(
    padding: EdgeInsets.zero,
  );
}
