import 'package:flutter/material.dart';

/// Configuration for [SentientCircleAvatar] appearance.
@immutable
class CircleAvatarConfig {
  /// The radius of the avatar.
  final double radius;

  /// The background color.
  final Color backgroundColor;

  /// The foreground color (icon/text).
  final Color foregroundColor;

  const CircleAvatarConfig({
    required this.radius,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  /// Minimal styling for anger.
  static const CircleAvatarConfig minimal = CircleAvatarConfig(
    radius: 18.0, // 22(iconSize) * 0.8 roughly
    backgroundColor: Color(0xB38B5A5A),
    foregroundColor: Colors.white,
  );

  /// Professional styling for contempt/neutral.
  static const CircleAvatarConfig standard = CircleAvatarConfig(
    radius: 24.0,
    backgroundColor: Color(0xFF2196F3),
    foregroundColor: Colors.white,
  );

  /// Clean styling for disgust.
  static const CircleAvatarConfig clean = CircleAvatarConfig(
    radius: 26.0,
    backgroundColor: Color(0xFFFAFAFA),
    foregroundColor: Color(0xFF212121),
  );

  /// Expressive styling for enjoyment.
  static const CircleAvatarConfig expressive = CircleAvatarConfig(
    radius: 28.0,
    backgroundColor: Color(0xFF2196F3),
    foregroundColor: Colors.white,
  );

  /// Gentle styling for sadness.
  static const CircleAvatarConfig gentle = CircleAvatarConfig(
    radius: 22.0,
    backgroundColor: Color(0xCC2196F3),
    foregroundColor: Colors.white,
  );

  /// Dynamic styling for surprise.
  static const CircleAvatarConfig dynamic = CircleAvatarConfig(
    radius: 30.0,
    backgroundColor: Color(0xFF03DAC6),
    foregroundColor: Colors.white,
  );
}
