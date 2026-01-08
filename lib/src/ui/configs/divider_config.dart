import 'package:flutter/material.dart';

/// Configuration for [SentientDivider] appearance.
@immutable
class DividerConfig {
  /// The thickness of the divider line.
  final double thickness;

  /// The height of the divider container.
  final double height;

  /// The color of the divider.
  final Color color;

  const DividerConfig({
    required this.thickness,
    required this.height,
    required this.color,
  });

  /// Minimal styling for anger (thin, subtle).
  static const DividerConfig minimal = DividerConfig(
    thickness: 0.5,
    height: 12.0, // 1.5 * baseSpacing(8) approx
    color: Color(0x33E0E0E0), // onSurface with opacity
  );

  /// Standard styling for neutral/contempt.
  static const DividerConfig standard = DividerConfig(
    thickness: 1.0,
    height: 16.0,
    color: Color(0x4D212121),
  );

  /// Visible styling for disgust (clean/clear).
  static const DividerConfig visible = DividerConfig(
    thickness: 1.2,
    height: 20.0,
    color: Color(0x662196F3), // primary with opacity
  );

  /// Prominent styling for enjoyment/surprise.
  static const DividerConfig prominent = DividerConfig(
    thickness: 2.0,
    height: 16.0,
    color: Color(0x992196F3),
  );

  /// Gentle styling for sadness/fear.
  static const DividerConfig gentle = DividerConfig(
    thickness: 0.8,
    height: 18.0,
    color: Color(0x4D2196F3),
  );
}
