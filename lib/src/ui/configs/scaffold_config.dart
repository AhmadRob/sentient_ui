import 'package:flutter/material.dart';

/// Holds all adaptive properties that may vary based on emotional themes
@immutable
class ScaffoldConfig {
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final Color? backgroundColor;
  final bool extendBodyBehindAppBar;

  const ScaffoldConfig({
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.extendBodyBehindAppBar = false,
  });

  /// Default balanced layout → anger / fear / neutral states.
  static ScaffoldConfig get neutral => const ScaffoldConfig(
    backgroundColor: Color(0xFFF5F5F5),
    extendBodyBehindAppBar: false,
  );

  /// Softer visuals → sadness scenarios.
  static ScaffoldConfig get soft => const ScaffoldConfig(
    backgroundColor: Color(0xFFF8F3FF),
    extendBodyBehindAppBar: false,
  );

  /// Vibrant layout → enjoyment / surprise.
  static ScaffoldConfig get lively => const ScaffoldConfig(
    backgroundColor: Color(0xFFFFFAE8),
    extendBodyBehindAppBar: true,
  );
}
