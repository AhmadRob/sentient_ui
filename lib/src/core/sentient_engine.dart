import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../input/behavior_tracker.dart';
import '../input/context_manager.dart';
import '../input/emotion_detector.dart';

/// The central orchestrator of the Sentient UI framework.
///
/// [SentientEngine] manages the entire lifecycle of the emotion-adaptive pipeline.
/// It coordinates:
/// 1.  **Input Processing**: Sampling data from the [EmotionDetector], [BehaviorTracker], and [ContextManager].
/// 2.  **State Management**: Updating the central [StateManager] with normalized results.
/// 3.  **Adaptation**: Triggering UI changes via the [AdaptationManager].
/// 4.  **Configuration**: Persisting and enforcing user preferences and constraints.
///
/// This class follows the Singleton or "Single Service" pattern within an application lifecycle.
/// It must be initialized via [initialize] or [restoreConfig] before the capture loop begins.
class SentientEngine extends ChangeNotifier {
  // --- Service Dependencies ---
  final EmotionDetector _emotionDetector = EmotionDetector();
  final BehaviorTracker _behaviorTracker = BehaviorTracker();
  final ContextManager _contextManager = ContextManager();
  final StateManager stateManager = StateManager();
  
  /// Manages the translation of emotional states into concrete UI themes and behaviors.
  late final AdaptationManager adaptationManager;

  // --- Internal State ---
  CameraController? _cameraController;
  Timer? _captureTimer;
  bool _isInitialized = false;
  bool _isProcessing = false;
  bool _isPaused = false;
  
  // --- Configuration ---
  SentientConfig _config = const SentientConfig();
  final ResolutionPreset _resolution = ResolutionPreset.medium;
  final double _confidenceThreshold = 0.2;

  // --- Constants (Persistence Keys) ---
  static const String _keyConsented = 'sentient_consented';
  static const String _keyEnableEmotion = 'sentient_enable_emotion';
  static const String _keyEnableContext = 'sentient_enable_context';
  static const String _keyEnableBehavior = 'sentient_enable_behavior';
  static const String _keyCaptureIntervalSeconds = 'sentient_capture_interval_seconds';

  // --- Public Getters ---
  
  /// The active camera controller, or null if vision is disabled or not yet initialized.
  CameraController? get cameraController => _cameraController;

  /// Returns `true` if the camera is fully initialized and ready to capture frames.
  bool get isCameraReady =>
      _cameraController != null && _cameraController!.value.isInitialized;

  /// Returns `true` if the engine has completed its initialization sequence.
  bool get isInitialized => _isInitialized;

  /// Returns `true` if the capture loop is manually paused.
  bool get isPaused => _isPaused;

  /// Access to the behavior tracking subsystem.
  BehaviorTracker get behaviorTracker => _behaviorTracker;

  /// Access to the context sensing subsystem.
  ContextManager get contextManager => _contextManager;
  
  /// The current runtime configuration.
  SentientConfig get config => _config;

  /// Creates a new Sentient Engine instance.
  ///
  /// Note: The engine does not start processing until [initialize] or [restoreConfig] is called.
  SentientEngine() {
    // The AdaptationManager depends on the StateManager for real-time updates.
    adaptationManager = AdaptationManager(stateManager);
  }

  /// Attempts to restore the engine's configuration from persistent storage.
  ///
  /// This is typically called on app startup to determine if the user has already consented
  /// to data collection and configured their preferences.
  ///
  /// Returns `true` if a valid configuration was found and the engine successfully initialized.
  /// Returns `false` if no configuration exists (indicating a first-run scenario).
  Future<bool> restoreConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasConsented = prefs.getBool(_keyConsented) ?? false;

