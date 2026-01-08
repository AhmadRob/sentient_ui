import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../sentient_ui.dart';

/// A reactive gesture detector that adapts its feedback behavior based on the
/// user's emotional state AND automatically reports user interactions to the
/// [BehaviorTracker] to help infer emotions like anger or sadness.
///
/// `SentientGestureDetector` is the core interaction widget of the Sentient UI.
/// It wraps Flutter's [GestureDetector] and [Listener] to provide a zero-config
/// way to track behavior (tap frequency) across the app.
///
/// ## Automatic Behavior Tracking
/// Any widget wrapped in this detector will automatically report:
/// - Taps (via PointerDown events) to the [BehaviorTracker].
///
/// ## Adaptive Feedback
/// It also uses values from the active [EmotionTheme] to determine optimal
/// interaction timing, visual feedback animations, and haptic response intensity.
///
/// ## Example Usage
///
/// Basic usage (tracking is automatic):
/// ```dart
/// SentientGestureDetector(
///   onTap: () => print('Tapped'),
///   child: Container(
///     child: Text('Tap me'),
///   ),
/// )
/// ```
class SentientGestureDetector extends StatefulWidget {
  /// The widget below this widget in the tree.
  final Widget child;

  /// Called when the user taps the widget.
  final GestureTapCallback? onTap;

  /// Called when the user double taps the widget.
  final GestureTapCallback? onDoubleTap;

  /// Called when the user long presses the widget.
  final GestureLongPressCallback? onLongPress;

  /// Called when the user starts dragging the widget.
  final GestureDragStartCallback? onPanStart;

  /// Called when the user updates the drag.
  final GestureDragUpdateCallback? onPanUpdate;

  /// Called when the user ends the drag.
  final GestureDragEndCallback? onPanEnd;

  /// Whether to enable haptic feedback.
  final bool? enableHapticFeedback;

  /// Whether to enable visual feedback.
  final bool? enableVisualFeedback;

  /// An optional configuration to override the emotion-based defaults.
  final GestureDetectorConfig? configOverride;

  /// Creates a new adaptive gesture detector.
  const SentientGestureDetector({
    super.key,
    required this.child,
    this.onTap,
    this.onDoubleTap,
    this.onLongPress,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.enableHapticFeedback,
    this.enableVisualFeedback,
    this.configOverride,
  });

  @override
  State<SentientGestureDetector> createState() =>
      _SentientGestureDetectorState();
}

class _SentientGestureDetectorState extends State<SentientGestureDetector>
    with TickerProviderStateMixin {
  late AnimationController _feedbackController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _feedbackController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _feedbackController, curve: Curves.easeInOut),
    );
    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(parent: _feedbackController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Get the Sentient Engine's services.
    // We only need the tracker to register taps.
    final engine = context.read<SentientEngine>();
    final behaviorTracker = engine.behaviorTracker;

    // 2. Get theme configuration.
    final adaptationManager = context.watch<AdaptationManager>();
    final emotionTheme = adaptationManager.currentTheme;
    final config = widget.configOverride ?? emotionTheme.gestureDetectorConfig;

    _updateAnimationForConfig(config);
    _updateTweens(config);

    // 3. Wrap everything in a Listener to capture raw pointer events for global tracking.
    // We use HitTestBehavior.translucent to ensure we catch events even if 
    // the child or the GestureDetector doesn't fully consume them or has gaps.
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        // Global tracking: Register a tap/interaction attempt.
        behaviorTracker.registerTap();
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque, // Ensures the detector itself has a hit test region
        onTap: () {
          _handleGesture('tap', emotionTheme, config, widget.onTap);
        },
        onDoubleTap: () {
          _handleGesture('double_tap', emotionTheme, config, widget.onDoubleTap);
        },
        onLongPress: () => _handleGesture(
            'long_press', emotionTheme, config, widget.onLongPress),
        onPanStart: (details) => _handleGesture('pan_start', emotionTheme, config,
            () => widget.onPanStart?.call(details)),
        onPanUpdate: (details) => _handleGesture('pan_update', emotionTheme,
            config, () => widget.onPanUpdate?.call(details)),
        onPanEnd: (details) => _handleGesture('pan_end', emotionTheme, config,
            () => widget.onPanEnd?.call(details)),
        child: _buildChildWithFeedback(config),
      ),
    );
  }

  void _updateTweens(GestureDetectorConfig config) {
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: config.visualScaleFactor).animate(
      CurvedAnimation(parent: _feedbackController, curve: Curves.easeInOut),
    );
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: config.visualOpacityFactor).animate(
      CurvedAnimation(parent: _feedbackController, curve: Curves.easeInOut),
    );
  }

  Widget _buildChildWithFeedback(GestureDetectorConfig config) {
    final enableVisual =
        widget.enableVisualFeedback ?? config.enableVisualFeedback;

    if (!enableVisual) {
      return widget.child;
    }

    return AnimatedBuilder(
      animation: Listenable.merge([_scaleAnimation, _opacityAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }

  void _updateAnimationForConfig(GestureDetectorConfig config) {
    if (_feedbackController.duration != config.feedbackDuration) {
      _feedbackController.duration = config.feedbackDuration;
    }
  }

  void _handleGesture(String gestureType, EmotionTheme theme,
      GestureDetectorConfig config, VoidCallback? callback) {
    callback?.call();
    _applyFeedback(gestureType, theme, config);
  }

  void _applyFeedback(
      String gestureType, EmotionTheme theme, GestureDetectorConfig config) {
    final enableHaptic =
        widget.enableHapticFeedback ?? config.enableHapticFeedback;
    final enableVisual =
        widget.enableVisualFeedback ?? config.enableVisualFeedback;

    if (enableVisual) {
      _feedbackController.forward().then((_) {
        _feedbackController.reverse();
      });
    }

    if (enableHaptic) {
      _applyHapticFeedback(gestureType, theme);
    }
  }

  void _applyHapticFeedback(String gestureType, EmotionTheme theme) {
    if (!theme.feedbackConfig.enableSoundFeedback) return;

    switch (theme.emotionState) {
      case EmotionState.anger:
        // In high-arousal negative states, reduce sensory load
        break;
      case EmotionState.disgust:
      case EmotionState.fear:
      case EmotionState.sadness:
      case EmotionState.neutral:
        if (gestureType == 'tap') {
          HapticFeedback.lightImpact();
        }
        break;
      case EmotionState.enjoyment:
      case EmotionState.surprise:
        switch (gestureType) {
          case 'tap':
            HapticFeedback.mediumImpact();
            break;
          case 'double_tap':
            HapticFeedback.heavyImpact();
            break;
          case 'long_press':
            HapticFeedback.selectionClick();
            break;
        }
        break;
    }
  }
}

/// A specialized version of [SentientGestureDetector] for tap gestures only.
class SentientTapDetector extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final bool? enableHapticFeedback;
  final bool? enableVisualFeedback;

  const SentientTapDetector({
    super.key,
    required this.child,
    this.onTap,
    this.enableHapticFeedback,
    this.enableVisualFeedback,
  });

  @override
  Widget build(BuildContext context) {
    return SentientGestureDetector(
      onTap: onTap,
      enableHapticFeedback: enableHapticFeedback,
      enableVisualFeedback: enableVisualFeedback,
      child: child,
    );
  }
}
