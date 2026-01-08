import 'package:flutter/material.dart';

/// Pure data model for behavior state.
/// Stores raw interaction counts and time windows.
/// No emotion logic.
@immutable
class BehaviorState {
  final int tapCount;
  final DateTime timeWindowStart;

  const BehaviorState({
    required this.tapCount,
    required this.timeWindowStart,
  });

  /// Creates an initial, default state.
  factory BehaviorState.initial() => BehaviorState(
    tapCount: 0,
    timeWindowStart: DateTime.now(),
  );

  /// Increments the tap count.
  BehaviorState registerTap() {
    return BehaviorState(
      tapCount: tapCount + 1,
      timeWindowStart: timeWindowStart,
    );
  }

  /// Resets the state if the time window has expired.
  BehaviorState resetIfWindowExpired(Duration window, DateTime now) {
    if (now.difference(timeWindowStart) > window) {
      return BehaviorState(
        tapCount: 0,
        timeWindowStart: now,
      );
    }
    return this;
  }
}