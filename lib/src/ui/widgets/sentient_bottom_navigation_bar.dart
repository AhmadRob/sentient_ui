import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';
import '../../models/emotion_state.dart';

/// A reactive bottom navigation bar that adapts its styling and layout based on the
/// user's emotional state.
///
/// `SentientBottomNavigationBar` functions as a drop-in replacement for Flutter's
/// [BottomNavigationBar] but introduces emotion-aware visual adjustments. It
/// automatically listens to the [AdaptationManager] and rebuilds when the user's
/// emotional state changes.
///
/// This widget adapts properties such as:
/// - **Icon Size:** Larger for high-arousal states (joy, surprise), smaller for low-arousal (sadness).
/// - **Label Visibility:** Hides labels in states like anger or sadness to reduce cognitive load.
/// - **Colors:** Shifts based on the emotional theme (e.g., vibrant for enjoyment, muted for sadness).
/// - **Elevation:** Adjusts depth perception (flatter for anger, raised for surprise).
///
/// ## Features
/// - Emotion-driven styling (colors, sizes, typography).
/// - Automatic state management via [AdaptationManager].
/// - Animated transitions between emotional states.
/// - Consistent with Sentient Adaptation Guidelines.
///
/// ## Example Usage
///
/// ```dart
/// SentientBottomNavigationBar(
///   currentIndex: _selectedIndex,
///   onTap: (index) => setState(() => _selectedIndex = index),
///   items: const [
///     BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
///     BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
///   ],
/// )
/// ```
class SentientBottomNavigationBar extends StatelessWidget {
  /// The index into [items] for the current active item.
  final int currentIndex;

  /// Called when one of the [items] is tapped.
  final ValueChanged<int>? onTap;

  /// The interactive items laid out within the bottom navigation bar.
  final List<BottomNavigationBarItem> items;

  /// The color of the selected item.
  ///
  /// If null, this is determined by the active [EmotionTheme].
  final Color? selectedItemColor;

  /// The color of the unselected item.
  ///
  /// If null, this is determined by the active [EmotionTheme].
  final Color? unselectedItemColor;

  /// The z-coordinate of this [SentientBottomNavigationBar].
  ///
  /// If null, this is determined by the active [EmotionTheme].
  final double? elevation;

  /// An optional configuration to override the emotion-based defaults.
  final BottomNavigationBarConfig? configOverride;

  /// Creates a new adaptive bottom navigation bar.
  const SentientBottomNavigationBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    required this.items,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.elevation,
    this.configOverride,
  });

  @override
  Widget build(BuildContext context) {
    // Listen for emotional changes to trigger rebuilds.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;
    final config = configOverride ?? emotionTheme.bottomNavigationBarConfig;

    return AnimatedContainer(
      duration: emotionTheme.animation.transitionDuration,
      curve: emotionTheme.animation.animationCurve,
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        items: _buildAdaptiveItems(emotionTheme, config),
        selectedItemColor: selectedItemColor ?? config.selectedItemColor,
        unselectedItemColor:
            unselectedItemColor ?? config.unselectedItemColor,
        backgroundColor: config.backgroundColor,
        elevation: elevation ?? config.elevation,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: config.showSelectedLabels,
        showUnselectedLabels: config.showUnselectedLabels,
        selectedFontSize: config.selectedFontSize,
        unselectedFontSize: config.unselectedFontSize,
        iconSize: config.iconSize,
      ),
    );
  }

  /// Rebuilds navigation items to ensure icons respond to emotional sizing changes.
  List<BottomNavigationBarItem> _buildAdaptiveItems(
    EmotionTheme theme,
    BottomNavigationBarConfig config,
  ) {
    return items.map((item) {
      return BottomNavigationBarItem(
        icon: _buildIcon(item.icon, theme, config, false),
        activeIcon:
            _buildIcon(item.activeIcon ?? item.icon, theme, config, true),
        label: item.label,
      );
    }).toList();
  }

  /// Wraps icons to enforce emotion-based sizing constraints.
  Widget _buildIcon(
    Widget? icon,
    EmotionTheme theme,
    BottomNavigationBarConfig config,
    bool isActive,
  ) {
    if (icon == null) return const SizedBox.shrink();

    if (icon is Icon) {
      final originalIcon = icon;
      return Icon(
        originalIcon.icon,
        size: config.iconSize,
        color: isActive
            ? config.selectedItemColor
            : config.unselectedItemColor,
      );
    }

    return Container(
      constraints: BoxConstraints(
        minWidth: config.iconSize,
        minHeight: config.iconSize,
      ),
      child: icon,
    );
  }
}
