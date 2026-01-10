import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentient_ui/sentient_ui.dart';
import 'showcase/sections/typography_section.dart';
import 'showcase/sections/inputs_section.dart';
import 'showcase/sections/layout_section.dart';
import 'showcase/sections/visual_widgets_section.dart';
import 'showcase/sections/lists_grids_section.dart';
import 'showcase/sections/animations_section.dart';
import 'showcase/sections/camera_section.dart';

class SentientShowcaseScreen extends StatefulWidget {
  const SentientShowcaseScreen({super.key});

  @override
  State<SentientShowcaseScreen> createState() => _SentientShowcaseScreenState();
}

class _SentientShowcaseScreenState extends State<SentientShowcaseScreen> {
  int _navIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Note: We removed the manual Listener wrapper here because
    // SentientGestureDetector now handles tracking automatically.

    return SentientScaffold(
      // We wrap the AppBar in a SentientGestureDetector to ensure taps on it
      // are also tracked as user activity.
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SentientTapDetector(
          onTap: () {}, // No-op, just for tracking
          child: AppBar(
            title: const SentientTextEnhanced(
              'Sentient UI Showcase',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            actions: const [_EmotionDisplay()],
          ),
        ),
      ),
      // We wrap the entire body in a SentientGestureDetector.
      // This acts as a "screen-level tracker" for trajectory and background taps.
      body: SentientTapDetector(
        // We handle pointer movements and general taps here.
        // Child widgets with their own gesture detectors will still work
        // and will ALSO report their own specific events.
        child: const SentientSafeArea(
          child: SentientSingleChildScrollView(
            child: SentientColumn(
              padding: EdgeInsets.all(16.0),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CameraSection(),
                TypographySection(),
                InputsSection(),
                LayoutSection(),
                VisualWidgetsSection(),
                ListsGridsSection(),
                AnimationsSection(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SentientBottomNavigationBar(
        currentIndex: _navIndex,
        onTap: (index) => setState(() => _navIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.widgets), label: 'Widgets'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // This button demonstrates a manual trigger, but regular taps
          // are now tracked automatically by SentientTapDetector inside sections.
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => SentientDraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.2,
              maxChildSize: 0.8,
              builder: (context, scrollController) {
                return SentientContainer(
                  color: Colors.white,
                  borderRadius: 24,
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Center(
                          child: SentientContainer(
                              width: 40, height: 5, color: Colors.grey)),
                      const SentientSizedBox(height: 20),
                      const SentientHeadingEnhanced('Sentient Sheet'),
                      const SentientText(
                          'This sheet adapts its behavior to emotions.'),
                      const SentientDivider(),
                      for (int i = 1; i <= 5; i++)
                        SentientListTile(
                          leading: const SentientIcon(icon: Icons.layers),
                          title: SentientText('Sheet Item $i'),
                        ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}

/// A stateless widget that displays the current emotion.
class _EmotionDisplay extends StatelessWidget {
  const _EmotionDisplay();

  @override
  Widget build(BuildContext context) {
    // Watch the StateManager for the latest emotion data.
    final emotionResult = context.watch<StateManager>().currentEmotion;
    final emotionName = emotionResult.dominantEmotion.name;
    final confidence = emotionResult.confidence;

    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(153),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.white.withAlpha((0.2 * 255).round()),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SentientText(
            emotionName.toUpperCase(),
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 4.0),
          Text(
            "${(confidence * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              color: Colors.white.withAlpha((0.7 * 255).round()),
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}
