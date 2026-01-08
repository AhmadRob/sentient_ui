import 'package:flutter/material.dart';

import '../../../sentient_ui.dart';
import '../../processing/normalization_utils.dart';

// Exporting configs so they can be used by other files that import this one.
export'../configs/align_config.dart';
export '../configs/animated_switcher_config.dart';
export '../configs/animation_config.dart';
export '../configs/app_bar_config.dart';
export '../configs/aspect_ratio_config.dart';
export '../configs/back_button_config.dart';
export '../configs/bottom_navigation_bar_config.dart';
export '../configs/button_config.dart';
export '../configs/center_config.dart';
export '../configs/circle_avatar_config.dart';
export '../configs/clip_r_rect_config.dart';
export '../configs/column_config.dart';
export '../configs/container_config.dart';
export '../configs/divider_config.dart';
export '../configs/draggable_scrollable_sheet_config.dart';
export '../configs/expanded_config.dart';
export '../configs/feedback_config.dart';
export '../configs/gesture_detector_config.dart';
export '../configs/grid_view_config.dart';
export '../configs/icon_config.dart';
export '../configs/image_config.dart';
export '../configs/ink_well_config.dart';
export '../configs/input_decoration_config.dart';
export '../configs/layout_config.dart';
export '../configs/list_tile_config.dart';
export '../configs/list_view_config.dart';
export '../configs/material_config.dart';
export '../configs/padding_config.dart';
export '../configs/positioned_config.dart';
export '../configs/rotate_config.dart';
export '../configs/rotated_box_config.dart';
export '../configs/row_config.dart';
export '../configs/safe_area_config.dart';
export '../configs/scaffold_config.dart';
export '../configs/scroll_view_config.dart';
export '../configs/sized_box_config.dart';
export '../configs/spacer_config.dart';
export '../configs/stack_config.dart';
export '../configs/text_button_config.dart';
export '../configs/text_enhanced_config.dart';
export '../configs/text_field_config.dart';
export '../configs/typography_config.dart';
export '../configs/wrap_config.dart';

/// A comprehensive data model defining all visual and behavioral properties
/// for a specific emotional state in the Sentient UI framework.
@immutable
class EmotionTheme {
  /// The emotional state this theme represents
  final EmotionState emotionState;

  // ─────────────────────────────────────────────────────────────────
  // COLOR PROPERTIES
  // ─────────────────────────────────────────────────────────────────

  final Color surfaceColor;
  final Color surfaceVariantColor;
  final Color primaryColor;
  final Color secondaryColor;
  final Color onSurfaceColor;
  final Color onPrimaryColor;
  final Color errorColor;
  final Color successColor;
  final LinearGradient? backgroundGradient;
  final double brightnessAdjustment;
  final double saturationAdjustment;

  // ─────────────────────────────────────────────────────────────────
  // TYPOGRAPHY PROPERTIES
  // ─────────────────────────────────────────────────────────────────

  final TypographyConfig typography;
  final TextStyle bodyTextStyle;
  final TextStyle headingTextStyle;
  final TextStyle captionTextStyle;

  // ─────────────────────────────────────────────────────────────────
  // ANIMATION PROPERTIES
  // ─────────────────────────────────────────────────────────────────

  final AnimationConfig animation;
  final AnimatedSwitcherConfig animatedSwitcherConfig;

  // ─────────────────────────────────────────────────────────────────
  // COMPONENT CONFIGURATIONS
  // ─────────────────────────────────────────────────────────────────

  final ButtonConfig buttonConfig;
  final LayoutConfig layoutConfig;
  final FeedbackConfig feedbackConfig;
  final ContainerConfig containerConfig;
  final SingleChildScrollViewConfig scrollViewConfig;
  final ColumnConfig columnConfig;
  final RowConfig rowConfig;
  final ExpandedConfig expandedConfig;
  final TextFieldConfig textFieldConfig;
  final InputDecorationConfig inputDecorationConfig;
  final SizedBoxConfig sizedBoxConfig;
  final ListViewConfig listViewConfig;
  final GridViewConfig gridViewConfig;
  final ScaffoldConfig scaffoldConfig;
  final SafeAreaConfig safeAreaConfig;
  final StackConfig stackConfig;
  final RotatedBoxConfig rotatedBoxConfig;
  final ClipRRectConfig clipRRectConfig;
  final ImageConfig imageConfig;
  final IconConfig iconConfig;
  final SpacerConfig spacerConfig;
  final AlignConfig alignConfig;
  final DividerConfig dividerConfig;
  final ListTileConfig listTileConfig;
  final CircleAvatarConfig circleAvatarConfig;
  final BottomNavigationBarConfig bottomNavigationBarConfig;
  final DraggableScrollableSheetConfig draggableScrollableSheetConfig;
  final TextButtonConfig textButtonConfig;
  final GestureDetectorConfig gestureDetectorConfig;
  final AspectRatioConfig aspectRatioConfig;
  final PositionedConfig positionedConfig;
  final TextEnhancedConfig textEnhancedConfig;
  final AppBarConfig appBarConfig;
  final BackButtonConfig backButtonConfig;
  final CenterConfig centerConfig;
  final InkWellConfig inkWellConfig;
  final PaddingConfig paddingConfig;
  final MaterialConfig materialConfig;
  final RotateConfig rotateConfig;
  final WrapConfig wrapConfig;

  // ─────────────────────────────────────────────────────────────────
  // ICON PROPERTIES
  // ─────────────────────────────────────────────────────────────────

  final double iconSize;
  final bool useFilledIcons;
  final Color iconColor;

