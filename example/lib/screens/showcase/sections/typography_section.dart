import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';

class TypographySection extends StatelessWidget {
  const TypographySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SentientColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SentientHeadingEnhanced('1. Typography'),
        SentientSizedBox(height: 10),
        SentientText('Standard SentientText: Adapts to emotion.'),
        SentientSizedBox(height: 8),
        SentientTextEnhanced('Enhanced Text: Granular control.'),
        SentientSizedBox(height: 8),
        SentientCaptionEnhanced('Caption: Subtle information.'),
        SentientDivider(),
      ],
    );
  }
}
