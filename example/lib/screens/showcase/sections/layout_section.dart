import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';

class LayoutSection extends StatelessWidget {
  const LayoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SentientColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SentientHeadingEnhanced('3. Layout Primitives'),
        SentientSizedBox(height: 10),

        // Stack & Positioned
        SentientTextEnhanced('Stack, Positioned & Align:'),
        SentientSizedBox(height: 8),
        SentientContainer(
          height: 100,
          color: Colors.grey.withAlpha((0.1 * 255).round()),
          child: SentientStack(
            children: [
              SentientPositioned(
                top: 5,
                left: 5,
                child: SentientIcon(icon: Icons.star, size: 24),
              ),
              SentientAlign(
                child: SentientText('Centered via Align'),
              ),
              SentientPositioned(
                bottom: 5,
                right: 5,
                child: SentientIcon(icon: Icons.check, size: 24),
              ),
            ],
          ),
        ),
        SentientSizedBox(height: 16),

        // Row, Spacer, Expanded
        SentientTextEnhanced('Row, Spacer & Expanded:'),
        SentientSizedBox(height: 8),
        SentientRow(
          children: [
            SentientContainer(
              width: 30,
              height: 30,
              color: Colors.red.withAlpha((0.3 * 255).round()),
            ),
            SentientSpacer(),
            SentientExpanded(
              child: SentientContainer(
                height: 30,
                child: Center(child: Text('Expanded')),
              ),
            ),
            SentientSpacer(),
            SentientContainer(
              width: 30,
              height: 30,
              color: Colors.blue.withAlpha((0.3 * 255).round()),
            ),
          ],
        ),
        SentientSizedBox(height: 16),

        // AspectRatio, ClipRRect, RotatedBox - FIXED
        SentientTextEnhanced('Aspect Ratio, Clip & Rotation:'),
        SentientSizedBox(height: 8),
        SizedBox( // Wrap the Row with a Container to give it bounds
          height: 80, // Give the row a height constraint
          child: SentientRow(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // FIX 1: Wrap AspectRatio with a Container that has width
              SizedBox(
                width: 60, // Constrain the width
                child: SentientAspectRatio(
                  aspectRatio: 1.0,
                  child: SentientContainer(
                    color: Colors.orange.withAlpha((0.3 * 255).round()),
                    child: Center(child: Text('1:1')),
                  ),
                ),
              ),
              // FIX 2: Or constrain the AspectRatio directly with SizedBox
              SizedBox(
                width: 60,
                height: 60, // Both dimensions work too
                child: SentientClipRRect(
                  borderRadius: 15,
                  child: SentientContainer(
                    color: Colors.purple.withAlpha((0.3 * 255).round()),
                    child: Center(child: Text('Clip')),
                  ),
                ),
              ),
              // FIX 3: RotatedBox also needs constraints
              Container(
                constraints: BoxConstraints(
                  maxWidth: 80,
                  maxHeight: 40,
                ),
                child: SentientRotatedBox(
                  quarterTurns: 1,
                  child: SentientContainer(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: Colors.teal.withAlpha((0.3 * 255).round()),
                    child: Text('Rotated'),
                  ),
                ),
              ),
            ],
          ),
        ),
        SentientDivider(),
      ],
    );
  }
}
