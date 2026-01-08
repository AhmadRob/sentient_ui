import 'package:flutter/material.dart';

/// A deprecated scroll observer widget.
///
/// **Note:** Scroll tracking functionality has been disabled in the current version
/// of the Sentient UI framework. This widget currently acts as a simple pass-through
/// wrapper and does not perform any active scroll monitoring or adaptation.
///
/// It is retained for backward compatibility to prevent breaking changes in existing
/// implementations that rely on this widget's presence in the tree.
///
/// ## Future Plans
/// - May be reintroduced with optimized scroll tracking decision in a future release.
/// - Currently safe to remove if not needed.
///
/// ## Example Usage
///
/// ```dart
/// SentientScrollObserver(
///   child: ListView(
///     children: [ ... ],
///   ),
/// )
/// ```
@Deprecated('Scroll tracking is currently disabled. Use the child widget directly.')
class SentientScrollObserver extends StatelessWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// Creates a pass-through scroll observer.
  const SentientScrollObserver({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
