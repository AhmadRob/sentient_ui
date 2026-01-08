import 'package:flutter/material.dart';

/// Configuration for [SentientBottomNavigationBar] appearance.
@immutable
class BottomNavigationBarConfig {
  /// The color of the selected item.
  final Color selectedItemColor;

  /// The color of the unselected item.
  final Color unselectedItemColor;

  /// The background color.
  final Color backgroundColor;

  /// The elevation.
  final double elevation;

  /// Whether to show selected labels.
  final bool showSelectedLabels;

  /// Whether to show unselected labels.
  final bool showUnselectedLabels;

  /// The font size for selected items.
  final double selectedFontSize;

  /// The font size for unselected items.
  final double unselectedFontSize;

  /// The size of the icons.
  final double iconSize;

  const BottomNavigationBarConfig({
    required this.selectedItemColor,
    required this.unselectedItemColor,
    required this.backgroundColor,
    required this.elevation,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
    required this.selectedFontSize,
    required this.unselectedFontSize,
    required this.iconSize,
  });

  /// Minimal styling for anger (no labels, flat).
  static const BottomNavigationBarConfig minimal = BottomNavigationBarConfig(
    selectedItemColor: Color(0xCC8B5A5A),
    unselectedItemColor: Color(0x66E0E0E0),
    backgroundColor: Color(0xFF2D2D2D),
    elevation: 0.0,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    selectedFontSize: 10.0,
    unselectedFontSize: 8.0,
    iconSize: 18.0, // 22 * 0.8 roughly
  );

  /// Professional styling for contempt/neutral.
  static const BottomNavigationBarConfig standard = BottomNavigationBarConfig(
    selectedItemColor: Color(0xFF2196F3),
    unselectedItemColor: Color(0x99212121),
    backgroundColor: Color(0xFFFAFAFA),
    elevation: 2.0,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    selectedFontSize: 12.0,
    unselectedFontSize: 10.0,
    iconSize: 24.0,
  );

  /// Clean styling for disgust.
  static const BottomNavigationBarConfig clean = BottomNavigationBarConfig(
    selectedItemColor: Color(0xFF2196F3),
    unselectedItemColor: Color(0x80212121),
    backgroundColor: Color(0xFFFFFFFF),
    elevation: 1.0,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedFontSize: 13.0,
    unselectedFontSize: 11.0,
    iconSize: 26.0,
  );

  /// Expressive styling for enjoyment.
  static const BottomNavigationBarConfig expressive = BottomNavigationBarConfig(
    selectedItemColor: Color(0xFF2196F3),
    unselectedItemColor: Color(0xB303DAC6),
    backgroundColor: Color(0xFFFAFAFA),
    elevation: 4.0,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedFontSize: 14.0,
    unselectedFontSize: 12.0,
    iconSize: 28.0,
  );

  /// Stable styling for fear.
  static const BottomNavigationBarConfig stable = BottomNavigationBarConfig(
    selectedItemColor: Color(0xE62196F3),
    unselectedItemColor: Color(0x80212121),
    backgroundColor: Color(0xFFFAFAFA),
    elevation: 1.0,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    selectedFontSize: 12.0,
    unselectedFontSize: 10.0,
    iconSize: 24.0,
  );

  /// Gentle styling for sadness.
  static const BottomNavigationBarConfig gentle = BottomNavigationBarConfig(
    selectedItemColor: Color(0xCC2196F3),
    unselectedItemColor: Color(0x66212121),
    backgroundColor: Color(0xFFFAFAFA),
    elevation: 2.0,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    selectedFontSize: 12.0,
    unselectedFontSize: 10.0,
    iconSize: 22.0,
  );

  /// Dynamic styling for surprise.
  static const BottomNavigationBarConfig dynamic = BottomNavigationBarConfig(
    selectedItemColor: Color(0xFF03DAC6),
    unselectedItemColor: Color(0x992196F3),
    backgroundColor: Color(0xFFFFFFFF),
    elevation: 6.0,
    showSelectedLabels: true,
    showUnselectedLabels: true,
    selectedFontSize: 15.0,
    unselectedFontSize: 13.0,
    iconSize: 30.0,
  );
}
