import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';

class AnimationsSection extends StatefulWidget {
  const AnimationsSection({super.key});

  @override
  State<AnimationsSection> createState() => _AnimationsSectionState();
}

class _AnimationsSectionState extends State<AnimationsSection> {
  bool _toggleState = false;

  @override
  Widget build(BuildContext context) {
    return SentientColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SentientHeadingEnhanced('6. Animations'),
        SentientSizedBox(height: 10),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SentientRow(
            mainAxisSize: MainAxisSize.min,
            children: [
              SentientColumn(
                children: [
                  SentientCaptionEnhanced('AnimatedOpacity'),
                  SentientAnimatedOpacity(
                    opacity: _toggleState ? 1.0 : 0.3,
                    duration: Duration(seconds: 1),
                    child: SentientIcon(icon: Icons.lightbulb, size: 40, color: Colors.orange),
                  ),
                ],
              ),
              SentientColumn(
                children: [
                  SentientCaptionEnhanced('AnimatedSwitcher'),
                  SentientAnimatedSwitcher(
                    child: _toggleState
                        ? SentientIcon(icon: Icons.check_box, key: ValueKey(1), size: 40, color: Colors.green)
                        : SentientIcon(icon: Icons.check_box_outline_blank, key: ValueKey(2), size: 40, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
        SentientSizedBox(height: 16),
        Center(
          child: SentientTextButton(
            onPressed: () => setState(() => _toggleState = !_toggleState),
            child: Text('Toggle Animations'),
          ),
        ),
        SentientSizedBox(height: 100), // Bottom padding
      ],
    );
  }
}
