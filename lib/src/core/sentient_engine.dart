import 'dart:async';
import 'dart:math';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;
import 'package:permission_handler/permission_handler.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../input/behavior_tracker.dart';
import '../input/context_manager.dart';
import '../input/emotion_detector.dart';
import '../processing/bayesian_filter.dart';

/// The central orchestrator of the Sentient UI framework.
///
/// [SentientEngine] manages the entire lifecycle of the emotion-adaptive pipeline.
/// Responsibilities:
/// 1. **Input Processing**: Sampling data from [EmotionDetector], [BehaviorTracker], [ContextManager].
/// 2. **State Management**: Updating [StateManager] with normalized results.
/// 3. **Adaptation**: Triggering UI changes via [AdaptationManager].
/// 4. **Configuration**: Persisting and enforcing user preferences.
///
/// Follows the Singleton/Single Service pattern. Must be initialized via
/// [initialize] or [restoreConfig] before starting capture loops.
class SentientEngine extends ChangeNotifier {
  // --- Core Subsystems ---
  final EmotionDetector _emotionDetector = EmotionDetector();
  final BehaviorTracker _behaviorTracker = BehaviorTracker();
  final ContextManager _contextManager = ContextManager();
  final StateManager stateManager = StateManager();
  final BayesianFilter _bayesianFilter = BayesianFilter();
  late final AdaptationManager adaptationManager;

  // --- Internal State ---
  CameraController? _cameraController;
  Timer? _adaptationTimer;
  Timer? _fastEmotionTimer;
  bool _isInitialized = false;
  bool _isProcessing = false;
  bool _isPaused = false;

  // --- Configuration ---
  SentientConfig _config = SentientConfig();
  final ResolutionPreset _resolution = ResolutionPreset.medium;
  final double _confidenceThreshold = 0.4;

  // --- Persistence Keys ---
  static const String _keyConsented = 'sentient_consented';
  static const String _keyEnableEmotion = 'sentient_enable_emotion';
  static const String _keyEnableContext = 'sentient_enable_context';
  static const String _keyEnableBehavior = 'sentient_enable_behavior';
  static const String _keyCaptureIntervalSeconds = 'sentient_capture_interval_seconds';

  // --- Public Getters ---
  CameraController? get cameraController => _cameraController;
  bool get isCameraReady => _cameraController?.value.isInitialized ?? false;
  bool get isInitialized => _isInitialized;
  bool get isPaused => _isPaused;
  BehaviorTracker get behaviorTracker => _behaviorTracker;
  ContextManager get contextManager => _contextManager;
  SentientConfig get config => _config;

  /// Constructor.
  ///
  /// The AdaptationManager depends on the StateManager for real-time updates.
  SentientEngine() {
    adaptationManager = AdaptationManager(stateManager);
  }

  /// Attempts to restore configuration from persistent storage.
  ///
  /// Returns `true` if a valid config was restored, otherwise `false`.
  Future<bool> restoreConfig() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final hasConsented = prefs.getBool(_keyConsented) ?? false;

      if (!hasConsented) return false;

      final intervalSeconds = prefs.getInt(_keyCaptureIntervalSeconds) ?? 30;
      final clampedInterval = intervalSeconds < 30 ? 30 : intervalSeconds;

      final restoredConfig = SentientConfig(
        enableEmotionDetection: prefs.getBool(_keyEnableEmotion) ?? true,
        enableContextSensing: prefs.getBool(_keyEnableContext) ?? true,
        enableBehaviorTracking: prefs.getBool(_keyEnableBehavior) ?? true,
        captureInterval: Duration(seconds: clampedInterval),
      );

