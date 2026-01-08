import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentient_ui/sentient_ui.dart';

class CameraSection extends StatelessWidget {
  const CameraSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the SentientEngine to know when the camera is ready.
    final engine = context.watch<SentientEngine>();
    final isCameraReady = engine.isCameraReady;

    return SentientColumn(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SentientHeadingEnhanced('0. Live Input & Testing'),
        const SentientSizedBox(height: 10),
        const SentientText('Real-time emotion detection feed:'),
        const SentientSizedBox(height: 8),
        SentientContainer(
          height: 300,
          child: isCameraReady
              ? _buildCameraPreview(context, engine.cameraController!)
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Initializing Camera...', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
        ),
        const SentientSizedBox(height: 16),

        // --- Debug Controls ---
        const SentientHeadingEnhanced('Debug Controls'),
        const SentientSizedBox(height: 8),
        SentientWrap(
          children: [
            // Resume Auto Mode
            ChoiceChip(
              label: const Text('Auto Detect'),
              selected: !engine.isPaused,
              onSelected: (bool selected) {
                if (selected) engine.resume();
              },
              selectedColor: Colors.greenAccent,
            ),
            // Force Neutral
            ChoiceChip(
              label: const Text('Neutral'),
              selected: engine.isPaused && context.read<StateManager>().dominantEmotion == EmotionState.neutral,
              onSelected: (bool selected) => _forceEmotion(context, engine, EmotionState.neutral),
            ),
             // Force Sadness
            ChoiceChip(
              label: const Text('Sadness'),
              selected: engine.isPaused && context.read<StateManager>().dominantEmotion == EmotionState.sadness,
              onSelected: (bool selected) => _forceEmotion(context, engine, EmotionState.sadness),
            ),
            // Force Enjoyment
            ChoiceChip(
              label: const Text('Enjoyment'),
              selected: engine.isPaused && context.read<StateManager>().dominantEmotion == EmotionState.enjoyment,
              onSelected: (bool selected) => _forceEmotion(context, engine, EmotionState.enjoyment),
            ),
            // Force Anger
            ChoiceChip(
              label: const Text('Anger'),
              selected: engine.isPaused && context.read<StateManager>().dominantEmotion == EmotionState.anger,
              onSelected: (bool selected) => _forceEmotion(context, engine, EmotionState.anger),
            ),
             // Force Fear
            ChoiceChip(
              label: const Text('Fear'),
              selected: engine.isPaused && context.read<StateManager>().dominantEmotion == EmotionState.fear,
              onSelected: (bool selected) => _forceEmotion(context, engine, EmotionState.fear),
            ),
             // Force Surprise
            ChoiceChip(
              label: const Text('Surprise'),
              selected: engine.isPaused && context.read<StateManager>().dominantEmotion == EmotionState.surprise,
              onSelected: (bool selected) => _forceEmotion(context, engine, EmotionState.surprise),
            ),
          ],
        ),
        const SentientDivider(),
      ],
    );
  }

  Widget _buildCameraPreview(BuildContext context, CameraController controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CameraPreview(controller),
    );
  }

  void _forceEmotion(BuildContext context, SentientEngine engine, EmotionState state) {
    // 1. Pause the engine so it doesn't overwrite our manual selection
    engine.pause();

    // 2. Create a fake result
    final fakeResult = EmotionResult(
      dominantEmotion: state,
      confidence: 1.0,
      probabilities: {state: 1.0},
      timestamp: DateTime.now(),
    );

    // 3. Update the global state
    context.read<StateManager>().updateEmotion(fakeResult);
  }
}
