import 'package:flutter/material.dart';

/// Configuration for [SentientListTile] appearance.
@immutable
class ListTileConfig {
  /// The tile's internal padding.
  final EdgeInsetsGeometry contentPadding;

  /// The size of the icons (leading/trailing).
  final double iconSize;

  /// The style for the title text.
  final TextStyle titleStyle;

  /// The style for the subtitle text.
  final TextStyle subtitleStyle;

  /// The background color of the tile.
  final Color tileColor;

  /// The color of the icons.
  final Color iconColor;

  /// The default text color.
  final Color textColor;

  /// Whether to enable ink ripple feedback.
  final bool enableFeedback;

  const ListTileConfig({
    required this.contentPadding,
    required this.iconSize,
    required this.titleStyle,
    required this.subtitleStyle,
    required this.tileColor,
    required this.iconColor,
    required this.textColor,
    required this.enableFeedback,
  });

  /// Minimal/Stable styling for anger.
  static const ListTileConfig minimal = ListTileConfig(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    iconSize: 22.0,
    titleStyle: TextStyle(fontWeight: FontWeight.w500),
    subtitleStyle: TextStyle(),
    tileColor: Colors.transparent,
    iconColor: Color(0xB3E0E0E0),
    textColor: Color(0xFFE0E0E0),
    enableFeedback: false,
  );

  /// Professional styling for contempt/neutral.
  static const ListTileConfig standard = ListTileConfig(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    iconSize: 24.0,
    titleStyle: TextStyle(fontWeight: FontWeight.w500),
    subtitleStyle: TextStyle(),
    tileColor: Colors.transparent,
    iconColor: Color(0xFF757575),
    textColor: Color(0xFF212121),
    enableFeedback: true,
  );

  /// Spacious styling for disgust.
  static const ListTileConfig spacious = ListTileConfig(
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    iconSize: 26.0,
    titleStyle: TextStyle(fontWeight: FontWeight.w400),
    subtitleStyle: TextStyle(),
    tileColor: Colors.transparent,
    iconColor: Color(0xFF2196F3),
    textColor: Color(0xFF212121),
    enableFeedback: true,
  );

  /// Expressive styling for enjoyment.
  static const ListTileConfig expressive = ListTileConfig(
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    iconSize: 28.0,
    titleStyle: TextStyle(fontWeight: FontWeight.w600),
    subtitleStyle: TextStyle(),
    tileColor: Color(0xFFF0F0F0), // light surface
    iconColor: Color(0xFF2196F3),
    textColor: Color(0xFF2196F3),
    enableFeedback: true,
  );

  /// Gentle styling for sadness.
  static const ListTileConfig gentle = ListTileConfig(
    contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
    iconSize: 23.0,
    titleStyle: TextStyle(fontWeight: FontWeight.w400),
    subtitleStyle: TextStyle(fontStyle: FontStyle.italic),
    tileColor: Colors.transparent,
    iconColor: Color(0xB32196F3),
    textColor: Color(0xFF212121),
    enableFeedback: true,
  );

  /// Dynamic styling for surprise.
  static const ListTileConfig dynamic = ListTileConfig(
    contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    iconSize: 28.0,
    titleStyle: TextStyle(fontWeight: FontWeight.w700),
    subtitleStyle: TextStyle(),
    tileColor: Color(0xFFE0F7FA),
    iconColor: Color(0xFF03DAC6),
    textColor: Color(0xFF03DAC6),
    enableFeedback: true,
  );
}
