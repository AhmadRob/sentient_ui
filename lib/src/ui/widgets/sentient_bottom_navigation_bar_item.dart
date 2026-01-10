import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive bottom navigation bar item that adapts its appearance based on the
/// user's emotional state.
///
/// `SentientBottomNavigationBarItem` functions similarly to Flutter's [BottomNavigationBarItem]
/// but introduces emotion-aware styling. It uses values from the active [EmotionTheme]
/// to determine optimal icon and label presentation, ensuring that navigation elements
/// feel integrated with the current emotional context.
///
/// This class is designed to be used with [SentientBottomNavigationBar] or
/// [SentientBottomNavigationBarBuilder] to automatically rebuild when the user's
/// emotional state changes via the [AdaptationManager].
///
/// ## Features
/// - Emotion-aware icon sizing (e.g., larger for enjoyment, smaller for anger).
/// - Adaptive icon colors and visibility.
/// - Dynamic active/inactive state handling.
/// - Supports playful animations for positive emotions (bounce, pulse).
///
/// ## Example Usage
///
/// Basic usage within a builder:
/// ```dart
/// SentientBottomNavigationBarBuilder(
///   items: [
///     SentientBottomNavigationBarItem(icon: Icons.home, label: 'Home'),
///     SentientBottomNavigationBarItem(icon: Icons.settings, label: 'Settings'),
///   ],
///   currentIndex: _selectedIndex,
///   builder: (context, items) => BottomNavigationBar(items: items),
/// )
/// ```
class SentientBottomNavigationBarItem {
  /// The icon to display for the unselected state.
  final IconData icon;

  /// The icon to display for the selected state (optional).
  final IconData? activeIcon;

  /// The text label for this item.
  final String label;

  /// Custom tooltip text.
  ///
  /// If null, the [label] is used.
  final String? tooltip;

  /// Creates a new adaptive bottom navigation bar item.
  const SentientBottomNavigationBarItem({
    required this.icon,
    this.activeIcon,
    required this.label,
    this.tooltip,
  });

  /// Converts this adaptive item to a standard [BottomNavigationBarItem]
  /// with emotion-aware styling applied.
  ///
  /// This method is typically called by a parent widget (like [SentientBottomNavigationBarBuilder])
  /// that has access to the current [EmotionTheme].
  BottomNavigationBarItem toBottomNavigationBarItem(
    EmotionTheme emotionTheme, {
    bool isSelected = false,
  }) {
    // Get emotion-driven item styling from the theme's config.
    final BottomNavigationBarConfig config = emotionTheme.bottomNavigationBarConfig;

    return BottomNavigationBarItem(
      icon: _buildIcon(emotionTheme, config, isSelected, false),
      activeIcon: _buildIcon(emotionTheme, config, isSelected, true),
      label: label,
      tooltip: tooltip ?? label,
    );
  }

  /// Builds an adaptive icon with emotion-aware styling and optional animations.
  Widget _buildIcon(
    EmotionTheme theme,
    BottomNavigationBarConfig config,
    bool isSelected,
    bool isActiveIcon, // whether this is the activeIcon slot
  ) {
    final iconData = isActiveIcon ? (activeIcon ?? icon) : icon;
    final color = isSelected ? config.selectedItemColor : config.unselectedItemColor;

    Widget iconWidget = Icon(
      iconData,
      size: config.iconSize,
      color: color,
    );

    // Add emotion-specific effects for active items if enabled.
    if (theme.animation.allowPlayfulAnimations && isSelected) {
      switch (theme.emotionState) {
        case EmotionState.enjoyment:
          // Add gentle pulse for enjoyment.
          iconWidget = _AnimatedIconWrapper(
            duration: theme.animation.microInteractionDuration,
            curve: Curves.elasticOut,
            scale: 1.1,
            child: iconWidget,
          );
          break;
        case EmotionState.surprise:
          // Add bounce effect for surprise.
          iconWidget = _AnimatedIconWrapper(
            duration: theme.animation.microInteractionDuration,
            curve: Curves.bounceOut,
            scale: 1.15,
            child: iconWidget,
          );
          break;
        default:
          break;
      }
    }

    return iconWidget;
  }
}

/// A simplified wrapper for animated icons to avoid complex state management inline.
class _AnimatedIconWrapper extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final double scale;

  const _AnimatedIconWrapper({
    required this.child,
    required this.duration,
    required this.curve,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1.0, end: scale),
      duration: duration,
      curve: curve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: child,
        );
      },
      child: child,
    );
  }
}

/// A helper widget that builds a list of adaptive navigation items.
///
/// This widget simplifies creating multiple [SentientBottomNavigationBarItem]
/// instances with consistent emotion-aware behavior by handling the
/// conversion decision automatically.
class SentientBottomNavigationBarBuilder extends StatelessWidget {
  /// List of adaptive navigation items to be converted.
  final List<SentientBottomNavigationBarItem> items;

  /// Index of the currently selected item.
  final int currentIndex;

  /// Builder function that receives the converted [BottomNavigationBarItem] list.
  final Widget Function(BuildContext context, List<BottomNavigationBarItem> items)
      builder;

  /// Creates a widget that builds adaptive navigation items.
  const SentientBottomNavigationBarBuilder({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;

    // Convert all items with current emotion theme.
    final bottomNavItems = items.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;

      return item.toBottomNavigationBarItem(
        emotionTheme,
        isSelected: index == currentIndex,
      );
    }).toList();

    return builder(context, bottomNavItems);
  }
}

/// Extension on [List<SentientBottomNavigationBarItem>] for convenience.
extension SentientBottomNavigationBarItemListExtension
    on List<SentientBottomNavigationBarItem> {
  /// Creates a builder widget that converts this list of adaptive items to
  /// standard [BottomNavigationBarItem]s with emotion-aware styling applied.
  Widget toBottomNavigationBarBuilder({
    required int currentIndex,
    required Widget Function(BuildContext context, List<BottomNavigationBarItem> items)
        builder,
  }) {
    return SentientBottomNavigationBarBuilder(
      items: this,
      currentIndex: currentIndex,
      builder: builder,
    );
  }
}
