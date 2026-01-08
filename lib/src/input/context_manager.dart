import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' as math;

import '../../sentient_ui.dart';
import '../models/context_result.dart';
import '../models/network_type.dart';

// --- Manager ---

/// The ContextManager observes and normalizes environmental signals.
///
/// It is PASSIVE and engine-driven. It does not run its own timers.
/// Call [sampleContext] to trigger an update.
class ContextManager extends ChangeNotifier {
  // --- Singleton Setup ---
  static final ContextManager _instance = ContextManager._internal();

  factory ContextManager() => _instance;

  ContextManager._internal();

  // --- State ---
  ContextState _currentState = ContextState.initial();

  // --- Dependencies ---
  final Battery _battery = Battery();
  final Connectivity _connectivity = Connectivity();

  // Sensors and NoiseMeter are accessed on demand or via streams

  /// The current snapshot of environmental context.
  ContextState get currentState => _currentState;

  /// Explicitly samples the current environment context.
  ///
  /// This must be called by the Sentient Engine loop.
  /// It collects real data from sensors and system APIs.
  Future<ContextResult> sampleContext() async {
    final now = DateTime.now();

    // 1. Time Context
    final hour = now.hour;
    final isNight = hour >= 20 || hour <= 6;

    // 2. Battery Context
    double batteryLevel = 1.0;
    bool isCharging = false;
    try {
      final level = await _battery.batteryLevel;
      batteryLevel = level / 100.0; // Normalize 0-100 to 0.0-1.0

      final state = await _battery.batteryState;
      isCharging = state == BatteryState.charging || state == BatteryState.full;
    } catch (e) {
      debugPrint('[ContextManager] Failed to get battery info: $e');
    }

    final isLowBattery = batteryLevel < 0.20;

    // 3. Network Context
    bool isOnline = false;
    NetworkType networkType = NetworkType.unknown;
    try {
      final connectivityResult = await _connectivity.checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.mobile)) {
        networkType = NetworkType.cellular;
        isOnline = true;
      } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
        networkType = NetworkType.wifi;
        isOnline = true;
      } else if (connectivityResult.contains(ConnectivityResult.none)) {
        networkType = NetworkType.offline;
        isOnline = false;
      } else {
        if (connectivityResult.isNotEmpty &&
            !connectivityResult.contains(ConnectivityResult.none)) {
          isOnline = true;
        }
      }
    } catch (e) {
      debugPrint('[ContextManager] Failed to get network info: $e');
    }

    // 4. Motion Context (Sensors Plus)
    //
    // We use the raw accelerometer instead of the user accelerometer.
    // The user accelerometer is often unavailable or emits no data,
    // especially on emulators or stationary devices.
    //
    // Motion is detected using a short sampling window and averaged magnitude.
    bool isMoving = false;

    try {
      final samples = <AccelerometerEvent>[];

      final sub = accelerometerEventStream().listen(
            (event) {
          samples.add(event);
        },
      );

      // Allow sufficient time for sensor to emit data
      await Future.delayed(const Duration(milliseconds: 700));
      await sub.cancel();

      if (samples.isNotEmpty) {
        final avgMagnitude = samples
            .map((e) => math.sqrt(e.x * e.x + e.y * e.y + e.z * e.z))
            .reduce((a, b) => a + b) / samples.length;

        // Gravity ≈ 9.8. Values significantly above indicate movement.
        isMoving = avgMagnitude > 11.0;
      }
    } catch (e) {
      debugPrint('[ContextManager] Failed to get motion info: $e');
    }

    // 5. Noise Context (Noise Meter)
    //
    // NoiseMeter requires a short active listening window.
    // Reading `.first` is unreliable because the stream may not emit immediately.
    double? noiseLevel;
    try {
      if (await Permission.microphone.isGranted) {
        final noiseMeter = NoiseMeter();
        double? latestReading;

        final sub = noiseMeter.noise.listen(
          (event) {
            latestReading = event.meanDecibel;
          },
        );

        // Allow sensor to stabilize and emit data
        await Future.delayed(const Duration(milliseconds: 600));
        await sub.cancel();

        noiseLevel = latestReading;
      }
    } catch (e) {
      debugPrint('[ContextManager] Failed to get noise info: $e');
    }

    final newResult = ContextResult(
      timestamp: now,
      isNight: isNight,
      batteryLevel: batteryLevel,
      isLowBattery: isLowBattery,
      isCharging: isCharging,
      isOnline: isOnline,
      networkType: networkType,
      isMoving: isMoving,
      noiseLevel: noiseLevel,
    );

    // Update state only if changed
    if (_currentState.result != newResult) {
      _currentState = ContextState(result: newResult);
      notifyListeners();
      debugPrint('[ContextManager] Sampled → $newResult');
    }

    debugPrint('[ContextManager] updated with: $newResult');

    return newResult;
  }
}
