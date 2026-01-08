import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';

class VisualWidgetsSection extends StatelessWidget {
  const VisualWidgetsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SentientColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SentientHeadingEnhanced('4. Visual Widgets'),
        SentientSizedBox(height: 10),
        SentientListTile(
          leading: SentientCircleAvatar(child: Icon(Icons.person)),
          title: SentientText('SentientListTile'),
          subtitle: SentientCaptionEnhanced('With CircleAvatar & Icon'),
          trailing: SentientIcon(icon: Icons.arrow_forward),
        ),
        SentientSizedBox(height: 10),
        SentientText('SentientImage (Placeholder):'),
        SentientSizedBox(height: 8),
        // Commented out for now as in original
        // SentientImage(...),
        SentientDivider(),
      ],
    );
  }
}
