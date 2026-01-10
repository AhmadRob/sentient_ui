import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// An emotion-aware application bar widget.
///
/// This widget adapts its visual appearance dynamically
/// based on the current [EmotionTheme], adjusting background,
/// elevation, border, and title alignment to match the
/// user's emotional state.
///
/// It is designed to provide calm, low-stimulation navigation
/// during negative emotional states, while allowing more
/// expressive visual emphasis during positive emotions.
///
/// Common use cases include the primary app bar for screens
/// or modal headers within the Sentient UI system.
///
/// ## Features
/// - Emotion-aware appearance (calm for negative, expressive for positive).
/// - Dynamic adjustment of background, shadow, and border.
/// - Configurable overrides via [AppBarConfig].
/// - Seamless integration with [EmotionTheme].
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientAppBar(
///   title: Text('My App'),
/// )
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientAppBar(
///   title: Text('My App'),
///   config: AppBarConfig(
///     backgroundColor: Colors.blue,
///   ),
/// )
/// ```
class SentientAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  /// The primary widget displayed in the app bar.
  ///
  /// Usually a [Text] widget representing the page title.
  final Widget title;

  /// Optional widgets displayed after the [title].
  ///
  /// Commonly used for action buttons such as search
  /// or settings.
  final List<Widget>? actions;

  /// Optional configuration override.
  ///
  /// When provided, non-null properties override the
  /// emotion-resolved app bar configuration.
  final AppBarConfig? config;

  /// Creates a [SentientAppBar].
  const SentientAppBar({
    super.key,
    required this.title,
    this.actions,
    this.config,
  });

  /// The preferred size of the app bar.
  ///
  /// Defaults to [kToolbarHeight] unless overridden
  /// by the provided [config].
  @override
  Size get preferredSize =>
      Size.fromHeight(config?.height ?? kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // Observe emotion-driven theme adaptations
    final adaptation = context.watch<AdaptationManager>();

    // Current emotion-aware theme
    final theme = adaptation.currentTheme;

    // Resolve final app bar configuration and merge overrides
    final resolved = config ?? theme.appBarConfig;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: resolved.backgroundColor ?? theme.surfaceColor,
        border: resolved.border,
        boxShadow: resolved.shadowIntensity == 0
            ? const []
            : [
          BoxShadow(
            color: Colors.black
                .withAlpha((resolved.shadowIntensity * 255).round()),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: resolved.centerTitle,
        title: title,
        actions: actions,
      ),
    );
  }
}