      await initialize(config: restoredConfig);
      return true;
    } catch (e) {
      debugPrint('[SentientEngine] Failed to restore config: $e');
      return false;
    }
  }

  /// Saves configuration to persistent storage and applies it immediately.
  Future<void> saveAndApplyConfig(SentientConfig config) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyConsented, true);
      await prefs.setBool(_keyEnableEmotion, config.enableEmotionDetection);
      await prefs.setBool(_keyEnableContext, config.enableContextSensing);
      await prefs.setBool(_keyEnableBehavior, config.enableBehaviorTracking);
      await prefs.setInt(
          _keyCaptureIntervalSeconds, max(30, config.captureInterval.inSeconds));

      if (_isInitialized) {
        updateConfig(config);
      } else {
        await initialize(config: config);
      }
    } catch (e) {
      debugPrint('[SentientEngine] Failed to save config: $e');
      if (!_isInitialized) await initialize(config: config);
    }
  }

  /// Initializes the engine, requests permissions, and starts capture loops.
  Future<void> initialize({SentientConfig? config}) async {
    if (_isInitialized) return;

    if (config != null) _config = config;

    try {
      // --- Initialize core subsystems ---
      await _emotionDetector.initialize();

      // --- Camera Setup ---
      if (_config.enableEmotionDetection) {
        final cameraStatus = await Permission.camera.request();
        if (cameraStatus.isGranted) {
          final cameras = await availableCameras();
          final frontCamera = cameras.firstWhere(
                (c) => c.lensDirection == CameraLensDirection.front,
            orElse: () => cameras.first,
          );

          _cameraController = CameraController(
            frontCamera,
            _resolution,
            enableAudio: false,
            imageFormatGroup: ImageFormatGroup.jpeg,
          );
          await _cameraController!.initialize();
        } else {
          debugPrint('[SentientEngine] Camera permission denied.');
        }
      }

      // --- Context Setup ---
      if (_config.enableContextSensing) {
        final micStatus = await Permission.microphone.request();
        if (!micStatus.isGranted) {
          debugPrint('[SentientEngine] Microphone permission denied.');
        }
      }

      // --- Start Loops ---
      _isInitialized = true;
      _startFastEmotionLoop();
      _startAdaptationLoop();

      notifyListeners();
      debugPrint(
          'SentientEngine initialized (Vision: ${_config.enableEmotionDetection && isCameraReady ? "Enabled" : "Disabled"}, Adaptation Interval: ${_config.captureInterval.inSeconds}s, Fast Loop: 5s)');
    } catch (e) {
      debugPrint('[SentientEngine] Initialization failed: $e');
    }
  }

  /// Updates engine configuration at runtime.
  void updateConfig(SentientConfig newConfig) {
    final intervalChanged = _config.captureInterval != newConfig.captureInterval;

    // Ensure the minimum 30s interval rule
    final clampedConfig = newConfig.captureInterval.inSeconds < 30
        ? newConfig.copyWith(captureInterval: const Duration(seconds: 30))
        : newConfig;

    _config = clampedConfig;
    notifyListeners();
    debugPrint('[SentientEngine] Configuration updated: $_config');

    if (intervalChanged && _isInitialized) _startAdaptationLoop();
  }

  /// Starts the main adaptation loop (minimum 30s interval).
  void _startAdaptationLoop() {
    _adaptationTimer?.cancel();

    final interval = _config.captureInterval.inSeconds < 30
        ? const Duration(seconds: 30)
        : _config.captureInterval;

    _adaptationTimer = Timer.periodic(interval, (_) async {
      if (!_isProcessing && !_isPaused) await _applyAdaptation();
    });
  }

  /// Starts the fast emotion sampling loop (every 5 seconds).
  void _startFastEmotionLoop() {
    _fastEmotionTimer?.cancel();
    _fastEmotionTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
      if (!_isPaused) await _collectEmotionData();
    });
  }

  /// Collects emotion data and updates the Bayesian filter.
  Future<void> _collectEmotionData() async {
    try {
      if (!_config.enableEmotionDetection || !isCameraReady) return;

      final context = _contextManager.currentState.result;
      if (context.batteryLevel <= 0.20) return;

      final imageFile = await _cameraController!.takePicture();
      final bytes = await imageFile.readAsBytes();
      final image = await compute(img.decodeImage, bytes);

      if (image != null) {
        final rawResult =
        _emotionDetector.detect(image, confidenceThreshold: _confidenceThreshold);
        if (rawResult != null) {
          _bayesianFilter.update(rawResult.probabilities);
          debugPrint(
              '🧪 [FastLoop] Updated Bayesian Filter: ${_bayesianFilter.currentEmotion.name}');
        }
      }
    } catch (e) {
      debugPrint('[SentientEngine] Fast loop error: $e');
    }
  }

  /// Applies UI adaptation using the smoothed emotion from the Bayesian filter.
  Future<void> _applyAdaptation() async {
    _isProcessing = true;
    try {
      if (_config.enableContextSensing) await _contextManager.sampleContext();

      if (_config.enableBehaviorTracking) {
        final behaviorResult = _behaviorTracker.analyze();
        if (behaviorResult != null) {
          debugPrint(
              '⚡ [SentientEngine] BEHAVIORAL Override: ${behaviorResult.detectedEmotion.name}');
          final result = EmotionResult(
            dominantEmotion: behaviorResult.detectedEmotion,
            confidence: behaviorResult.confidence,
            probabilities: {behaviorResult.detectedEmotion: behaviorResult.confidence},
            timestamp: DateTime.now(),
          );
          stateManager.updateEmotion(result);
          return;
        }
      }

      final smoothedEmotion = _bayesianFilter.currentEmotion;
      final smoothedConfidence =
          _bayesianFilter.probabilities[smoothedEmotion] ?? 0.0;

      final filteredResult = EmotionResult(
        dominantEmotion: smoothedEmotion,
        confidence: smoothedConfidence,
        probabilities: _bayesianFilter.probabilities,
        timestamp: DateTime.now(),
      );

      debugPrint(
          '🎨 [AdaptationLoop] Applying Adaptation: ${smoothedEmotion.name} (${(smoothedConfidence * 100).toStringAsFixed(1)}%)');

      stateManager.updateEmotion(filteredResult);
    } catch (e) {
      debugPrint('[SentientEngine] Adaptation loop error: $e');
    } finally {
      _isProcessing = false;
    }
  }

  /// Pauses all loops.
  void pause() {
    _isPaused = true;
    notifyListeners();
  }

  /// Resumes all loops.
  void resume() {
    _isPaused = false;
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    _adaptationTimer?.cancel();
    _fastEmotionTimer?.cancel();
    await _cameraController?.dispose();
    _emotionDetector.dispose();
    adaptationManager.dispose();
    _contextManager.dispose();
    _isInitialized = false;
    super.dispose();
    debugPrint('[SentientEngine] Disposed.');
  }
}
