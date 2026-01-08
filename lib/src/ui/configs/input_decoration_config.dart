import 'package:flutter/material.dart';

// Defines InputDecoration styling for different emotional states.
@immutable
class InputDecorationConfig {
  /// Border style for the text field
  final InputBorder? border;

  /// Placeholder text
  final String? hintText;

  /// Style for the placeholder text
  final TextStyle? hintStyle;

  /// Padding inside the text field
  final EdgeInsets contentPadding;

  /// Icon displayed at the start of the text field
  final Widget? prefixIcon;

  const InputDecorationConfig({
    this.border,
    this.hintText,
    this.hintStyle,
    required this.contentPadding,
    this.prefixIcon,
  });

  /// Neutral decoration style
  static const InputDecorationConfig neutral = InputDecorationConfig(
    border: OutlineInputBorder(),
    hintText: 'Enter text',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.all(12),
    prefixIcon: null,
  );

  /// Soft decoration style
  static const InputDecorationConfig soft = InputDecorationConfig(
    border: UnderlineInputBorder(),
    hintText: 'Enter text',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    prefixIcon: null,
  );

  /// Lively decoration style
  static const InputDecorationConfig lively = InputDecorationConfig(
    border: OutlineInputBorder(),
    hintText: 'Enter text',
    hintStyle: TextStyle(color: Colors.grey),
    contentPadding: EdgeInsets.all(14),
    prefixIcon: Icon(Icons.edit, color: Colors.blue),
  );
}
