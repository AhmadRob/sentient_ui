import 'package:flutter/material.dart';

/// Defines configuration for a SentientSizedBox, allowing
/// emotion-driven dimension adjustments.
@immutable
class SizedBoxConfig {
  /// The width of the box.
  final double? width;

  /// The height of the box.
  final double? height;

  const SizedBoxConfig({
    this.width,
    this.height,
  });

  /// Neutral spacing configuration.
  static const SizedBoxConfig neutral = SizedBoxConfig(
    width: 10,
    height: 10,
  );

  /// Soft spacing configuration (slightly larger spacing for calm/sad emotions).
  static const SizedBoxConfig soft = SizedBoxConfig(
    width: 15,
    height: 15,
  );

  /// Lively spacing configuration (larger spacing for enjoyment/surprise emotions).
  static const SizedBoxConfig lively = SizedBoxConfig(
    width: 20,
    height: 20,
  );
}
