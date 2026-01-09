import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import '../../sentient_ui.dart';

/// A service responsible for detecting emotions from image data using a TensorFlow Lite model.
///
/// The [EmotionDetector] encapsulates the entire machine learning pipeline:
/// 1.  **Preprocessing**: Resizing and normalizing raw camera frames.
/// 2.  **Inference**: Running the frame through a quantized neural network (MobileNet architecture).
/// 3.  **Post-processing**: Mapping model output logits to [EmotionState] probabilities.
///
/// This class requires [initialize] to be called before use.
class EmotionDetector {
  /// Path to the bundled TFLite model asset.
  static const String _modelPath = 'packages/sentient_ui/assets/models/emotion_model.tflite';

  /// Path to the labels file corresponding to the model's output classes.
  static const String _labelsPath = 'packages/sentient_ui/assets/models/emotion_labels.txt';

  late Interpreter _interpreter;
  late List<String> _labels;
  late Map<String, EmotionState> _labelToStateMap;

  /// Initializes the TFLite interpreter and loads the label map.
  ///
  /// This method performs a runtime integrity check to ensure the loaded model's
  /// output shape matches the number of labels in the definition file.
  ///
  /// Throws an [Exception] if initialization fails or if a model/label mismatch is detected.
  Future<void> initialize() async {
    try {
      _interpreter = await Interpreter.fromAsset(_modelPath);
      final labelsData = await rootBundle.loadString(_labelsPath);

      _labels = labelsData
          .split(RegExp(r'[\r\n]+'))
          .where((label) => label.isNotEmpty)
          .toList();

      debugPrint('[EmotionDetector] Labels loaded: $_labels');

      // --- Model Integrity Check ---
      final outputTensor = _interpreter.getOutputTensor(0);
      final modelOutputClasses = outputTensor.shape.last;

      if (modelOutputClasses != _labels.length) {
        throw Exception(
          '[EmotionDetector] Model/Label Mismatch: Model outputs $modelOutputClasses classes, but ${_labels.length} labels were loaded.'
        );
      }

      debugPrint('[EmotionDetector] Model output classes: $modelOutputClasses');

      // Pre-compute the mapping from string labels to EmotionState enums for O(1) lookup.
      _labelToStateMap = {
        for (var state in EmotionState.values) state.name.toLowerCase(): state,
      };

      debugPrint('[EmotionDetector] Initialized successfully.');
    } catch (e) {
      throw Exception('[EmotionDetector] Failed to initialize: $e');
    }
  }

  /// Analyzes the provided [image] to determine the dominant emotional state.
  ///
  /// [confidenceThreshold] - The minimum probability (0.0 - 1.0) required to return a result.
  /// Returns `null` if the highest confidence score is below this threshold or if processing fails.
  EmotionResult? detect(img.Image image, {double confidenceThreshold = 0.4}) {
    try {
      final input = _preprocessImage(image);
      final output = _runInference(input);
      return _parseResult(output, confidenceThreshold);
    } catch (e) {
      debugPrint("[EmotionDetector] Error during emotion detection: $e");
      return null;
    }
  }

  /// Prepares the image for the model.
  ///
  /// Pipeline:
  /// 1.  Resize to 48x48 pixels (standard input size for this FER model).
  /// 2.  Normalize pixel values to range [0, 1] by dividing by 255.0.
  List<double> _preprocessImage(img.Image image) {
    // Resize using linear interpolation (default)
    final resized = img.copyResize(image, width: 48, height: 48);

    // Convert to flat list of normalized float32 values
    final List<double> input = [];

    for (int y = 0; y < resized.height; y++) {
      for (int x = 0; x < resized.width; x++) {
        final pixel = resized.getPixel(x, y);

        // Extract RGB channels directly from the Pixel object (image v4 API)
        double r = pixel.r / 255.0;
        double g = pixel.g / 255.0;
        double b = pixel.b / 255.0;

        input.addAll([r, g, b]);
      }
    }
    return input;
  }

  /// Executes the TFLite inference.
  ///
  /// Reshapes the input flat list into the tensor shape `[1, 48, 48, 3]`.
  List<double> _runInference(List<double> input) {
    // Reshape input to match model expectation [Batch, Height, Width, Channels]
    final inputTensor = input.reshape([1, 48, 48, 3]);

    // Prepare output buffer [Batch, NumClasses]
    final outputTensor = List<double>.filled(_labels.length, 0.0)
        .reshape([1, _labels.length]);

    _interpreter.run(inputTensor, outputTensor);

    // Return the first (and only) batch result
    return outputTensor[0];
  }

  /// Parses the raw model output into a structured [EmotionResult].
  ///
  /// Filters out low-confidence predictions and maps string labels to [EmotionState].
  EmotionResult? _parseResult(List<double> output, double confidenceThreshold) {
    EmotionState? dominantEmotion;
    double maxConfidence = 0.0;
    final Map<EmotionState, double> probabilities = {};

    for (int i = 0; i < output.length; i++) {
      final confidence = output[i];
      final label = _labels[i].trim().toLowerCase();
      final emotionState = _labelToStateMap[label];

      if (emotionState != null) {
        probabilities[emotionState] = confidence;

        debugPrint('[EmotionDetector] Emotion: $emotionState, Confidence: $confidence');

        // Track the winner
        if (confidence > maxConfidence) {
          maxConfidence = confidence;
          dominantEmotion = emotionState;
        }
      }
    }

    if (dominantEmotion == null || maxConfidence < confidenceThreshold) {
      return null;
    }

    debugPrint('[EmotionDetector] Dominant: $dominantEmotion ($maxConfidence)');

    return EmotionResult(
      dominantEmotion: dominantEmotion,
      confidence: maxConfidence,
      probabilities: probabilities,
      timestamp: DateTime.now(),
    );
  }

  /// Releases resources held by the TFLite interpreter.
  void dispose() {
    _interpreter.close();
  }
}
