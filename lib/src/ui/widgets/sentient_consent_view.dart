import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../sentient_ui.dart';

/// A pre-built user interface for obtaining user consent and configuring Sentient UI.
///
/// This widget is typically displayed on the first launch of the application.
/// It provides a transparent explanation of the privacy-preserving features
/// (Emotion Detection, Context Awareness, Behavior Learning) and allows users
/// to opt-in or opt-out of specific capabilities before the engine initializes.
///
/// Upon completion, it handles:
/// 1.  Requesting the necessary system permissions (Camera, Microphone).
/// 2.  Saving the configuration to persistent storage.
/// 3.  Initializing the [SentientEngine].
class SentientConsentView extends StatefulWidget {
  /// The engine instance to be configured and initialized.
  final SentientEngine engine;

  /// A callback executed when the user completes the setup process.
  ///
  /// This is typically used to navigate to the main application screen.
  final VoidCallback onCompleted;

  /// The sampling interval to be applied to the engine configuration.
  ///
  /// Defaults to 10 seconds.
  final Duration captureInterval;

  /// The initial toggle state for emotion detection.
  final bool initialEmotionEnabled;

  /// The initial toggle state for context sensing.
  final bool initialContextEnabled;

  /// The initial toggle state for behavior tracking.
  final bool initialBehaviorEnabled;

  /// The title displayed at the top of the consent view.
  final String title;

  /// The description text explaining the value proposition and privacy guarantees.
  final String description;

  /// Whether the view should default to dark mode if the system theme cannot be determined.
  final bool initialDarkMode;

  /// Creates a consent view.
  const SentientConsentView({
    super.key,
    required this.engine,
    required this.onCompleted,
    this.captureInterval = const Duration(seconds: 30),
    this.initialEmotionEnabled = true,
    this.initialContextEnabled = true,
    this.initialBehaviorEnabled = true,
    this.title = 'Enable Sentient UI',
    this.description =
        'An interface that understands you. Enable features that adapt to your emotions, environment, and behavior.',
    this.initialDarkMode = true,
  });

  @override
  State<SentientConsentView> createState() => _SentientConsentViewState();
}

