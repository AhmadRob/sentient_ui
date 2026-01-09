# Sentient UI

**An emotion-aware adaptive interface framework for Flutter**

[![Pub Version](https://img.shields.io/pub/v/sentient_ui)](https://pub.dev/packages/sentient_ui)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/badge/Platform-Flutter-02569B?logo=flutter)](https://flutter.dev)

Sentient UI is a Flutter framework for building interfaces that adapt dynamically based on user emotion, behavior, and contextual signals. It introduces an adaptive layer that operates entirely on-device, enabling emotionally responsive user interfaces while maintaining strict privacy guarantees.

This project explores how affective computing and interaction analytics can be engineered into real-world UI systems in a practical, developer-friendly manner.

**Research & Documentation**  
📘 https://ahmadrob.github.io/sentient_ui/

> A research-driven exploration of emotion recognition, adaptive UI systems, and human-centered interface optimization.

---

## Table of Contents

- [Demo](#demo)
- [Overview](#overview)
- [Core Capabilities](#core-capabilities)
- [Installation](#installation)
- [Platform Configuration](#platform-configuration)
- [Basic Usage](#basic-usage)
- [Widget Integration](#widget-integration)
- [Advanced Configuration](#advanced-configuration)
- [System Architecture](#system-architecture)
- [Privacy & Compliance](#privacy--compliance)
- [Model Attribution](#model-attribution)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

---

## Demo

![Sentient UI in Action](demo.gif)

*A live demonstration of UI elements adapting to detected emotional and behavioral states.*

A complete runnable example is available in the `example/` directory.

---

## Overview

Traditional interfaces assume static user conditions. Sentient UI challenges this assumption by introducing a runtime adaptation engine that responds to emotional and behavioral signals in real time.

The framework integrates multiple on-device signals—including facial expression analysis, interaction patterns, and environmental context—to infer user state and adjust interface presentation accordingly. All processing is performed locally, with no cloud dependency and no data transmission.

Sentient UI is designed as a **framework**, not a demo experiment. It emphasizes architectural clarity, extensibility, and research validity.

---

## Core Capabilities

### Emotion Recognition Engine
On-device facial expression analysis using lightweight neural models to infer a set of core emotional states.
*   **Model**: MobileNet-based emotion recognition model (quantized TFLite)
*   **Assets Used**: `assets/models/emotion_model.tflite` and `assets/models/emotion_labels.txt`
*   **Model Source**: Based on [emotion-recognition-app by MdIrfan325](https://github.com/MdIrfan325/emotion-recognition-app)
*   **Privacy**: Camera frames are processed in memory only and are never stored or transmitted.

### Contextual Awareness
Environmental signals such as ambient noise levels, device motion, lighting conditions, and battery status are incorporated to refine adaptation decisions.

### Behavioral Analysis
Interaction patterns—including tap frequency, gesture intensity, and scroll irregularities—are analyzed to detect indicators such as frustration or cognitive overload.

### Adaptive Theme System
`AnimatedEmotionTheme` enables smooth interpolation between emotional states, adjusting color palettes, typography, spacing, and motion characteristics.

### Adaptive Widget Layer
Sentient UI provides adaptive alternatives to common Flutter widgets (e.g., containers, buttons, text) that respond automatically to emotional state changes without additional configuration.

### Privacy-First Design
All computation is local.  
No telemetry.  
No cloud processing.  
No data persistence beyond runtime needs.

---

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  sentient_ui: ^0.1.0
```

---

## Platform Configuration

### Android

1. **Permissions**: Add the following to `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
```

2. **Model Compression**: To ensure the TFLite model loads correctly, prevent Android from compressing the model file. Add this to `android/app/build.gradle` inside the `android` block:

```gradle
android {
    // ... other config
    aaptOptions {
        noCompress 'tflite'
        noCompress 'lite'
    }
}
```

### iOS

Add the following entries to `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>Used for on-device facial expression analysis to support adaptive UI behavior.</string>
<key>NSMicrophoneUsageDescription</key>
<string>Used to measure ambient noise levels for contextual awareness.</string>
```

---

## Basic Usage

Wrap your application root with `SentientApp`:

```dart
import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SentientApp(
      title: 'Adaptive Application',
      enableEmotionTheming: true,
      captureInterval: const Duration(seconds: 5),
      home: const HomeScreen(),
    );
  }
}
```

---

## Widget Integration

Replace standard widgets with Sentient counterparts to enable adaptive behavior:

```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SentientScaffold(
      appBar: SentientAppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SentientText(
              'Welcome to adaptive interfaces',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 32),
            SentientButton(
              onPressed: _handleAction,
              child: const Text('Continue'),
            ),
            const SizedBox(height: 32),
            SentientContainer(
              width: 280,
              height: 160,
              child: const Center(
                child: Text('Emotion-aware content'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleAction() {}
}
```

---

## Advanced Configuration

### Selective Feature Control

Enable or disable subsystems explicitly within your `runApp` or build method:

```dart
void main() {
  runApp(
    SentientApp(
      home: const HomeScreen(),
      enableEmotionDetection: false, // Disable camera features
      enableContextSensing: true,    // Keep context sensing active
      enableBehaviorTracking: true,  // Keep behavior tracking active
    ),
  );
}
```

### Runtime Engine Control

```dart
// Example: Updating configuration from a settings screen
void updateSettings(BuildContext context) {
  // Access the engine via Provider
  final engine = context.read<SentientEngine>();

  // Update configuration dynamically
  engine.updateConfig(
    engine.config.copyWith(
      captureInterval: const Duration(minutes: 1), // Reduce frequency to save battery
    ),
  );

  // Manually pause/resume processing
  // engine.pause();
  // engine.resume();
}
```

---

## System Architecture

### Processing Pipeline

**Input Layer**

* Emotion detection (camera-based)
* Environmental context aggregation
* Interaction behavior tracking

**Core Engine**
Combines multi-modal inputs using weighted heuristics to infer user state. Behavioral indicators are prioritized when conflicting signals arise.

**Adaptation Layer**
Maps inferred states to concrete `EmotionTheme` configurations using interpolation logic.

**Presentation Layer**
Widgets react automatically through inherited theme propagation and animated transitions.

---

## Privacy & Compliance

Sentient UI processes sensitive biometric signals. Applications using this framework must clearly disclose:

* Camera usage is limited to transient, in-memory facial analysis
* Microphone usage is limited to ambient noise level measurement
* No biometric data is stored, logged, or transmitted

Developers are responsible for ensuring compliance with applicable regulations (e.g., GDPR, CCPA, BIPA).

---

## Model Attribution

The emotion recognition model (`mobilenet_model.tflite`) included in this package is based on work from:

**[emotion-recognition-app](https://github.com/MdIrfan325/emotion-recognition-app)** by MdIrfan325

The model has been integrated into this framework to provide on-device emotion detection capabilities. All credit for the model architecture and training goes to the original author.

---

## Contributing

Contributions are welcome.

1. Fork the repository
2. Create a feature branch
3. Add tests and documentation
4. Commit with clear messages
5. Submit a pull request describing the change and rationale

Architectural consistency and code quality are expected.

---

## License

MIT License. See [LICENSE](LICENSE).

---

## Contact

**Research & Collaboration**
📧 [ahmed.abualrob@gmail.com](mailto:ahmed.abualrob@gmail.com)

For bug reports or feature requests, please open an issue on GitHub.
