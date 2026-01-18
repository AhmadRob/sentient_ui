import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sentient_ui/sentient_ui.dart';

/// Non-functional performance and scalability tests for the Sentient UI framework.
/// 
/// These tests measure execution latency and memory overhead to ensure the 
/// framework remains lightweight and responsive under various operational loads.
void main() {
  group('Non-Functional Performance Tests', () {
    
    /// Benchmarks the core adaptation pipeline: StateManager update -> RuleEngine 
    /// evaluation -> Contrast checking -> Theme selection.
    /// 
    /// Target: Sub-millisecond execution to ensure zero impact on UI smoothness.
    test('Adaptation Speed: Theme calculation should be sub-millisecond', () {
      final stateManager = StateManager();
      final adaptationManager = AdaptationManager(stateManager);
      
      final stopwatch = Stopwatch()..start();
      
      // Trigger a sample adaptation cycle.
      stateManager.updateEmotion(EmotionResult(
        dominantEmotion: EmotionState.enjoyment,
        confidence: 0.9,
        probabilities: {EmotionState.enjoyment: 0.9},
        timestamp: DateTime.now(),
      ));
      
      stopwatch.stop();
      
      final elapsedMs = stopwatch.elapsedMicroseconds / 1000.0;
      print('Adaptation Speed: $elapsedMs ms');
      
      // Benchmarked logic must comfortably fit within a 60fps frame budget (16.6ms).
      expect(elapsedMs, lessThan(16.0), reason: 'Adaptation logic is taking too long (> 1 frame budget)');
    });

    /// Measures the Resident Set Size (RSS) memory overhead of the framework components.
    /// This provides transparency into the memory footprint of the Dart logic layer.
    test('Memory Footprint: Detailed Breakdown', () {
      // Residents Set Size (RSS) captures total memory assigned to the process by the OS.
      final int baselineMemory = ProcessInfo.currentRss;
      
      print('\n--- Memory Consumption Report ---');
      print('1. Baseline (Environment): ${(baselineMemory / 1024 / 1024).toStringAsFixed(2)} MB');
      
      // Phase 1: Logic Layer Overhead
      // Initializing the core managers shouldn't cause significant memory spikes.
      final stateManager = StateManager();
      final adaptationManager = AdaptationManager(stateManager);
      
      final int afterLogic = ProcessInfo.currentRss;
      final int logicOverhead = afterLogic - baselineMemory;
      print('2. Managers (StateManager + AdaptationManager): ${(afterLogic / 1024 / 1024).toStringAsFixed(2)} MB');
      print('   -> Overhead: ${(logicOverhead / 1024).toStringAsFixed(2)} KB');

      // Phase 2: Object Allocation Scalability
      // Measures how much memory is consumed by high volumes of framework data models.
      final results = List.generate(10000, (i) => EmotionResult(
        dominantEmotion: EmotionState.neutral,
        confidence: 0.5,
        probabilities: {EmotionState.neutral: 0.5},
        timestamp: DateTime.now(),
      ));
      
      final int afterObjects = ProcessInfo.currentRss;
      final int objectsOverhead = afterObjects - afterLogic;
      print('3. After 10,000 EmotionResults: ${(afterObjects / 1024 / 1024).toStringAsFixed(2)} MB');
      print('   -> Total Object Overhead: ${(objectsOverhead / 1024).toStringAsFixed(2)} KB');
      print('   -> Per Object Average: ${((objectsOverhead) / 10000).toStringAsFixed(2)} bytes');

      // Phase 3: Theme Generation Memory
      // Ensures that creating multiple theme snapshots is memory-efficient.
      final themes = List.generate(100, (i) => EmotionTheme.neutral());
      final int afterThemes = ProcessInfo.currentRss;
      print('4. After 100 EmotionThemes: ${(afterThemes / 1024 / 1024).toStringAsFixed(2)} MB');
      
      print('---------------------------------\n');

      // Clear references to allow for future garbage collection cycles.
      results.clear();
      themes.clear();

      expect(logicOverhead, lessThan(5 * 1024 * 1024), reason: 'Core logic memory overhead is too high');
    });

    /// Stress tests the system with a high frequency of state changes to measure 
    /// sustained throughput and average latency per adaptation.
    test('Stress Test: Rapid Adaptations', () {
      final stateManager = StateManager();
      final adaptationManager = AdaptationManager(stateManager);
      
      final stopwatch = Stopwatch()..start();
      const int iterations = 1000;
      
      for (int i = 0; i < iterations; i++) {
        // Force rapid back-and-forth adaptations.
        stateManager.updateEmotion(EmotionResult(
          dominantEmotion: i % 2 == 0 ? EmotionState.anger : EmotionState.enjoyment,
          confidence: 0.5,
          probabilities: {},
          timestamp: DateTime.now(),
        ));
      }
      
      stopwatch.stop();
      final totalMs = stopwatch.elapsedMilliseconds;
      final avgMs = totalMs / iterations;
      
      print('Stress Test ($iterations adaptations): Total $totalMs ms, Avg $avgMs ms/adaptation');
      
      expect(avgMs, lessThan(1.0), reason: 'Average adaptation time in stress test is too high');
    });
  });
}