class _SentientConsentViewState extends State<SentientConsentView>
    with WidgetsBindingObserver {
  // Feature toggles
  late bool _emotionEnabled;
  late bool _contextEnabled;
  late bool _behaviorEnabled;
  bool _isInitializing = false;

  // Theme state
  late Brightness _systemBrightness;
  bool _useSystemTheme = true;
  late bool _manualDarkMode;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    // Initialize toggles from widget configuration
    _emotionEnabled = widget.initialEmotionEnabled;
    _contextEnabled = widget.initialContextEnabled;
    _behaviorEnabled = widget.initialBehaviorEnabled;

    _manualDarkMode = widget.initialDarkMode;
    _systemBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Monitors system brightness changes to update the UI theme dynamically.
  @override
  void didChangePlatformBrightness() {
    if (!_useSystemTheme) return;

    final newBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    if (newBrightness != _systemBrightness && mounted) {
      setState(() {
        _systemBrightness = newBrightness;
      });
    }
  }

  bool get _isDarkMode =>
      _useSystemTheme ? _systemBrightness == Brightness.dark : _manualDarkMode;

  bool get _anyEnabled =>
      _emotionEnabled || _contextEnabled || _behaviorEnabled;

  Color get _backgroundColor => _isDarkMode ? Colors.black : Colors.white;

  Color get _foregroundColor => _isDarkMode ? Colors.white : Colors.black;

  /// Toggles between system-following theme and manual override.
  void _toggleThemeMode() {
    setState(() {
      if (_useSystemTheme) {
        // Switch to manual, preserving current appearance
        _useSystemTheme = false;
        _manualDarkMode = _systemBrightness == Brightness.dark;
      } else {
        // Revert to system settings
        _useSystemTheme = true;
      }
    });
  }

  /// Toggles between light and dark mode when in manual mode.
  void _toggleDarkMode() {
    if (!_useSystemTheme) {
      setState(() {
        _manualDarkMode = !_manualDarkMode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),

                // Theme Controller
                Align(
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _useSystemTheme ? 'System Theme' : 'Manual Theme',
                        style: TextStyle(
                          fontSize: 10,
                          color: _foregroundColor.withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: _useSystemTheme
                            ? _toggleThemeMode
                            : _toggleDarkMode,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: _foregroundColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: _foregroundColor.withOpacity(0.2),
                            ),
                          ),
                          child: Icon(
                            _useSystemTheme
                                ? Icons.auto_mode_outlined
                                : (_isDarkMode
                                    ? Icons.light_mode_outlined
                                    : Icons.dark_mode_outlined),
                            color: _foregroundColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Title
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    color: _foregroundColor,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                Text(
                  widget.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: _foregroundColor.withOpacity(0.6),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 40),

                // Feature Toggles
                _buildFeatureCard(
                  title: 'Emotion Detection',
                  description: 'Interfaces that respond to how you feel.',
                  icon: Icons.camera_alt_outlined,
                  value: _emotionEnabled,
                  onChanged: (v) => setState(() => _emotionEnabled = v),
                ),
                const SizedBox(height: 16),

                _buildFeatureCard(
                  title: 'Context Awareness',
                  description:
                      'Understands your surroundings through ambient signals.',
                  icon: Icons.mic_outlined,
                  value: _contextEnabled,
                  onChanged: (v) => setState(() => _contextEnabled = v),
                ),
                const SizedBox(height: 16),

                _buildFeatureCard(
                  title: 'Behavior Learning',
                  description: 'Anticipates your needs before you ask.',
                  icon: Icons.touch_app_outlined,
                  value: _behaviorEnabled,
                  onChanged: (v) => setState(() => _behaviorEnabled = v),
                ),

                const SizedBox(height: 32),

                // Privacy Note
                Text(
                  'Your data stays on device. Processed locally, never stored or shared.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: _foregroundColor.withOpacity(0.4),
                  ),
                ),

                const SizedBox(height: 24),

                // Action Button
                _buildButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds a toggleable card for a specific Sentient capability.
  Widget _buildFeatureCard({
    required String title,
    required String description,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _foregroundColor.withOpacity(value ? 0.12 : 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _foregroundColor.withOpacity(value ? 0.25 : 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: _foregroundColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: _foregroundColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: _foregroundColor.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: _foregroundColor,
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Material(
          color: _foregroundColor.withOpacity(0.1),
          child: InkWell(
            onTap: _isInitializing ? null : _handleContinue,
            child: SizedBox(
              height: 56,
              child: Center(
                child: _isInitializing
                    ? CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(_foregroundColor),
                      )
                    : Text(
                        _anyEnabled ? 'Continue' : 'Start Without Adaptation',
                        style: TextStyle(
                          color: _foregroundColor,
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Handles the completion logic: requests permissions, saves config, and notifies parent.
  Future<void> _handleContinue() async {
    setState(() => _isInitializing = true);

    try {
      // 1. Request Permissions based on selection
      if (_emotionEnabled) {
        final status = await Permission.camera.request();
        if (status.isPermanentlyDenied) {
          // Ideally show a dialog here, but for now we proceed
          debugPrint('[SentientConsentView] Camera permission permanently denied.');
        }
      }
      
      if (_contextEnabled) {
        await Permission.microphone.request();
      }

      // 2. Configure and Save Engine State
      await widget.engine.saveAndApplyConfig(
        SentientConfig(
          enableEmotionDetection: _emotionEnabled,
          enableContextSensing: _contextEnabled,
          enableBehaviorTracking: _behaviorEnabled,
          captureInterval: widget.captureInterval,
        ),
      );

      // 3. Complete
      widget.onCompleted();
    } finally {
      if (mounted) {
        setState(() => _isInitializing = false);
      }
    }
  }
}