  const EmotionTheme({
    required this.emotionState,
    required this.surfaceColor,
    required this.surfaceVariantColor,
    required this.primaryColor,
    required this.secondaryColor,
    required this.onSurfaceColor,
    required this.onPrimaryColor,
    required this.errorColor,
    required this.successColor,
    this.backgroundGradient,
    required this.brightnessAdjustment,
    required this.saturationAdjustment,
    required this.typography,
    required this.bodyTextStyle,
    required this.headingTextStyle,
    required this.captionTextStyle,
    required this.animation,
    required this.animatedSwitcherConfig,
    required this.buttonConfig,
    required this.layoutConfig,
    required this.feedbackConfig,
    required this.containerConfig,
    required this.scrollViewConfig,
    required this.columnConfig,
    required this.rowConfig,
    required this.expandedConfig,
    required this.textFieldConfig,
    required this.inputDecorationConfig,
    required this.sizedBoxConfig,
    required this.listViewConfig,
    required this.gridViewConfig,
    required this.scaffoldConfig,
    required this.safeAreaConfig,
    required this.stackConfig,
    required this.rotatedBoxConfig,
    required this.clipRRectConfig,
    required this.imageConfig,
    required this.iconConfig,
    required this.spacerConfig,
    required this.alignConfig,
    required this.dividerConfig,
    required this.listTileConfig,
    required this.circleAvatarConfig,
    required this.bottomNavigationBarConfig,
    required this.draggableScrollableSheetConfig,
    required this.textButtonConfig,
    required this.gestureDetectorConfig,
    required this.aspectRatioConfig,
    required this.positionedConfig,
    required this.textEnhancedConfig,
    required this.iconSize,
    required this.useFilledIcons,
    required this.iconColor,
    required this.appBarConfig,
    required this.backButtonConfig,
    required this.centerConfig,
    required this.inkWellConfig,
    required this.paddingConfig,
    required this.materialConfig,
    required this.rotateConfig,
    required this.wrapConfig
  });

  // ═══════════════════════════════════════════════════════════════════
  // FACTORY CONSTRUCTORS
  // ═══════════════════════════════════════════════════════════════════

