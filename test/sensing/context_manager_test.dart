import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/src/input/context_manager.dart';
import 'package:sentient_ui/sentient_ui.dart';

void main() {
  group('ContextManager and ContextResult Tests', () {
    test('ContextResult.initial() provides sensible defaults', () {
      final initial = ContextResult.initial();
      
      expect(initial.isNight, isFalse);
      expect(initial.batteryLevel, 1.0);
      expect(initial.isLowBattery, isFalse);
      expect(initial.isOnline, isTrue);
      expect(initial.networkType, NetworkType.unknown);
    });

    test('ContextResult equality and hashcode', () {
      final now = DateTime.now();
      final r1 = ContextResult(
        timestamp: now,
        isNight: true,
        batteryLevel: 0.5,
        isLowBattery: false,
        isCharging: true,
        isOnline: true,
        networkType: NetworkType.wifi,
      );

      final r2 = ContextResult(
        timestamp: now,
        isNight: true,
        batteryLevel: 0.5,
        isLowBattery: false,
        isCharging: true,
        isOnline: true,
        networkType: NetworkType.wifi,
      );

      expect(r1, equals(r2));
      expect(r1.hashCode, equals(r2.hashCode));
    });

    test('ContextManager is a singleton', () {
      final m1 = ContextManager();
      final m2 = ContextManager();
      expect(identical(m1, m2), isTrue);
    });

    test('ContextManager initial state is valid', () {
      final manager = ContextManager();
      expect(manager.currentState.result, isNotNull);
      expect(manager.currentState.result.isOnline, isTrue);
    });
  });
}