      if (hasConsented) {
        final intervalSeconds = prefs.getInt(_keyCaptureIntervalSeconds) ?? 10;
        
        final restoredConfig = SentientConfig(
          enableEmotionDetection: prefs.getBool(_keyEnableEmotion) ?? true,
          enableContextSensing: prefs.getBool(_keyEnableContext) ?? true,
          enableBehaviorTracking: prefs.getBool(_keyEnableBehavior) ?? true,
          captureInterval: Duration(seconds: intervalSeconds),
        );
        
        // Initialize with the restored config
        await initialize(config: restoredConfig);
        return true;
      }
    } catch (e) {
      debugPrint('[SentientEngine] Failed to restore config: $e');
    }
    return false;
  }

  /// Saves the provided configuration to persistent storage and applies it immediately.
  ///
  /// This method is used during the initial consent flow or when the user updates settings.
  /// It persists the consent flag and feature toggles, then (re)initializes the engine.
  Future<void> saveAndApplyConfig(SentientConfig config) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyConsented, true);
      await prefs.setBool(_keyEnableEmotion, config.enableEmotionDetection);
      await prefs.setBool(_keyEnableContext, config.enableContextSensing);
      await prefs.setBool(_keyEnableBehavior, config.enableBehaviorTracking);
      await prefs.setInt(_keyCaptureIntervalSeconds, config.captureInterval.inSeconds);
      
      // Apply the new config immediately.
      if (_isInitialized) {
        updateConfig(config);
      } else {
        await initialize(config: config);
      }
    } catch (e) {
      debugPrint('[SentientEngine] Failed to save config: $e');
      // Attempt to initialize even if persistence fails to ensure app functionality.
      if (!_isInitialized) await initialize(config: config);
    }
  }

  /// Initializes the engine, requests necessary permissions, and starts the capture loop.
  ///
  /// This method respects the provided (or current) [SentientConfig].
  /// - If `enableEmotionDetection` is false, it skips camera initialization.
  /// - If `enableContextSensing` is false, it skips microphone permission requests.
  ///
  /// [config] - An optional configuration to apply before initialization.
  Future<void> initialize({SentientConfig? config}) async {
    if (_isInitialized) return;
    
    if (config != null) {
      _config = config;
    }

    try {
      // 0. Initialize core subsystems
      await _emotionDetector.initialize();
      
      // 1. Setup Camera (Emotion Detection) - Only if enabled in config
      if (_config.enableEmotionDetection) {
        final cameraStatus = await Permission.camera.request();
        
        if (cameraStatus.isGranted) {
          final cameras = await availableCameras();
          if (cameras.isNotEmpty) {
            // Prefer the front-facing camera for face detection
            final frontCamera = cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
              orElse: () => cameras.first,
            );

            _cameraController = CameraController(
              frontCamera, 
              _resolution,
              enableAudio: false, // Audio is handled separately by ContextManager
              imageFormatGroup: ImageFormatGroup.jpeg
            );

            await _cameraController!.initialize();
          } else {
            debugPrint('[SentientEngine] No cameras found on device.');
          }
        } else {
          debugPrint('[SentientEngine] Camera permission denied. Vision features disabled.');
        }
      }

      // 2. Setup Context (Microphone/Sensors) - Only if enabled in config
      if (_config.enableContextSensing) {
        final micStatus = await Permission.microphone.request();
        if (!micStatus.isGranted) {
          debugPrint('[SentientEngine] Microphone permission denied. Noise context will be unavailable.');
        }
      }

      // 3. Start the Engine Loop
      // We mark initialized as true even if sensors failed, allowing 
      // other subsystems (Behavior, fallback logic) to operate.
      _isInitialized = true;
      _startPeriodicCapture();

      notifyListeners();
      debugPrint('SentientEngine initialized (Vision: ${_config.enableEmotionDetection && isCameraReady ? "Enabled" : "Disabled"}, Interval: ${_config.captureInterval.inSeconds}s).');

    } catch (e) {
      debugPrint('Failed to initialize SentientEngine: $e');
    }
  }
  
  /// Updates the engine configuration at runtime.
  ///
  /// If the [captureInterval] changes, the internal timer is restarted automatically.
  void updateConfig(SentientConfig newConfig) {
    // Check if the interval changed to determine if we need to restart the timer.
    final bool intervalChanged = _config.captureInterval != newConfig.captureInterval;
    
    _config = newConfig;
    notifyListeners();
    debugPrint('[SentientEngine] Configuration updated: $_config');
    
    if (intervalChanged && _isInitialized) {
      _startPeriodicCapture();
    }
  }

  /// Starts the periodic timer that triggers [captureAndProcess].
  void _startPeriodicCapture() {
    _captureTimer?.cancel();
    _captureTimer = Timer.periodic(_config.captureInterval, (_) {
      if (!_isProcessing && !_isPaused) {
        _captureAndProcess();
      }
    });
  }

  /// Pauses the automatic capture loop.
  ///
  /// Useful for testing, saving battery when the app is backgrounded, 
  /// or when manual control is required.
  void pause() {
    _isPaused = true;
    notifyListeners();
  }

  /// Resumes the automatic capture loop.
  void resume() {
    _isPaused = false;
    notifyListeners();
  }

  /// The core logic loop executed at every interval.
  ///
  /// This method performs the following steps sequentially:
  /// 1. Samples environmental context (if enabled).
  /// 2. Analyzes user behavior (if enabled).
  ///    - If a strong behavioral signal (e.g., rage tap) is found, it bypasses vision analysis.
  /// 3. Captures and analyzes a camera frame (if enabled).
  ///    - This step is skipped if battery is low (<= 25%).
  Future<void> _captureAndProcess() async {
    _isProcessing = true;
    try {
      // 1. Context Sampling
      if (_config.enableContextSensing) {
         await _contextManager.sampleContext();
      }

      // 2. Behavior-First Analysis
      // Behavioral signals (like aggressive tapping) are treated as high-priority
      // overrides that can short-circuit the more expensive vision analysis.
      if (_config.enableBehaviorTracking) {
        final behavioralResult = _behaviorTracker.analyze();
        if (behavioralResult != null) {
          final emotionResult = EmotionResult(
            dominantEmotion: behavioralResult.detectedEmotion,
            confidence: behavioralResult.confidence,
            probabilities: {
              behavioralResult.detectedEmotion: behavioralResult.confidence
            },
            timestamp: DateTime.now(),
          );
          stateManager.updateEmotion(emotionResult);
          return; // Stop processing; behavior takes precedence.
        }
      } 

      // 3. Vision Analysis
      
      // Check Developer Intent
      if (!_config.enableEmotionDetection) {
        return;
      }
      
      // Battery Safeguard: Prevent camera usage on low battery to preserve power.
      final currentContext = _contextManager.currentState.result;
      if (currentContext.batteryLevel <= 0.20) {
        debugPrint('[SentientEngine] Emotion detection skipped (low battery: ${(currentContext.batteryLevel * 100).toStringAsFixed(0)}%)');
        return;
      }

      // Capture and Analyze Frame
      if (isCameraReady) {
        final imageFile = await _cameraController!.takePicture();
        final bytes = await imageFile.readAsBytes();
        
        // Decoding happens in an isolate to avoid blocking the UI thread.
        final image = await compute(img.decodeImage, bytes);

        if (image != null) {
          final rawResult = _emotionDetector.detect(image,
              confidenceThreshold: _confidenceThreshold);

          if (rawResult != null) {
            stateManager.updateEmotion(rawResult);
          }
        }
      }
    } catch (e) {
      debugPrint('Error during capture and process: $e');
    } finally {
      _isProcessing = false;
    }
  }

  @override
  Future<void> dispose() async {
    _captureTimer?.cancel();
    await _cameraController?.dispose();
    _emotionDetector.dispose();
    adaptationManager.dispose();
    _contextManager.dispose();
    _isInitialized = false;
    super.dispose();
    debugPrint('SentientEngine disposed.');
  }
}
