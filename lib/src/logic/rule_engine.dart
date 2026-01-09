import 'package:flutter/material.dart';
import 'package:sentient_ui/sentient_ui.dart';

/// Represents a UI adaptation to be applied, such as a theme change.
class Adaptation {
  /// The visual theme associated with this adaptation.
  final EmotionTheme theme;

  const Adaptation({required this.theme});
}

/// A function signature for a rule's condition.
typedef RuleCondition = bool Function(EmotionResult emotion, ContextResult context);

/// A function signature for a rule's action (producing an Adaptation).
typedef RuleAction = Adaptation Function(EmotionResult emotion, ContextResult context);

/// Defines a single rule for the [RuleEngine].
class Rule {
  /// A descriptive name for debugging purposes.
  final String name;

  /// The condition that must be met for this rule to be triggered.
  final RuleCondition condition;

  /// The action to perform (producing an Adaptation) if the condition is met.
  final RuleAction action;

  const Rule({
    required this.name,
    required this.condition,
    required this.action,
  });
}

/// A forward-chaining rule engine that adapts UI based on Emotion and Context.
class RuleEngine {
  final List<Rule> _rules;
  final Adaptation _defaultAdaptation;

  RuleEngine({
    required List<Rule> rules,
    required Adaptation defaultAdaptation,
  })  : _rules = rules,
        _defaultAdaptation = defaultAdaptation;

  /// Evaluates the rules against the current emotional state and context.
  Adaptation evaluate(EmotionResult emotionResult, ContextResult contextResult) {
    for (final rule in _rules) {
      if (rule.condition(emotionResult, contextResult)) {
        debugPrint('[RuleEngine] Rule matched: ${rule.name}');
        return rule.action(emotionResult, contextResult);
      }
    }
    return _defaultAdaptation;
  }

  /// Creates a rule engine with context-aware dynamic rules.
  factory RuleEngine.contextAware() {
    final rules = [
      // 1. Sadness at Night -> Dark, Calming, Comforting
      Rule(
        name: 'Sadness at Night',
        condition: (e, c) => 
            (e.dominantEmotion == EmotionState.sadness) &&
            c.isNight,
        action: (e, c) => Adaptation(
          theme: EmotionTheme.sadness().copyWith(
            surfaceColor: const Color(0xFF121212),
            surfaceVariantColor: const Color(0xFF1E1E1E),
            onSurfaceColor: const Color(0xFFE0E0E0),
            brightnessAdjustment: -0.4,
          ),
        ),
      ),

      // 2. Happy while Moving -> High Visibility, Energetic
      Rule(
        name: 'Happy while Moving',
        condition: (e, c) => 
            (e.dominantEmotion == EmotionState.enjoyment) &&
            (c.isMoving == true),
        action: (e, c) => Adaptation(
          theme: EmotionTheme.enjoyment().copyWith(
            brightnessAdjustment: 0.3, 
            saturationAdjustment: 0.4, 
          ),
        ),
      ),

      // 3. High Noise Environment -> High Contrast, Reduced Visual Noise
      Rule(
        name: 'High Noise Environment',
        condition: (e, c) =>
        c.noiseLevel != null &&
            c.noiseLevel! > 70.0, // Loud environment threshold
        action: (e, c) {
          final base = EmotionTheme.fromState(e.dominantEmotion);
          return Adaptation(
            theme: base.copyWith(
              // Reduce visual overload
              saturationAdjustment: -0.4,
              brightnessAdjustment: -0.1,

              // Increase contrast
              surfaceColor: const Color(0xFF111111),
              surfaceVariantColor: const Color(0xFF1C1C1C),
              onSurfaceColor: Colors.white,

              // Reduce motion to avoid cognitive stress
              animation: AnimationConfig.minimal,

              // Improve legibility
              typography: TypographyConfig.expressive,

              // Force readable text while preserving font properties
              bodyTextStyle: base.bodyTextStyle.copyWith(color: Colors.white),
              headingTextStyle: base.headingTextStyle.copyWith(color: Colors.white),
              captionTextStyle: base.captionTextStyle.copyWith(color: const Color(0xFFB0B0B0)),
            ),
          );
        },
      ),

      // 4. Low Battery -> Energy Saver (Darker, Reduced Animations)
      Rule(
        name: 'Low Battery Saver',
        condition: (e, c) => c.isLowBattery,
        action: (e, c) => Adaptation(
          theme: EmotionTheme.fromState(e.dominantEmotion).copyWith(
            surfaceColor: const Color(0xFF000000), 
            brightnessAdjustment: -0.5,
            animation: AnimationConfig.minimal, 
          ),
        ),
      ),

      // 5. Offline -> Calm/Neutral (Reduced visual noise)
      Rule(
        name: 'Offline Mode',
        condition: (e, c) => !c.isOnline,
        action: (e, c) => Adaptation(
          theme: EmotionTheme.neutral().copyWith(
            saturationAdjustment: -0.5, 
            surfaceColor: const Color(0xFFEEEEEE),
          ),
        ),
      ),
      
      // 6. High Stress (Anger/Fear) -> Soothing/Grounding
      Rule(
        name: 'High Stress Safety',
        condition: (e, c) => 
            e.dominantEmotion == EmotionState.anger || 
            e.dominantEmotion == EmotionState.fear,
        action: (e, c) => Adaptation(
          theme: EmotionTheme.fromState(e.dominantEmotion).copyWith(
             saturationAdjustment: -0.2, 
          ),
        ),
      ),
      
      // 7. Night Default -> Dark Mode for any other emotion
      Rule(
        name: 'General Night Mode',
        condition: (e, c) => c.isNight,
        action: (e, c) => Adaptation(
          theme: EmotionTheme.fromState(e.dominantEmotion).copyWith(
            surfaceColor: const Color(0xFF121212),
            surfaceVariantColor: const Color(0xFF2C2C2C),
            onSurfaceColor: const Color(0xFFDDDDDD),
            brightnessAdjustment: -0.3,
          ),
        ),
      ),
      
      // 8. Standard Emotion Mapping (Fallback)
      Rule(
        name: 'Standard Emotion',
        condition: (e, c) => true, 
        action: (e, c) => Adaptation(
          theme: EmotionTheme.fromState(e.dominantEmotion),
        ),
      ),
    ];

    return RuleEngine(
      rules: rules,
      defaultAdaptation: Adaptation(theme: EmotionTheme.neutral()),
    );
  }
}

