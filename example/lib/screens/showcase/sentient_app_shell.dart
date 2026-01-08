import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentient_ui/sentient_ui.dart';

import '../sentient_showcase_screen.dart';

@Deprecated(
  'SentientAppShell is no longer needed. '
  'Use SentientApp with enableEmotionTheming instead. '
  'This will be removed in version 2.0.0'
)
class SentientAppShell extends StatelessWidget {
  const SentientAppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AdaptationManager>(
      builder: (context, adaptationManager, child) {
        return AnimatedEmotionTheme(
          data: adaptationManager.currentTheme,
          child: Builder(
            builder: (context) {
              final emotionTheme = context.watch<EmotionTheme>();
              
              return Theme(
                data: emotionTheme.toThemeData(),
                child: const SentientShowcaseScreen(),
              );
            },
          ),
        );
      },
    );
  }
}
