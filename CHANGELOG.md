# Changelog

All notable changes to this project will be documented in this file.

## 0.1.2

### Fixed / Updated
- Updated `index.html` to include the pub.dev package link for `sentient_ui`.
- Corrected documentation in `SentientConsentView`: default capture interval is now 30s (previously commented as 10s).
- Engine now prevents adaptation loops when all features (emotion, context, behavior) are disabled:
  - Added `_hasAnySignalSource` check.
  - Guarded `_startAdaptationLoop` and `_startFastEmotionLoop`.
  - Added safety check in `_applyAdaptation`.
- `SentientApp` updated to skip `AnimatedEmotionTheme` if no inputs are enabled.
- Added debug logs when loops are skipped due to all features being off.

## 0.1.1

### Fixed
- Corrected asset paths for models and demo files to ensure proper loading in the example and package.
- Updated documentation references for the demo gif and other assets.

## 0.1.0

### Added
- **Core Engine**: Initial release of the Sentient UI framework for emotion-aware adaptive interfaces.
- **Emotion Detection**: On-device real-time emotion detection using TensorFlow Lite.
- **Context Awareness**: Integrated sensing for environmental context including:
  - Night Mode detection (via system clock).
  - Noise level monitoring (via microphone).
  - Battery and charging status tracking.
  - Device motion sensing.
- **Rule Engine**: A flexible, forward-chaining rule engine for mapping emotion and context to UI adaptations.
- **Sentient Widgets**: A comprehensive suite of reactive widgets:
  - `SentientApp`: Root wrapper for engine initialization and consent.
  - `SentientScaffold`, `SentientAppBar`, `SentientBottomNavigationBar`.
  - `SentientText`, `SentientHeading`, `SentientCaption`.
  - `SentientContainer`, `SentientPadding`, `SentientColumn`, `SentientRow`.
  - `SentientTextButton`.
- **Theme Adaptation**: `EmotionTheme` and `AnimatedEmotionTheme` for smooth, interpolating transitions between emotional states.
- **Safety Features**: Automatic `ensureReadableContrast` logic to maintain accessibility during dark/light mode transitions.
- **Privacy**: Built-in `SentientConsentView` for transparent user permission management.
- **Example**: Comprehensive showcase application demonstrating real-time adaptation and simulation controls.

## 0.0.1

- Internal preview and architecture prototyping.
