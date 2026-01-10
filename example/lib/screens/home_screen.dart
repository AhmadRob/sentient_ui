import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sentient_ui/sentient_ui.dart';

/// The main screen of the application, now a pure StatelessWidget.
///
/// It rebuilds declaratively based on the state from the providers.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Watch the AdaptationManager to get the current theme and rebuild on changes.
    final theme = context.watch<AdaptationManager>().currentTheme;

    return Scaffold(
      backgroundColor: theme.surfaceColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // --- Camera Preview (Background) ---
          // Watch the SentientEngine to know when the camera is ready.
          if (context.watch<SentientEngine>().isCameraReady)
            _buildCameraPreview(context)
          else
            const Center(child: CircularProgressIndicator()),

          // --- UI Overlay (Foreground) ---
          const SafeArea(
            child: Stack(
              children: [
                _SentientUITitle(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _EmotionDisplay(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the camera preview, ensuring it is correctly scaled to fill the screen.
  Widget _buildCameraPreview(BuildContext context) {
    // Use context.read here because this widget only needs to get the controller
    // once and doesn't need to rebuild if other engine properties change.
    final controller = context.read<SentientEngine>().cameraController!;
    final size = MediaQuery.of(context).size;

    var scale = size.aspectRatio * controller.value.aspectRatio;
    if (scale < 1) scale = 1 / scale;

    return Transform.scale(
      scale: scale,
      child: Center(
        child: CameraPreview(controller),
      ),
    );
  }
}

/// A stateless widget for the title overlay.
class _SentientUITitle extends StatelessWidget {
  const _SentientUITitle();

  @override
  Widget build(BuildContext context) {
    return SentientAlign(
      configOverride: AlignConfig(
          alignment: Alignment.topLeft,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SentientHeading(
          'Sentient UI',
        ),
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
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.black..withAlpha(153),
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.white.withAlpha(51)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SentientText(
            emotionName.toUpperCase(),
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            "${(confidence * 100).toStringAsFixed(1)}%",
            style: TextStyle(
              color: Colors.white.withAlpha((0.7 * 255).round()),
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    );
  }
}
