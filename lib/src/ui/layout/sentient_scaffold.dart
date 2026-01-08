import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive [Scaffold] that adapts its layout properties based on the user's
/// emotional state.
///
/// `SentientScaffold` functions as a drop-in replacement for Flutter's [Scaffold]
/// but automatically adjusts properties like `backgroundColor` and the visibility of
/// its components based on the active [EmotionTheme] provided by the
/// [AdaptationManager]. It applies a predefined configuration from [ScaffoldConfig]
/// to create a layout that feels stable, calm, or dynamic.
///
/// This widget supports custom overrides for its properties while preserving
/// emotion-driven defaults for any unspecified values.
///
/// ## Example Usage
/// ```dart
/// SentientScaffold(
///   appBar: AppBar(title: SentientText('My App')),
///   body: Center(child: SentientText('Content goes here')),
/// )
/// ```
class SentientScaffold extends StatelessWidget {
  /// An optional app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// The primary content of the scaffold.
  final Widget? body;

  /// An optional floating action button to display.
  final Widget? floatingActionButton;

  /// An optional navigation bar to display at the bottom of the scaffold.
  final Widget? bottomNavigationBar;

  /// An optional override for the scaffold's background color.
  ///
  /// If not provided, the color is determined by the active [ScaffoldConfig]
  /// or falls back to the theme's `surfaceColor`.
  final Color? backgroundColor;

  /// Whether the [body] should extend behind the [appBar].
  final bool? extendBodyBehindAppBar;

  /// A custom configuration that overrides the emotion-based defaults.
  final ScaffoldConfig? configOverride;

  /// Creates a new adaptive `SentientScaffold`.
  const SentientScaffold({
    super.key,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.bottomNavigationBar,
    this.backgroundColor,
    this.extendBodyBehindAppBar,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Resolve the configuration from an override or the current emotion.
    final ScaffoldConfig config =
        configOverride ?? emotionTheme.scaffoldConfig;

    return Scaffold(
      appBar: appBar ?? config.appBar,
      body: body ?? config.body,
      floatingActionButton: floatingActionButton ?? config.floatingActionButton,
      bottomNavigationBar: bottomNavigationBar ?? config.bottomNavigationBar,
      backgroundColor:
          backgroundColor ?? config.backgroundColor ?? emotionTheme.surfaceColor,
      extendBodyBehindAppBar:
          extendBodyBehindAppBar ?? config.extendBodyBehindAppBar,
    );
  }
}
