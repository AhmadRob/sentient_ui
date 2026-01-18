import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sentient_ui/sentient_ui.dart';

// --- Mocks ---

/// A mock implementation of [SentientEngine] for UI testing.
/// 
/// Native dependencies like camera and SharedPreferences are not available 
/// in the widget test environment. This fake bypasses them to allow 
/// testing of high-level UI flows (like the Consent View).
class FakeSentientEngine extends SentientEngine {
  FakeSentientEngine() : super();

  @override
  Future<void> initialize({SentientConfig? config}) async {
    // Simulate successful initialization without native hardware calls.
    return;
  }

  @override
  Future<void> saveAndApplyConfig(SentientConfig config) async {
    // Simulate configuration persistence.
    return;
  }
}

/// Widget-level tests for the Sentient UI component library.
/// 
/// These tests verify that adaptive widgets render correctly, correctly 
/// consume the [AdaptationManager] from the context, and properly 
/// wrap standard Flutter widgets.
void main() {
  /// Utility to provide the necessary Dependency Injection (Providers) 
  /// required by all Sentient widgets to function during tests.
  Widget createTestWrapper({required Widget child}) {
    final stateManager = StateManager();
    final adaptationManager = AdaptationManager(stateManager);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: stateManager),
        ChangeNotifierProvider.value(value: adaptationManager),
      ],
      child: MaterialApp(
        home: Scaffold(body: child),
      ),
    );
  }

  /// Verifies that the [SentientTextButton] correctly displays its child 
  /// and maps internally to a Material [TextButton].
  testWidgets('SentientTextButton renders with text', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWrapper(
      child: SentientTextButton(
        onPressed: () {},
        child: const Text('Tap Me'),
      ),
    ));

    expect(find.text('Tap Me'), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });

  /// Ensures that the [SentientContainer] correctly builds a [Container] 
  /// and passes through basic layout properties.
  testWidgets('SentientContainer renders child', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWrapper(
      child: const SentientContainer(
        width: 100,
        height: 100,
        child: Text('Inside Box'),
      ),
    ));

    expect(find.text('Inside Box'), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
  });

  /// Tests the adaptive [SentientText] widget for basic rendering capability.
  testWidgets('SentientText renders text', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWrapper(
      child: const SentientText('Hello Sentient'),
    ));

    expect(find.text('Hello Sentient'), findsOneWidget);
  });

  /// Comprehensive test for the [SentientConsentView] flow.
  /// 
  /// It verifies that the view displays the core privacy toggles and uses 
  /// the [FakeSentientEngine] to handle interactions safely without plugins.
  testWidgets('SentientConsentView renders toggles', (WidgetTester tester) async {
    final engine = FakeSentientEngine();

    await tester.pumpWidget(MaterialApp(
      home: SentientConsentView(
        engine: engine,
        onCompleted: () {},
      ),
    ));

    expect(find.text('Enable Sentient UI'), findsOneWidget);
    expect(find.text('Emotion Detection'), findsOneWidget);
    
    // Verifies that all three core privacy controls (Emotion, Context, Behavior) 
    // are presented to the user as toggleable switches.
    expect(find.byType(Switch), findsNWidgets(3)); 
  });
}
