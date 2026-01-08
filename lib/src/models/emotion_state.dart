/// Represents the set of discrete emotions recognizable by the Sentient UI framework.
///
/// This enumeration is based on Paul Ekman's model of basic emotions, extended
/// to cover the nuances of user interaction states.
///
/// These states are the primary output of the [EmotionDetector] and drive the
/// logic within the [AdaptationManager].
enum EmotionState {
  /// Indicates frustration, irritation, or hostility.
  ///
  /// Adaptation strategies may include simplifying the UI or reducing
  /// animation speed to lower cognitive load.
  anger,

  /// Indicates strong aversion or displeasure.
  disgust,

  /// Indicates anxiety or apprehension.
  ///
  /// Adaptation strategies may focus on reassurance and clear, calming visuals.
  fear,

  /// Indicates pleasure, satisfaction, or happiness.
  ///
  /// Adaptation strategies may include brighter colors or more playful animations.
  enjoyment,

  /// Indicates sorrow or unhappiness.
  ///
  /// Adaptation strategies may include softer, muted colors.
  sadness,

  /// Indicates astonishment or shock.
  ///
  /// Often a transient state that resolves into another emotion.
  surprise,

  /// The baseline state. Indicates no strong emotional signal is detected.
  ///
  /// UI adaptations in this state typically revert to the default theme.
  neutral,

  // /// Indicates a feeling of superiority or dismissal.
  // ///
  // /// Often treated similarly to [disgust] or [anger] in UI adaptation.
  // contempt,
}
