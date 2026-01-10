import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../sentient_ui.dart';

/// A wrapper widget that simplifies the integration of Sentient UI into a Flutter application.
///
/// [SentientApp] acts as the root or near-root widget of an application using the Sentient framework.
/// Its primary responsibilities are:
/// 1.  **Initialization**: It creates and initializes the [SentientEngine] singleton.
/// 2.  **Configuration**: It manages the startup configuration (e.g., capture intervals, enabled sensors).
/// 3.  **Dependency Injection**: It sets up [Provider]s for the engine, state manager, and adaptation manager.
/// 4.  **Consent Flow**: It conditionally displays the [SentientConsentView] on the first run to ensure
///     user privacy and permission compliance before the main app loads.
/// 5.  **Theming**: It optionally wraps the application in an [AnimatedEmotionTheme] to provide
///     automatic, emotion-driven UI adaptation.
///
/// Usage:
/// ```dart
/// void main() => runApp(const MyApp());
///
/// class MyApp extends StatelessWidget {
///   @override
///   Widget build(BuildContext context) {
///     return SentientApp(
///       title: 'My App',
///       home: MyHomeScreen(),
///     );
///   }
/// }
/// ```
class SentientApp extends StatefulWidget {
  /// The widget for the default route of the app (Navigator.defaultRouteName, which is /).
  ///
  /// This is the main content of your application that will be shown after the engine is initialized
  /// and permissions are granted.
  final Widget home;

  /// A one-line description used by the device to identify the app for the user.
  ///
  /// Passed directly to the internal [MaterialApp].
  final String? title;

  /// The colors and styles used in the application.
  ///
  /// If [enableEmotionTheming] is true (default), this theme will serve as a baseline or fallback,
  /// but will be overridden by the active adaptive emotion theme at runtime.
  final ThemeData? theme;

  /// Turns on a little "DEBUG" banner in checked mode to indicate that the app is in debug mode.
  final bool debugShowCheckedModeBanner;

  /// Whether to automatically adapt the app's theme based on detected emotions.
  ///
  /// If `true`, the [home] widget is wrapped in an [AnimatedEmotionTheme] that
  /// continuously interpolates the [ThemeData] based on the user's emotional state.
  ///
  /// Defaults to `true`.
  final bool enableEmotionTheming;

  /// The frequency at which the engine samples emotion and context.
  ///
  /// Controls how often the [SentientEngine] runs its main adaptation loop.
  /// Shorter intervals make UI adaptations more responsive to transient emotions,
  /// but increase battery usage. Longer intervals reduce power consumption but
  /// may miss short-lived emotional states.
  ///
  /// **Minimum Interval Enforcement**: Internally, the engine enforces a minimum
  /// of 30 seconds. This ensures the Bayesian filter has enough samples from the
  /// fast emotion loop (5-second intervals) to produce reliable, smoothed
  /// emotion predictions. Providing a shorter value here will be clamped at runtime
  /// without breaking functionality.
  final Duration captureInterval;

  /// Initial state for camera-based emotion detection.
  ///
  /// This value controls the default state of the toggle in the [SentientConsentView].
  /// Users can still disable this feature during the consent flow.
  ///
  /// Defaults to `true`.
  final bool enableEmotionDetection;

  /// Initial state for microphone/sensor-based context sensing.
  ///
  /// This value controls the default state of the toggle in the [SentientConsentView].
  /// Users can still disable this feature during the consent flow.
  ///
  /// Defaults to `true`.
  final bool enableContextSensing;

  /// Initial state for behavior tracking (taps, gestures).
  ///
  /// This value controls the default state of the toggle in the [SentientConsentView].
  /// Users can still disable this feature during the consent flow.
  ///
  /// Defaults to `true`.
  final bool enableBehaviorTracking;

  /// Creates a [SentientApp] wrapper.
  const SentientApp({
    super.key,
    required this.home,
    this.title,
    this.theme,
    this.debugShowCheckedModeBanner = false,
    this.enableEmotionTheming = true,
    this.captureInterval = const Duration(seconds: 30),
    this.enableEmotionDetection = true,
    this.enableContextSensing = true,
    this.enableBehaviorTracking = true,
  });

  @override
  State<SentientApp> createState() => _SentientAppState();
}

