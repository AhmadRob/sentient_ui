import 'package:flutter/material.dart';

import 'network_type.dart';

/// Represents a raw snapshot of the current environment and device status.
///
/// This class serves as the source of truth for the [ContextManager].
/// It is pure data with no interpretive logic or UI adaptation rules.
@immutable
class ContextResult {
  // --- Time Context ---
  final DateTime timestamp;
  final bool isNight;

  // --- Device Context ---
  final double batteryLevel; // 0.0 to 1.0
  final bool isLowBattery;   // < 20%
  final bool isCharging;

  // --- Network Context ---
  final bool isOnline;
  final NetworkType networkType;

  // --- Activity Context ---
  final bool? isMoving;
  final double? ambientLight;
  final double? noiseLevel; // Decibel level

  const ContextResult({
    required this.timestamp,
    required this.isNight,
    required this.batteryLevel,
    required this.isLowBattery,
    required this.isCharging,
    required this.isOnline,
    required this.networkType,
    this.isMoving,
    this.ambientLight,
    this.noiseLevel,
  });

  /// Creates a safe default result (e.g., assuming normal conditions).
  factory ContextResult.initial() {
    return ContextResult(
      timestamp: DateTime.now(),
      isNight: false,
      batteryLevel: 1.0,
      isLowBattery: false,
      isCharging: false,
      isOnline: true,
      networkType: NetworkType.unknown,
      isMoving: null,
      ambientLight: null,
      noiseLevel: null,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ContextResult &&
        other.isNight == isNight &&
        other.batteryLevel == batteryLevel &&
        other.isCharging == isCharging &&
        other.isOnline == isOnline &&
        other.networkType == networkType &&
        other.isMoving == isMoving &&
        other.ambientLight == ambientLight &&
        other.noiseLevel == noiseLevel;
  }

  @override
  int get hashCode => Object.hash(
      isNight,
      batteryLevel,
      isCharging,
      isOnline,
      networkType,
      isMoving,
      ambientLight,
      noiseLevel
  );

  @override
  String toString() {
    return 'ContextResult(isNight: $isNight, battery: ${(batteryLevel * 100).toStringAsFixed(1)}%, online: $isOnline, moving: $isMoving, noise: ${noiseLevel?.toStringAsFixed(1)}dB)';
  }
}