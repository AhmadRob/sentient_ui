import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:sentient_ui/sentient_ui.dart';

// --- Mocks ---

/// A fake engine that bypasses native initialization logic.
class FakeSentientEngine extends SentientEngine {
  FakeSentientEngine() : super(
    // Pass nulls or simple fakes if constructors are heavy.
    // Assuming default constructors are safe (no native calls).
  );

  @override
  Future<void> initialize({SentientConfig? config}) async {
    // Mock successful initialization without native calls
    return;
  }

  @override
  Future<void> saveAndApplyConfig(SentientConfig config) async {
    // Mock saving without SharedPreferences
    return;
  }
}

void main() {
  // Helper to wrap widgets with necessary providers
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

  testWidgets('SentientText renders text', (WidgetTester tester) async {
    await tester.pumpWidget(createTestWrapper(
      child: const SentientText('Hello Sentient'),
    ));

    expect(find.text('Hello Sentient'), findsOneWidget);
  });

  testWidgets('SentientConsentView renders toggles', (WidgetTester tester) async {
    // Use the fake engine to avoid MissingPluginException
    final engine = FakeSentientEngine();

    await tester.pumpWidget(MaterialApp(
      home: SentientConsentView(
        engine: engine,
        onCompleted: () {},
      ),
    ));

    expect(find.text('Enable Sentient UI'), findsOneWidget);
    expect(find.text('Emotion Detection'), findsOneWidget);
    // 3 switches: Emotion, Context, Behavior
    expect(find.byType(Switch), findsNWidgets(3)); 
  });
}