/// Internal state management for [SentientApp].
///
/// Handles engine initialization, configuration restoration,
/// and conditional rendering of consent vs. main content.
class _SentientAppState extends State<SentientApp> {
  /// The core engine instance managed by this widget.
  late final SentientEngine _engine;

  /// Indicates whether the engine is currently performing its asynchronous initialization check.
  bool _isInitializing = true;

  @override
  void initState() {
    super.initState();
    // Create the engine instance. Note that actual sensor access does not begin
    // until initialize() is called successfully (which happens after consent).
    _engine = SentientEngine();
    _initializeEngine();
  }

  /// Internal: Checks for existing configuration and attempts to restore the engine state.
  ///
  /// If a valid configuration exists (user previously consented), the engine
  /// initializes immediately and the main app content will display.
  /// If no prior consent is found (first run), the engine remains uninitialized,
  /// triggering the [SentientConsentView] for permission and configuration input.
  ///
  /// Once the check is complete, [_isInitializing] is set to `false` to stop showing
  /// the loading spinner.
  Future<void> _initializeEngine() async {
    // Attempt to restore configuration (e.g., from SharedPreferences).
    // If a valid config exists (user previously consented), the engine initializes immediately.
    // If not (first run), it remains uninitialized, triggering the consent view.
    await _engine.restoreConfig();

    if (mounted) {
      setState(() {
        _isInitializing = false;
      });
    }
  }

  /// Releases engine resources when the app is disposed.
  ///
  /// This ensures camera and microphone access are properly
  /// terminated when the widget tree is destroyed.
  @override
  void dispose() {
    // Ensure the engine releases camera/microphone resources when the app is shut down.
    _engine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Loading State: Show a spinner while checking persistence.
    // This prevents a flash of the consent screen if the user is already authorized.
    if (_isInitializing) {
      return MaterialApp(
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        title: widget.title ?? '',
        theme: widget.theme,
        home: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(Colors.white10),
            ),
          ),
        ),
      );
    }

    // 2. Active State: Wrap the app with necessary Providers.
    // This ensures that any widget in the tree (including the Consent View)
    // can access the engine and its managers.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _engine),
        ChangeNotifierProvider.value(value: _engine.stateManager),
        ChangeNotifierProvider.value(value: _engine.adaptationManager),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
        title: widget.title ?? '',
        theme: widget.theme,
        // The home widget depends on the engine's initialization status.
        home: Consumer<SentientEngine>(
          builder: (context, engine, child) {
            // 3. Initialized: Show the main app content.
            if (engine.isInitialized) {
              // Optionally wrap with emotion theming logic.
              if (widget.enableEmotionTheming &&
              (engine.config.enableEmotionDetection ||
              engine.config.enableContextSensing ||
              engine.config.enableBehaviorTracking)) {
                return _buildEmotionThemedHome();
              }
              return widget.home;
            }

            // 4. Uninitialized: Show the Consent View.
            // This view handles permission requests and engine configuration.
            return SentientConsentView(
              engine: engine,
              onCompleted: () {
                // The engine is initialized internally by the consent view.
                // This callback runs after initialization is complete.
                // The Consumer will rebuild automatically due to the engine's notifyListeners().
              },
            );
          },
        ),
      ),
    );
  }

  /// Internal: Wraps the home widget with emotion-adaptive theming.
  ///
  /// Returns a [Theme] widget that updates dynamically based on the current
  /// emotional state from [AdaptationManager]. The [AnimatedEmotionTheme]
  /// interpolates between themes smoothly, providing subtle emotion-driven
  /// UI adaptations without abrupt changes.
  ///
  /// This method is only used internally when [enableEmotionTheming] is `true`.
  Widget _buildEmotionThemedHome() {
    return Consumer<AdaptationManager>(
      builder: (context, adaptationManager, _) {
        return AnimatedEmotionTheme(
          data: adaptationManager.currentTheme,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          child: Builder(
            builder: (context) {
              // Access the interpolated theme from the context
              final emotionTheme = context.watch<EmotionTheme>();
              return Theme(
                data: emotionTheme.toThemeData(),
                child: widget.home,
              );
            },
          ),
        );
      },
    );
  }
}
