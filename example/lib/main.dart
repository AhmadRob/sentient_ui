import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'package:sentient_ui_example/screens/sentient_showcase_screen.dart';

/// Application entry point.
void main() {
  runApp(const MyApp());
}

/// Root application widget.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SentientApp handles initialization, persistence, providers, and consent flow.
    // It also handles emotion-driven theming automatically.
    return const SentientApp(
      title: 'Sentient UI Demo',
      debugShowCheckedModeBanner: false,
      enableEmotionTheming: true,
      home: SentientShowcaseScreen(),
    );
  }
}