  factory EmotionTheme.neutral() => EmotionTheme(
    emotionState: EmotionState.neutral,
    surfaceColor: const Color(0xFFFAFAFA),
    surfaceVariantColor: const Color(0xFFFFFFFF),
    primaryColor: const Color(0xFF2196F3),
    secondaryColor: const Color(0xFF03DAC6),
    onSurfaceColor: const Color(0xFF212121),
    onPrimaryColor: const Color(0xFFFFFFFF),
    errorColor: const Color(0xFFB00020),
    successColor: const Color(0xFF4CAF50),
    brightnessAdjustment: 0.0,
    saturationAdjustment: 0.0,
    typography: TypographyConfig.stable,
    bodyTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF212121), height: 1.5),
    headingTextStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFF212121), height: 1.3),
    captionTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF757575), height: 1.4),
    animation: AnimationConfig.calm,
    animatedSwitcherConfig: AnimatedSwitcherConfig.neutral,
    buttonConfig: ButtonConfig.soft,
    layoutConfig: LayoutConfig.structured,
    feedbackConfig: const FeedbackConfig(tone: FeedbackTone.neutral, supportiveMessages: ['Here\'s what you can do next.'], soundIntensity: 0.5),
    containerConfig: ContainerConfig.neutral,
    scrollViewConfig: SingleChildScrollViewConfig.neutral,
    columnConfig: ColumnConfig.neutral,
    rowConfig: RowConfig.neutral,
    expandedConfig: ExpandedConfig.neutral,
    textFieldConfig: TextFieldConfig.neutral,
    inputDecorationConfig: InputDecorationConfig.neutral,
    sizedBoxConfig: SizedBoxConfig.neutral,
    listViewConfig: ListViewConfig.neutral,
    gridViewConfig: GridViewConfig.neutral,
    scaffoldConfig: ScaffoldConfig.neutral,
    safeAreaConfig: SafeAreaConfig.neutral,
    stackConfig: StackConfig.neutral,
    rotatedBoxConfig: RotatedBoxConfig.neutral,
    clipRRectConfig: ClipRRectConfig.neutral,
    imageConfig: ImageConfig.neutral,
    iconConfig: IconConfig.neutral(const Color(0xFF757575)),
    spacerConfig: SpacerConfig.neutral,
    alignConfig: AlignConfig.neutral,
    dividerConfig: DividerConfig.standard,
    listTileConfig: ListTileConfig.standard,
    circleAvatarConfig: CircleAvatarConfig.standard,
    bottomNavigationBarConfig: BottomNavigationBarConfig.standard,
    draggableScrollableSheetConfig: DraggableScrollableSheetConfig.standard,
    textButtonConfig: TextButtonConfig.standard(const Color(0xFF2196F3)),
    gestureDetectorConfig: GestureDetectorConfig.standard,
    aspectRatioConfig: AspectRatioConfig.standard,
    positionedConfig: PositionedConfig.standard,
    textEnhancedConfig: TextEnhancedConfig.standard,
    iconSize: 24.0,
    useFilledIcons: false,
    iconColor: const Color(0xFF757575),
    appBarConfig: AppBarConfig.neutral,
    backButtonConfig: BackButtonConfig.neutral,
    centerConfig: CenterConfig.neutral,
    inkWellConfig: InkWellConfig.neutral,
    materialConfig: MaterialConfig.neutral,
    paddingConfig: PaddingConfig.neutral,
    rotateConfig: RotateConfig.neutral,
    wrapConfig: WrapConfig.neutral,
  );

  factory EmotionTheme.anger() => EmotionTheme(
    emotionState: EmotionState.anger,
    surfaceColor: const Color(0xFF2D2D2D),
    surfaceVariantColor: const Color(0xFF3D3D3D),
    primaryColor: const Color(0xFF8B5A5A),
    secondaryColor: const Color(0xFF6B7B8B),
    onSurfaceColor: const Color(0xFFE0E0E0),
    onPrimaryColor: const Color(0xFFFFFFFF),
    errorColor: const Color(0xFFCF6679),
    successColor: const Color(0xFF81C784),
    brightnessAdjustment: -0.3,
    saturationAdjustment: -0.4,
    typography: TypographyConfig.stable,
    bodyTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFE0E0E0), height: 1.6, letterSpacing: 0.5),
    headingTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFFE0E0E0), height: 1.4),
    captionTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFFBDBDBD), height: 1.5),
    animation: AnimationConfig.minimal,
    animatedSwitcherConfig: AnimatedSwitcherConfig.neutral,
    buttonConfig: ButtonConfig.muted,
    layoutConfig: LayoutConfig.structured,
    feedbackConfig: const FeedbackConfig(tone: FeedbackTone.grounding, supportiveMessages: ['Take a breath.', 'One thing at a time.'], enableSoundFeedback: false, soundIntensity: 0.1),
    containerConfig: ContainerConfig.neutral,
    scrollViewConfig: SingleChildScrollViewConfig.smooth,
    columnConfig: ColumnConfig.neutral,
    rowConfig: RowConfig.neutral,
    expandedConfig: ExpandedConfig.neutral,
    textFieldConfig: TextFieldConfig.neutral,
    inputDecorationConfig: InputDecorationConfig.neutral,
    sizedBoxConfig: SizedBoxConfig.neutral,
    listViewConfig: ListViewConfig.neutral,
    gridViewConfig: GridViewConfig.neutral,
    scaffoldConfig: ScaffoldConfig.neutral,
    safeAreaConfig: SafeAreaConfig.neutral,
    stackConfig: StackConfig.neutral,
    rotatedBoxConfig: RotatedBoxConfig.neutral,
    clipRRectConfig: ClipRRectConfig.neutral,
    imageConfig: ImageConfig.neutral,
    iconConfig: IconConfig.neutral(const Color(0xFFBDBDBD)),
    spacerConfig: SpacerConfig.neutral,
    alignConfig: AlignConfig.neutral,
    dividerConfig: DividerConfig.minimal,
    listTileConfig: ListTileConfig.minimal,
    circleAvatarConfig: CircleAvatarConfig.minimal,
    bottomNavigationBarConfig: BottomNavigationBarConfig.minimal,
    draggableScrollableSheetConfig: DraggableScrollableSheetConfig.structured,
    textButtonConfig: TextButtonConfig.minimal(const Color(0xFF8B5A5A)),
    gestureDetectorConfig: GestureDetectorConfig.minimal,
    aspectRatioConfig: AspectRatioConfig.square,
    positionedConfig: PositionedConfig.anchored,
    textEnhancedConfig: TextEnhancedConfig.calming,
    iconSize: 22.0,
    useFilledIcons: false,
    iconColor: const Color(0xFFBDBDBD),
    appBarConfig: AppBarConfig.neutral,
    backButtonConfig: BackButtonConfig.neutral,
    centerConfig: CenterConfig.neutral,
    inkWellConfig: InkWellConfig.soft,
    materialConfig: MaterialConfig.soft,
    paddingConfig: PaddingConfig.neutral,
    rotateConfig: RotateConfig.neutral,
    wrapConfig: WrapConfig.neutral,
  );

  // factory EmotionTheme.contempt() => EmotionTheme(
  //   emotionState: EmotionState.contempt,
  //   surfaceColor: const Color(0xFFF5F7FA),
  //   surfaceVariantColor: const Color(0xFFFFFFFF),
  //   primaryColor: const Color(0xFF5C6B7A),
  //   secondaryColor: const Color(0xFF8899AA),
  //   onSurfaceColor: const Color(0xFF37474F),
  //   onPrimaryColor: const Color(0xFFFFFFFF),
  //   errorColor: const Color(0xFFB00020),
  //   successColor: const Color(0xFF388E3C),
  //   brightnessAdjustment: 0.0,
  //   saturationAdjustment: -0.3,
  //   typography: TypographyConfig.stable,
  //   bodyTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF37474F), height: 1.6, letterSpacing: 0.3),
  //   headingTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFF263238), height: 1.3),
  //   captionTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF78909C), height: 1.4),
  //   animation: AnimationConfig.minimal,
  //   animatedSwitcherConfig: AnimatedSwitcherConfig.neutral,
  //   buttonConfig: ButtonConfig.muted,
  //   layoutConfig: LayoutConfig.structured,
  //   feedbackConfig: const FeedbackConfig(tone: FeedbackTone.neutral, supportiveMessages: ['Here\'s what you can do next.'], soundIntensity: 0.2),
  //   containerConfig: ContainerConfig.neutral,
  //   scrollViewConfig: SingleChildScrollViewConfig.neutral,
  //   columnConfig: ColumnConfig.neutral,
  //   rowConfig: RowConfig.neutral,
  //   expandedConfig: ExpandedConfig.neutral,
  //   textFieldConfig: TextFieldConfig.neutral,
  //   inputDecorationConfig: InputDecorationConfig.neutral,
  //   sizedBoxConfig: SizedBoxConfig.neutral,
  //   listViewConfig: ListViewConfig.neutral,
  //   gridViewConfig: GridViewConfig.neutral,
  //   scaffoldConfig: ScaffoldConfig.neutral,
  //   safeAreaConfig: SafeAreaConfig.neutral,
  //   stackConfig: StackConfig.neutral,
  //   rotatedBoxConfig: RotatedBoxConfig.neutral,
  //   clipRRectConfig: ClipRRectConfig.neutral,
  //   imageConfig: ImageConfig.neutral,
  //   iconConfig: IconConfig.neutral(const Color(0xFF607D8B)),
  //   spacerConfig: SpacerConfig.neutral,
  //   alignConfig: AlignConfig.neutral,
  //   dividerConfig: DividerConfig.standard,
  //   listTileConfig: ListTileConfig.standard,
  //   circleAvatarConfig: CircleAvatarConfig.standard,
  //   bottomNavigationBarConfig: BottomNavigationBarConfig.standard,
  //   draggableScrollableSheetConfig: DraggableScrollableSheetConfig.standard,
  //   textButtonConfig: TextButtonConfig.standard(const Color(0xFF5C6B7A)),
  //   gestureDetectorConfig: GestureDetectorConfig.standard,
  //   aspectRatioConfig: AspectRatioConfig.standard,
  //   positionedConfig: PositionedConfig.distant,
  //   textEnhancedConfig: TextEnhancedConfig.precise,
  //   iconSize: 22.0,
  //   useFilledIcons: false,
  //   iconColor: const Color(0xFF607D8B),
  //   appBarConfig: AppBarConfig.neutral,
  //   backButtonConfig: BackButtonConfig.neutral,
  //   centerConfig: CenterConfig.neutral,
  //   inkWellConfig: InkWellConfig.neutral,
  //   materialConfig: MaterialConfig.neutral,
  //   paddingConfig: PaddingConfig.neutral,
  //   rotateConfig: RotateConfig.neutral,
  //   wrapConfig: WrapConfig.neutral,
  //
  // );

  factory EmotionTheme.disgust() => EmotionTheme(
    emotionState: EmotionState.disgust,
    surfaceColor: const Color(0xFFFFFFFFF),
    surfaceVariantColor: const Color(0xFFF8F9FA),
    primaryColor: const Color(0xFF90A4AE),
    secondaryColor: const Color(0xFFB0BEC5),
    onSurfaceColor: const Color(0xFF455A64),
    onPrimaryColor: const Color(0xFFFFFFFF),
    errorColor: const Color(0xFFE57373),
    successColor: const Color(0xFF81C784),
    brightnessAdjustment: 0.15,
    saturationAdjustment: -0.2,
    typography: TypographyConfig.friendly,
    bodyTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF455A64), height: 1.7),
    headingTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFF37474F), height: 1.4),
    captionTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color(0xFF78909C), height: 1.5),
    animation: AnimationConfig.calm,
    animatedSwitcherConfig: AnimatedSwitcherConfig.neutral,
    buttonConfig: const ButtonConfig(borderRadius: 12.0, elevation: 1.0, hoverScale: 1.01, padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
    layoutConfig: const LayoutConfig(spacingMultiplier: 1.4, cardBorderRadius: 12.0, shadowIntensity: 0.08, enforceStrictGrid: true),
    feedbackConfig: const FeedbackConfig(tone: FeedbackTone.neutral, supportiveMessages: ['Let\'s keep things simple.'], soundIntensity: 0.3),
    containerConfig: ContainerConfig.neutral,
    scrollViewConfig: SingleChildScrollViewConfig.neutral,
    columnConfig: ColumnConfig.neutral,
    rowConfig: RowConfig.neutral,
    expandedConfig: ExpandedConfig.neutral,
    textFieldConfig: TextFieldConfig.neutral,
    inputDecorationConfig: InputDecorationConfig.neutral,
    sizedBoxConfig: SizedBoxConfig.neutral,
    listViewConfig: ListViewConfig.neutral,
    gridViewConfig: GridViewConfig.neutral,
    scaffoldConfig: ScaffoldConfig.neutral,
    safeAreaConfig: SafeAreaConfig.neutral,
    stackConfig: StackConfig.neutral,
    rotatedBoxConfig: RotatedBoxConfig.neutral,
    clipRRectConfig: ClipRRectConfig.neutral,
    imageConfig: ImageConfig.neutral,
    iconConfig: IconConfig.neutral(const Color(0xFF78909C)),
    spacerConfig: SpacerConfig.neutral,
    alignConfig: AlignConfig.neutral,
    dividerConfig: DividerConfig.visible,
    listTileConfig: ListTileConfig.spacious,
    circleAvatarConfig: CircleAvatarConfig.clean,
    bottomNavigationBarConfig: BottomNavigationBarConfig.clean,
    draggableScrollableSheetConfig: DraggableScrollableSheetConfig.clean,
    textButtonConfig: TextButtonConfig.clean(const Color(0xFF90A4AE)),
    gestureDetectorConfig: GestureDetectorConfig.subtle,
    aspectRatioConfig: AspectRatioConfig.golden,
    positionedConfig: PositionedConfig.distant,
    textEnhancedConfig: TextEnhancedConfig.clean,
    iconSize: 22.0,
    useFilledIcons: false,
    iconColor: const Color(0xFF78909C),
    appBarConfig: AppBarConfig.neutral,
    backButtonConfig: BackButtonConfig.neutral,
    centerConfig: CenterConfig.neutral,
    inkWellConfig: InkWellConfig.neutral,
    materialConfig: MaterialConfig.neutral,
    paddingConfig: PaddingConfig.neutral,
    rotateConfig: RotateConfig.neutral,
    wrapConfig: WrapConfig.neutral,
  );

  factory EmotionTheme.enjoyment() => EmotionTheme(
    emotionState: EmotionState.enjoyment,
    surfaceColor: const Color(0xFFFFFDE7),
    surfaceVariantColor: const Color(0xFFFFFFFF),
    primaryColor: const Color(0xFF4CAF50),
    secondaryColor: const Color(0xFF81D4FA),
    onSurfaceColor: const Color(0xFF33691E),
    onPrimaryColor: const Color(0xFFFFFFFF),
    errorColor: const Color(0xFFE57373),
    successColor: const Color(0xFF66BB6A),
    backgroundGradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFFFFDE7), Color(0xFFE8F5E9)]),
    brightnessAdjustment: 0.25,
    saturationAdjustment: 0.2,
    typography: TypographyConfig.expressive,
    bodyTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xFF33691E), height: 1.6, letterSpacing: 0.4),
    headingTextStyle: const TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Color(0xFF1B5E20), height: 1.3),
    captionTextStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF558B2F), height: 1.4),
    animation: AnimationConfig.lively,
    animatedSwitcherConfig: AnimatedSwitcherConfig.lively,
    buttonConfig: ButtonConfig.lively,
    layoutConfig: LayoutConfig.airy,
    feedbackConfig: const FeedbackConfig(tone: FeedbackTone.encouraging, supportiveMessages: ['You\'re doing great!', 'Awesome progress!'], soundIntensity: 0.7),
    containerConfig: ContainerConfig.lively,
    scrollViewConfig: SingleChildScrollViewConfig.fast,
    columnConfig: ColumnConfig.lively,
    rowConfig: RowConfig.lively,
    expandedConfig: ExpandedConfig.lively,
    textFieldConfig: TextFieldConfig.lively,
    inputDecorationConfig: InputDecorationConfig.lively,
    sizedBoxConfig: SizedBoxConfig.lively,
    listViewConfig: ListViewConfig.lively,
    gridViewConfig: GridViewConfig.lively,
    scaffoldConfig: ScaffoldConfig.lively,
    safeAreaConfig: SafeAreaConfig.lively,
    stackConfig: StackConfig.lively,
    rotatedBoxConfig: RotatedBoxConfig.lively,
    clipRRectConfig: ClipRRectConfig.lively,
    imageConfig: ImageConfig.lively,
    iconConfig: IconConfig.lively(const Color(0xFF4CAF50)),
    spacerConfig: SpacerConfig.lively,
    alignConfig: AlignConfig.lively,
    dividerConfig: DividerConfig.prominent,
    listTileConfig: ListTileConfig.expressive,
    circleAvatarConfig: CircleAvatarConfig.expressive,
    bottomNavigationBarConfig: BottomNavigationBarConfig.expressive,
    draggableScrollableSheetConfig: DraggableScrollableSheetConfig.flexible,
    textButtonConfig: TextButtonConfig.expressive(const Color(0xFF4CAF50)),
    gestureDetectorConfig: GestureDetectorConfig.expressive,
    aspectRatioConfig: AspectRatioConfig.widescreen,
    positionedConfig: PositionedConfig.dynamicAsymmetric,
    textEnhancedConfig: TextEnhancedConfig.expressive(const Color(0xFF4CAF50)),
    iconSize: 26.0,
    useFilledIcons: true,
    iconColor: const Color(0xFF4CAF50),
    appBarConfig: AppBarConfig.lively,
    backButtonConfig: BackButtonConfig.lively,
    centerConfig: CenterConfig.lively,
    inkWellConfig: InkWellConfig.lively,
    materialConfig: MaterialConfig.lively,
    paddingConfig: PaddingConfig.lively,
    rotateConfig: RotateConfig.lively,
    wrapConfig: WrapConfig.lively,
  );

  factory EmotionTheme.fear() => EmotionTheme(
    emotionState: EmotionState.fear,
    surfaceColor: const Color(0xFFE8EAF6),
    surfaceVariantColor: const Color(0xFFF3E5F5),
    primaryColor: const Color(0xFF7986CB),
    secondaryColor: const Color(0xFF9FA8DA),
    onSurfaceColor: const Color(0xFF303F9F),
    onPrimaryColor: const Color(0xFFFFFFFF),
    errorColor: const Color(0xFFEF9A9A),
    successColor: const Color(0xFFA5D6A7),
    brightnessAdjustment: -0.1,
    saturationAdjustment: -0.3,
    typography: TypographyConfig.stable,
    bodyTextStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Color(0xFF303F9F), height: 1.7, letterSpacing: 0.4),
    headingTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFF1A237E), height: 1.4),
    captionTextStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400, color: Color(0xFF5C6BC0), height: 1.5),
    animation: const AnimationConfig(transitionDuration: Duration(milliseconds: 500), microInteractionDuration: Duration(milliseconds: 350), animationCurve: Curves.easeInOut, allowPlayfulAnimations: false, useSmoothTransitionsOnly: true),
    animatedSwitcherConfig: AnimatedSwitcherConfig.neutral,
    buttonConfig: ButtonConfig.soft,
    layoutConfig: const LayoutConfig(spacingMultiplier: 1.5, cardBorderRadius: 12.0, shadowIntensity: 0.05, enforceStrictGrid: true),
    feedbackConfig: const FeedbackConfig(tone: FeedbackTone.reassuring, supportiveMessages: ['You\'re safe here.', 'Take your time.'], enableSoundFeedback: false, soundIntensity: 0.15),
    containerConfig: ContainerConfig.neutral,
    scrollViewConfig: SingleChildScrollViewConfig.smooth,
    columnConfig: ColumnConfig.neutral,
    rowConfig: RowConfig.neutral,
    expandedConfig: ExpandedConfig.neutral,
    textFieldConfig: TextFieldConfig.neutral,
    inputDecorationConfig: InputDecorationConfig.neutral,
    sizedBoxConfig: SizedBoxConfig.neutral,
    listViewConfig: ListViewConfig.neutral,
    gridViewConfig: GridViewConfig.neutral,
    scaffoldConfig: ScaffoldConfig.neutral,
    safeAreaConfig: SafeAreaConfig.neutral,
    stackConfig: StackConfig.neutral,
    rotatedBoxConfig: RotatedBoxConfig.neutral,
    clipRRectConfig: ClipRRectConfig.neutral,
    imageConfig: ImageConfig.neutral,
    iconConfig: IconConfig.neutral(const Color(0xFF7986CB)),
    spacerConfig: SpacerConfig.neutral,
    alignConfig: AlignConfig.neutral,
    dividerConfig: DividerConfig.gentle,
    listTileConfig: ListTileConfig.standard,
    circleAvatarConfig: CircleAvatarConfig.standard,
    bottomNavigationBarConfig: BottomNavigationBarConfig.stable,
    draggableScrollableSheetConfig: DraggableScrollableSheetConfig.contained,
    textButtonConfig: TextButtonConfig.stable(const Color(0xFF7986CB)),
    gestureDetectorConfig: GestureDetectorConfig.subtle,
    aspectRatioConfig: AspectRatioConfig.square,
    positionedConfig: PositionedConfig.anchored,
    textEnhancedConfig: TextEnhancedConfig.spacious,
    iconSize: 24.0,
    useFilledIcons: false,
    iconColor: const Color(0xFF7986CB),
    appBarConfig: AppBarConfig.soft,
    backButtonConfig: BackButtonConfig.soft,
    centerConfig: CenterConfig.soft,
    inkWellConfig: InkWellConfig.soft,
    materialConfig: MaterialConfig.soft,
    paddingConfig: PaddingConfig.soft,
    rotateConfig: RotateConfig.soft,
    wrapConfig: WrapConfig.soft,
  );

  factory EmotionTheme.sadness() => EmotionTheme(
    emotionState: EmotionState.sadness,
    surfaceColor: const Color(0xFFEDE7F6),
    surfaceVariantColor: const Color(0xFFE1F5FE),
    primaryColor: const Color(0xFF7E57C2),
    secondaryColor: const Color(0xFF90CAF9),
    onSurfaceColor: const Color(0xFF4527A0),
    onPrimaryColor: const Color(0xFFFFFFFF),
    errorColor: const Color(0xFFE57373),
    successColor: const Color(0xFF81C784),
    backgroundGradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFEDE7F6), Color(0xFFE3F2FD)]),
    brightnessAdjustment: -0.25,
    saturationAdjustment: -0.2,
    typography: const TypographyConfig(fontFamily: 'Nunito', baseFontSize: 16.0, letterSpacingMultiplier: 1.2, lineHeightMultiplier: 1.7, bodyWeight: FontWeight.w400, headingWeight: FontWeight.w500, useItalicAccents: true),
    bodyTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFF4527A0), height: 1.7),
    headingTextStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Color(0xFF311B92), height: 1.4),
    captionTextStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.italic, color: Color(0xFF7E57C2), height: 1.5),
    animation: const AnimationConfig(transitionDuration: Duration(milliseconds: 600), microInteractionDuration: Duration(milliseconds: 400), animationCurve: Curves.easeInOut, allowPlayfulAnimations: false, useSmoothTransitionsOnly: true),
    animatedSwitcherConfig: AnimatedSwitcherConfig.soft,
    buttonConfig: const ButtonConfig(borderRadius: 14.0, elevation: 1.0, hoverScale: 1.01, padding: EdgeInsets.symmetric(horizontal: 22, vertical: 14)),
    layoutConfig: const LayoutConfig(spacingMultiplier: 1.4, cardBorderRadius: 14.0, shadowIntensity: 0.08, enforceStrictGrid: false),
    feedbackConfig: const FeedbackConfig(tone: FeedbackTone.comforting, supportiveMessages: ['Take a moment for yourself.', 'It\'s okay to rest.'], soundIntensity: 0.2),
    containerConfig: ContainerConfig.soft,
    scrollViewConfig: SingleChildScrollViewConfig.smooth,
    columnConfig: ColumnConfig.soft,
    rowConfig: RowConfig.soft,
    expandedConfig: ExpandedConfig.soft,
    textFieldConfig: TextFieldConfig.soft,
    inputDecorationConfig: InputDecorationConfig.soft,
    sizedBoxConfig: SizedBoxConfig.soft,
    listViewConfig: ListViewConfig.soft,
    gridViewConfig: GridViewConfig.soft,
    scaffoldConfig: ScaffoldConfig.soft,
    safeAreaConfig: SafeAreaConfig.soft,
    stackConfig: StackConfig.soft,
    rotatedBoxConfig: RotatedBoxConfig.soft,
    clipRRectConfig: ClipRRectConfig.soft,
    imageConfig: ImageConfig.soft,
    iconConfig: IconConfig.soft(const Color(0xFF9575CD)),
    spacerConfig: SpacerConfig.soft,
    alignConfig: AlignConfig.soft,
    dividerConfig: DividerConfig.gentle,
    listTileConfig: ListTileConfig.gentle,
    circleAvatarConfig: CircleAvatarConfig.gentle,
    bottomNavigationBarConfig: BottomNavigationBarConfig.gentle,
    draggableScrollableSheetConfig: DraggableScrollableSheetConfig.gentle,
    textButtonConfig: TextButtonConfig.gentle(const Color(0xFF7E57C2)),
    gestureDetectorConfig: GestureDetectorConfig.gentle,
    aspectRatioConfig: AspectRatioConfig.standard,
    positionedConfig: PositionedConfig.grounded,
    textEnhancedConfig: TextEnhancedConfig.gentle,
    iconSize: 22.0,
    useFilledIcons: false,
    iconColor: const Color(0xFF9575CD),
    appBarConfig: AppBarConfig.soft,
    backButtonConfig: BackButtonConfig.soft,
    centerConfig: CenterConfig.soft,
    inkWellConfig: InkWellConfig.soft,
    materialConfig: MaterialConfig.soft,
    paddingConfig: PaddingConfig.soft,
    rotateConfig: RotateConfig.soft,
    wrapConfig: WrapConfig.soft,
  );

  factory EmotionTheme.surprise() => EmotionTheme(
    emotionState: EmotionState.surprise,
    surfaceColor: const Color(0xFF1A1A2E),
    surfaceVariantColor: const Color(0xFF16213E),
    primaryColor: const Color(0xFFFFB300),
    secondaryColor: const Color(0xFF00BCD4),
    onSurfaceColor: const Color(0xFFFFFFFF),
    onPrimaryColor: const Color(0xFF1A1A2E),
    errorColor: const Color(0xFFFF5252),
    successColor: const Color(0xFF69F0AE),
    backgroundGradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF1A1A2E), Color(0xFF0F3460)]),
    brightnessAdjustment: 0.1,
    saturationAdjustment: 0.3,
    typography: TypographyConfig.expressive,
    bodyTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xFFE0E0E0), height: 1.5),
    headingTextStyle: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFFFFFFFF), height: 1.2),
    captionTextStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFFB0BEC5), height: 1.4),
    animation: const AnimationConfig(transitionDuration: Duration(milliseconds: 250), microInteractionDuration: Duration(milliseconds: 150), animationCurve: Curves.easeOutBack, allowPlayfulAnimations: true, useSmoothTransitionsOnly: false),
    animatedSwitcherConfig: AnimatedSwitcherConfig.lively,
    buttonConfig: const ButtonConfig(borderRadius: 12.0, elevation: 6.0, hoverScale: 1.08, useGradient: true, padding: EdgeInsets.symmetric(horizontal: 28, vertical: 16)),
    layoutConfig: LayoutConfig.dynamic,
    feedbackConfig: const FeedbackConfig(tone: FeedbackTone.encouraging, supportiveMessages: ['Wow!', 'Surprise!'], soundIntensity: 0.8),
    containerConfig: ContainerConfig.lively,
    scrollViewConfig: SingleChildScrollViewConfig.fast,
    columnConfig: ColumnConfig.lively,
    rowConfig: RowConfig.lively,
    expandedConfig: ExpandedConfig.lively,
    textFieldConfig: TextFieldConfig.lively,
    inputDecorationConfig: InputDecorationConfig.lively,
    sizedBoxConfig: SizedBoxConfig.lively,
    listViewConfig: ListViewConfig.lively,
    gridViewConfig: GridViewConfig.lively,
    scaffoldConfig: ScaffoldConfig.lively,
    safeAreaConfig: SafeAreaConfig.lively,
    stackConfig: StackConfig.lively,
    rotatedBoxConfig: RotatedBoxConfig.lively,
    clipRRectConfig: ClipRRectConfig.lively,
    imageConfig: ImageConfig.lively,
    iconConfig: IconConfig.lively(const Color(0xFFFFB300)),
    spacerConfig: SpacerConfig.lively,
    alignConfig: AlignConfig.lively,
    dividerConfig: DividerConfig.prominent,
    listTileConfig: ListTileConfig.dynamic,
    circleAvatarConfig: CircleAvatarConfig.dynamic,
    bottomNavigationBarConfig: BottomNavigationBarConfig.dynamic,
    draggableScrollableSheetConfig: DraggableScrollableSheetConfig.dynamic,
    textButtonConfig: TextButtonConfig.dynamic(const Color(0xFF00BCD4)),
    gestureDetectorConfig: GestureDetectorConfig.dynamic,
    aspectRatioConfig: AspectRatioConfig.dynamic,
    positionedConfig: PositionedConfig.dynamicAsymmetric,
    textEnhancedConfig: TextEnhancedConfig.bold,
    iconSize: 28.0,
    useFilledIcons: true,
    iconColor: const Color(0xFFFFB300),
    appBarConfig: AppBarConfig.lively,
    backButtonConfig: BackButtonConfig.lively,
    centerConfig: CenterConfig.lively,
    inkWellConfig: InkWellConfig.lively,
    materialConfig: MaterialConfig.lively,
    paddingConfig: PaddingConfig.lively,
    rotateConfig: RotateConfig.lively,
    wrapConfig: WrapConfig.lively,
  );

  factory EmotionTheme.fromState(EmotionState state) {
    switch (state) {
      case EmotionState.neutral: return EmotionTheme.neutral();
      case EmotionState.anger: return EmotionTheme.anger();
      case EmotionState.disgust: return EmotionTheme.disgust();
      case EmotionState.enjoyment: return EmotionTheme.enjoyment();
      case EmotionState.fear: return EmotionTheme.fear();
      case EmotionState.sadness: return EmotionTheme.sadness();
      case EmotionState.surprise: return EmotionTheme.surprise();
    }
  }

  bool get isPositive => emotionState == EmotionState.enjoyment || emotionState == EmotionState.surprise;
  bool get isNegative => emotionState == EmotionState.anger || emotionState == EmotionState.disgust || emotionState == EmotionState.fear || emotionState == EmotionState.sadness;
  double get baseSpacing => 8.0 * layoutConfig.spacingMultiplier;
  String get randomSupportiveMessage {
    final messages = feedbackConfig.supportiveMessages;
    return messages[DateTime.now().millisecond % messages.length];
  }

  ThemeData toThemeData() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: brightnessAdjustment < 0 ? Brightness.dark : Brightness.light,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        secondary: secondaryColor,
        onSecondary: onPrimaryColor,
        error: errorColor,
        onError: onPrimaryColor,
        surface: surfaceColor,
        onSurface: onSurfaceColor,
      ),
      scaffoldBackgroundColor: surfaceColor,
      cardTheme: CardThemeData(color: surfaceVariantColor, elevation: layoutConfig.shadowIntensity * 10, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(layoutConfig.cardBorderRadius))),
      elevatedButtonTheme: ElevatedButtonThemeData(style: ElevatedButton.styleFrom(backgroundColor: primaryColor, foregroundColor: onPrimaryColor, elevation: buttonConfig.elevation, padding: buttonConfig.padding, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(buttonConfig.borderRadius)))),
      textTheme: TextTheme(bodyLarge: bodyTextStyle, bodyMedium: bodyTextStyle.copyWith(fontSize: bodyTextStyle.fontSize! - 2), headlineLarge: headingTextStyle, headlineMedium: headingTextStyle.copyWith(fontSize: headingTextStyle.fontSize! - 4), labelSmall: captionTextStyle),
      iconTheme: IconThemeData(size: iconSize, color: iconColor),
    );
  }

  static EmotionTheme lerp(EmotionTheme a, EmotionTheme b, double t) {
    return EmotionTheme(
      emotionState: t < 0.5 ? a.emotionState : b.emotionState,
      surfaceColor: Color.lerp(a.surfaceColor, b.surfaceColor, t)!,
      surfaceVariantColor: Color.lerp(a.surfaceVariantColor, b.surfaceVariantColor, t)!,
      primaryColor: Color.lerp(a.primaryColor, b.primaryColor, t)!,
      secondaryColor: Color.lerp(a.secondaryColor, b.secondaryColor, t)!,
      onSurfaceColor: Color.lerp(a.onSurfaceColor, b.onSurfaceColor, t)!,
      onPrimaryColor: Color.lerp(a.onPrimaryColor, b.onPrimaryColor, t)!,
      errorColor: Color.lerp(a.errorColor, b.errorColor, t)!,
      successColor: Color.lerp(a.successColor, b.successColor, t)!,
      backgroundGradient: t < 0.5 ? a.backgroundGradient : b.backgroundGradient,
      brightnessAdjustment: NormalizationUtils.lerpDouble(a.brightnessAdjustment, b.brightnessAdjustment, t),
      saturationAdjustment: NormalizationUtils.lerpDouble(a.saturationAdjustment, b.saturationAdjustment, t),
      typography: t < 0.5 ? a.typography : b.typography,
      bodyTextStyle: TextStyle.lerp(a.bodyTextStyle, b.bodyTextStyle, t)!,
      headingTextStyle: TextStyle.lerp(a.headingTextStyle, b.headingTextStyle, t)!,
      captionTextStyle: TextStyle.lerp(a.captionTextStyle, b.captionTextStyle, t)!,
      animation: t < 0.5 ? a.animation : b.animation,
      animatedSwitcherConfig: t < 0.5 ? a.animatedSwitcherConfig : b.animatedSwitcherConfig,
      buttonConfig: t < 0.5 ? a.buttonConfig : b.buttonConfig,
      layoutConfig: t < 0.5 ? a.layoutConfig : b.layoutConfig,
      feedbackConfig: t < 0.5 ? a.feedbackConfig : b.feedbackConfig,
      containerConfig: t < 0.5 ? a.containerConfig : b.containerConfig,
      scrollViewConfig: t < 0.5 ? a.scrollViewConfig : b.scrollViewConfig,
      columnConfig: t < 0.5 ? a.columnConfig : b.columnConfig,
      rowConfig: t < 0.5 ? a.rowConfig : b.rowConfig,
      expandedConfig: t < 0.5 ? a.expandedConfig : b.expandedConfig,
      textFieldConfig: t < 0.5 ? a.textFieldConfig : b.textFieldConfig,
      inputDecorationConfig: t < 0.5 ? a.inputDecorationConfig : b.inputDecorationConfig,
      sizedBoxConfig: t < 0.5 ? a.sizedBoxConfig : b.sizedBoxConfig,
      listViewConfig: t < 0.5 ? a.listViewConfig : b.listViewConfig,
      gridViewConfig: t < 0.5 ? a.gridViewConfig : b.gridViewConfig,
      scaffoldConfig: t < 0.5 ? a.scaffoldConfig : b.scaffoldConfig,
      safeAreaConfig: t < 0.5 ? a.safeAreaConfig : b.safeAreaConfig,
      stackConfig: t < 0.5 ? a.stackConfig : b.stackConfig,
      rotatedBoxConfig: t < 0.5 ? a.rotatedBoxConfig : b.rotatedBoxConfig,
      clipRRectConfig: t < 0.5 ? a.clipRRectConfig : b.clipRRectConfig,
      imageConfig: t < 0.5 ? a.imageConfig : b.imageConfig,
      iconConfig: t < 0.5 ? a.iconConfig : b.iconConfig,
      spacerConfig: t < 0.5 ? a.spacerConfig : b.spacerConfig,
      alignConfig: t < 0.5 ? a.alignConfig : b.alignConfig,
      dividerConfig: t < 0.5 ? a.dividerConfig : b.dividerConfig,
      listTileConfig: t < 0.5 ? a.listTileConfig : b.listTileConfig,
      circleAvatarConfig: t < 0.5 ? a.circleAvatarConfig : b.circleAvatarConfig,
      bottomNavigationBarConfig: t < 0.5 ? a.bottomNavigationBarConfig : b.bottomNavigationBarConfig,
      draggableScrollableSheetConfig: t < 0.5 ? a.draggableScrollableSheetConfig : b.draggableScrollableSheetConfig,
      textButtonConfig: t < 0.5 ? a.textButtonConfig : b.textButtonConfig,
      gestureDetectorConfig: t < 0.5 ? a.gestureDetectorConfig : b.gestureDetectorConfig,
      aspectRatioConfig: t < 0.5 ? a.aspectRatioConfig : b.aspectRatioConfig,
      positionedConfig: t < 0.5 ? a.positionedConfig : b.positionedConfig,
      textEnhancedConfig: t < 0.5 ? a.textEnhancedConfig : b.textEnhancedConfig,
      iconSize: NormalizationUtils.lerpDouble(a.iconSize, b.iconSize, t),
      useFilledIcons: t < 0.5 ? a.useFilledIcons : b.useFilledIcons,
      iconColor: Color.lerp(a.iconColor, b.iconColor, t)!,
      appBarConfig: t < 0.5 ? a.appBarConfig : b.appBarConfig,
      backButtonConfig: t < 0.5 ? a.backButtonConfig : b.backButtonConfig,
      centerConfig: t < 0.5 ? a.centerConfig : b.centerConfig,
      inkWellConfig: t < 0.5 ? a.inkWellConfig : b.inkWellConfig,
      materialConfig: t < 0.5 ? a.materialConfig : b.materialConfig,
      paddingConfig: t < 0.5 ? a.paddingConfig : b.paddingConfig,
      rotateConfig: t < 0.5 ? a.rotateConfig : b.rotateConfig,
      wrapConfig: t < 0.5 ? a.wrapConfig : b.wrapConfig,
    );
  }

  @override
  bool operator == (Object other) {
    if (identical(this, other)) return true;
    return other is EmotionTheme &&
        other.emotionState == emotionState &&
        other.surfaceColor == surfaceColor &&
        other.primaryColor == primaryColor &&
        other.onSurfaceColor == onSurfaceColor;
  }

  @override
  int get hashCode => emotionState.hashCode ^ surfaceColor.hashCode ^ primaryColor.hashCode ^ onSurfaceColor.hashCode;

  @override
  String toString() => 'EmotionTheme(state: $emotionState)';
}
