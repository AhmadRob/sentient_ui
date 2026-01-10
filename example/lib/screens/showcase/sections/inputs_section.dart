import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';

class InputsSection extends StatefulWidget {
  const InputsSection({super.key});

  @override
  State<InputsSection> createState() => _InputsSectionState();
}

class _InputsSectionState extends State<InputsSection> {
  bool _toggleState = false;

  @override
  Widget build(BuildContext context) {
    return SentientColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SentientHeadingEnhanced('2. Inputs & Interactions'),
        const SentientSizedBox(height: 10),
        const SentientTextField(
          decorationConfig: InputDecorationConfig(
            hintText: 'SentientTextField...',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.edit),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        const SentientSizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SentientRow(
              mainAxisSize: MainAxisSize.min,
              children: [
                SentientTextButton(
                  onPressed: () {},
                  child: const Text('Sentient Button'),
                ),
                const SentientSizedBox(width: 12),
                SentientGestureDetector(
                  onTap: () => setState(() => _toggleState = !_toggleState),
                  child: SentientContainer(
                    padding: const EdgeInsets.all(12),
                    color: Colors.blue.withAlpha((0.1 * 255).round()),
                    child: const SentientText('Tap Detector'),
                  ),
                ),
              ],
            ),
          )

        ),
        const SentientDivider(),
      ],
    );
  }
}