// --- Extensions for Theme Tweaking ---

extension EmotionThemeCopyWith on EmotionTheme {
  /// Creates a copy of this theme with the given fields replaced with the new values.
  EmotionTheme copyWith({
    EmotionState? emotionState,
    Color? surfaceColor,
    Color? surfaceVariantColor,
    Color? primaryColor,
    Color? secondaryColor,
    Color? onSurfaceColor,
    Color? onPrimaryColor,
    Color? errorColor,
    Color? successColor,
    LinearGradient? backgroundGradient,
    double? brightnessAdjustment,
    double? saturationAdjustment,
    TypographyConfig? typography,
    TextStyle? bodyTextStyle,
    TextStyle? headingTextStyle,
    TextStyle? captionTextStyle,
    AnimationConfig? animation,
    AnimatedSwitcherConfig? animatedSwitcherConfig,
    ButtonConfig? buttonConfig,
    LayoutConfig? layoutConfig,
    FeedbackConfig? feedbackConfig,
    ContainerConfig? containerConfig,
    SingleChildScrollViewConfig? scrollViewConfig,
    ColumnConfig? columnConfig,
    RowConfig? rowConfig,
    ExpandedConfig? expandedConfig,
    TextFieldConfig? textFieldConfig,
    InputDecorationConfig? inputDecorationConfig,
    SizedBoxConfig? sizedBoxConfig,
    ListViewConfig? listViewConfig,
    GridViewConfig? gridViewConfig,
    ScaffoldConfig? scaffoldConfig,
    SafeAreaConfig? safeAreaConfig,
    StackConfig? stackConfig,
    RotatedBoxConfig? rotatedBoxConfig,
    ClipRRectConfig? clipRRectConfig,
    ImageConfig? imageConfig,
    IconConfig? iconConfig,
    SpacerConfig? spacerConfig,
    AlignConfig? alignConfig,
    DividerConfig? dividerConfig,
    ListTileConfig? listTileConfig,
    CircleAvatarConfig? circleAvatarConfig,
    BottomNavigationBarConfig? bottomNavigationBarConfig,
    DraggableScrollableSheetConfig? draggableScrollableSheetConfig,
    TextButtonConfig? textButtonConfig,
    GestureDetectorConfig? gestureDetectorConfig,
    AspectRatioConfig? aspectRatioConfig,
    PositionedConfig? positionedConfig,
    TextEnhancedConfig? textEnhancedConfig,
    double? iconSize,
    bool? useFilledIcons,
    Color? iconColor,
    AppBarConfig? appBarConfig,
    BackButtonConfig? backButtonConfig,
    CenterConfig? centerConfig,
    InkWellConfig? inkWellConfig,
    PaddingConfig? paddingConfig,
    MaterialConfig? materialConfig,
    RotateConfig? rotateConfig,
    WrapConfig? wrapConfig,
  }) {
    return EmotionTheme(
      emotionState: emotionState ?? this.emotionState,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      surfaceVariantColor: surfaceVariantColor ?? this.surfaceVariantColor,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      onSurfaceColor: onSurfaceColor ?? this.onSurfaceColor,
      onPrimaryColor: onPrimaryColor ?? this.onPrimaryColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      brightnessAdjustment: brightnessAdjustment ?? this.brightnessAdjustment,
      saturationAdjustment: saturationAdjustment ?? this.saturationAdjustment,
      typography: typography ?? this.typography,
      bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
      headingTextStyle: headingTextStyle ?? this.headingTextStyle,
      captionTextStyle: captionTextStyle ?? this.captionTextStyle,
      animation: animation ?? this.animation,
      animatedSwitcherConfig: animatedSwitcherConfig ?? this.animatedSwitcherConfig,
      buttonConfig: buttonConfig ?? this.buttonConfig,
      layoutConfig: layoutConfig ?? this.layoutConfig,
      feedbackConfig: feedbackConfig ?? this.feedbackConfig,
      containerConfig: containerConfig ?? this.containerConfig,
      scrollViewConfig: scrollViewConfig ?? this.scrollViewConfig,
      columnConfig: columnConfig ?? this.columnConfig,
      rowConfig: rowConfig ?? this.rowConfig,
      expandedConfig: expandedConfig ?? this.expandedConfig,
      textFieldConfig: textFieldConfig ?? this.textFieldConfig,
      inputDecorationConfig: inputDecorationConfig ?? this.inputDecorationConfig,
      sizedBoxConfig: sizedBoxConfig ?? this.sizedBoxConfig,
      listViewConfig: listViewConfig ?? this.listViewConfig,
      gridViewConfig: gridViewConfig ?? this.gridViewConfig,
      scaffoldConfig: scaffoldConfig ?? this.scaffoldConfig,
      safeAreaConfig: safeAreaConfig ?? this.safeAreaConfig,
      stackConfig: stackConfig ?? this.stackConfig,
      rotatedBoxConfig: rotatedBoxConfig ?? this.rotatedBoxConfig,
      clipRRectConfig: clipRRectConfig ?? this.clipRRectConfig,
      imageConfig: imageConfig ?? this.imageConfig,
      iconConfig: iconConfig ?? this.iconConfig,
      spacerConfig: spacerConfig ?? this.spacerConfig,
      alignConfig: alignConfig ?? this.alignConfig,
      dividerConfig: dividerConfig ?? this.dividerConfig,
      listTileConfig: listTileConfig ?? this.listTileConfig,
      circleAvatarConfig: circleAvatarConfig ?? this.circleAvatarConfig,
      bottomNavigationBarConfig: bottomNavigationBarConfig ?? this.bottomNavigationBarConfig,
      draggableScrollableSheetConfig: draggableScrollableSheetConfig ?? this.draggableScrollableSheetConfig,
      textButtonConfig: textButtonConfig ?? this.textButtonConfig,
      gestureDetectorConfig: gestureDetectorConfig ?? this.gestureDetectorConfig,
      aspectRatioConfig: aspectRatioConfig ?? this.aspectRatioConfig,
      positionedConfig: positionedConfig ?? this.positionedConfig,
      textEnhancedConfig: textEnhancedConfig ?? this.textEnhancedConfig,
      iconSize: iconSize ?? this.iconSize,
      useFilledIcons: useFilledIcons ?? this.useFilledIcons,
      iconColor: iconColor ?? this.iconColor,
      appBarConfig: appBarConfig ?? this.appBarConfig,
      backButtonConfig: backButtonConfig ?? this.backButtonConfig,
      centerConfig: centerConfig ?? this.centerConfig,
      inkWellConfig: inkWellConfig ?? this.inkWellConfig,
      paddingConfig: paddingConfig ?? this.paddingConfig,
      materialConfig: materialConfig ?? this.materialConfig,
      rotateConfig: rotateConfig ?? this.rotateConfig,
      wrapConfig: wrapConfig ?? this.wrapConfig,
    );
  }
}
