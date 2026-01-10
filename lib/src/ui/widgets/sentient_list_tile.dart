import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive list tile widget that adapts its styling based on the
/// user's emotional state.
///
/// `SentientListTile` functions similarly to Flutter's [ListTile] widget
/// but introduces emotion-aware styling, using values from the active
/// [EmotionTheme] to determine optimal appearance and interaction behavior.
///
/// The widget listens to the [AdaptationManager] automatically and rebuilds
/// when the user's emotional state changes.
///
/// ## Features
/// - Emotion-aware colors, spacing, and typography.
/// - Adaptive icon sizing and positioning.
/// - Supports custom overrides for all ListTile properties.
/// - Follows Sentient Adaptation Guidelines for consistent hierarchy.
///
/// ## Example Usage
///
/// Basic usage:
/// ```dart
/// SentientListTile(
///   title: Text('Adaptive list tile'),
/// )
/// ```
///
/// With custom overrides:
/// ```dart
/// SentientListTile(
///   leading: Icon(Icons.star),
///   title: Text('Custom list tile'),
///   subtitle: Text('With subtitle'),
///   trailing: Icon(Icons.arrow_forward),
/// )
/// ```
class SentientListTile extends StatelessWidget {
  /// A widget to display before the title.
  final Widget? leading;

  /// The primary content of the list tile.
  final Widget? title;

  /// Additional content displayed below the title.
  final Widget? subtitle;

  /// A widget to display after the title.
  final Widget? trailing;

  /// The tile's internal padding.
  final EdgeInsetsGeometry? contentPadding;

  /// Called when the user taps this list tile.
  final VoidCallback? onTap;

  /// Called when the user long-presses on this list tile.
  final VoidCallback? onLongPress;

  /// Whether this list tile is interactive.
  final bool enabled;

  /// Whether to render ink ripple effect.
  final bool enableFeedback;

  /// An optional configuration to override the emotion-based defaults.
  final ListTileConfig? configOverride;

  /// Creates a new adaptive list tile.
  const SentientListTile({
    super.key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.contentPadding,
    this.onTap,
    this.onLongPress,
    this.enabled = true,
    this.enableFeedback = true,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Get emotion-driven styling.
    final ListTileConfig config = configOverride ?? emotionTheme.listTileConfig;

    return AnimatedContainer(
      duration: emotionTheme.animation.transitionDuration,
      curve: emotionTheme.animation.animationCurve,
      child: ListTile(
        leading: _buildLeading(emotionTheme, config),
        title: _buildTitle(emotionTheme, config),
        subtitle: _buildSubtitle(emotionTheme, config),
        trailing: _buildTrailing(emotionTheme, config),
        contentPadding: contentPadding ?? config.contentPadding,
        onTap: onTap,
        onLongPress: onLongPress,
        enabled: enabled,
        enableFeedback: enableFeedback && config.enableFeedback,
        tileColor: config.tileColor,
        iconColor: config.iconColor,
        textColor: config.textColor,
      ),
    );
  }

  /// Builds the leading widget with emotion-aware styling.
  Widget? _buildLeading(EmotionTheme theme, ListTileConfig config) {
    if (leading == null) return null;

    if (leading is Icon) {
      final icon = leading as Icon;
      return Icon(
        icon.icon,
        size: config.iconSize,
        color: config.iconColor,
      );
    }

    return Container(
      constraints: BoxConstraints(
        minWidth: config.iconSize,
        minHeight: config.iconSize,
      ),
      child: leading,
    );
  }

  /// Builds the title widget with emotion-aware styling.
  Widget? _buildTitle(EmotionTheme theme, ListTileConfig config) {
    if (title == null) return null;

    if (title is Text) {
      final text = title as Text;
      // Merge with theme body style + config overrides
      final style = theme.bodyTextStyle.merge(config.titleStyle).copyWith(color: config.textColor);
      
      return DefaultTextStyle(
        style: style,
        child: text,
      );
    }

    return DefaultTextStyle(
      style: theme.bodyTextStyle.merge(config.titleStyle).copyWith(color: config.textColor),
      child: title!,
    );
  }

  /// Builds the subtitle widget with emotion-aware styling.
  Widget? _buildSubtitle(EmotionTheme theme, ListTileConfig config) {
    if (subtitle == null) return null;

    if (subtitle is Text) {
      final text = subtitle as Text;
      final style = theme.captionTextStyle.merge(config.subtitleStyle).copyWith(color: config.textColor.withAlpha(179));
      
      return DefaultTextStyle(
        style: style,
        child: text,
      );
    }

    return DefaultTextStyle(
      style: theme.captionTextStyle.merge(config.subtitleStyle).copyWith(color: config.textColor.withAlpha(179)),
      child: subtitle!,
    );
  }

  /// Builds the trailing widget with emotion-aware styling.
  Widget? _buildTrailing(EmotionTheme theme, ListTileConfig config) {
    if (trailing == null) return null;

    if (trailing is Icon) {
      final icon = trailing as Icon;
      return Icon(
        icon.icon,
        size: config.iconSize * 0.8, // Slightly smaller for trailing
        color: config.iconColor.withAlpha(179),
      );
    }

    return Container(
      constraints: BoxConstraints(
        minWidth: config.iconSize * 0.8,
        minHeight: config.iconSize * 0.8,
      ),
      child: trailing,
    );
  }
}
