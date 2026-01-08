/// Sentient UI: An Emotion-Aware Adaptive User Interface Framework for Flutter.
///
/// This package provides a comprehensive framework for creating Flutter applications
/// that can detect user emotions and adapt the user interface in real-time.
/// It uses on-device machine learning for privacy-preserving emotion detection
/// and a rule-based engine to trigger UI adaptations based on the user's emotional state.
library;

// --- Core Engine ---
export 'src/core/sentient_engine.dart';
export 'src/core/sentient_config.dart';

// --- App Wrapper ---
export 'src/sentient_app.dart';

// --- Data Models ---
export 'src/models/emotion_result.dart';
export 'src/models/behavior_state.dart';
export 'src/models/context_state.dart';
export 'src/models/emotion_state.dart';
export 'src/models/context_result.dart';
export 'src/models/network_type.dart';

// --- Logic Layer ---
export 'src/logic/state_manager.dart';
export 'src/logic/adaptation_manager.dart';

// --- UI Layer ---
// Note: EmotionTheme exports all UI Configs (ButtonConfig, LayoutConfig, etc.), 
// so they are available implicitly without separate exports here.
export 'src/ui/foundation/emotion_theme.dart';
export 'src/ui/foundation/animated_emotion_theme.dart';

// --- UI Widgets ---
export 'src/ui/widgets/sentient_icon.dart';
export 'src/ui/widgets/sentient_text.dart';
export 'src/ui/widgets/sentient_image.dart';
export 'src/ui/widgets/sentient_divider.dart';
export 'src/ui/widgets/sentient_list_tile.dart';
export 'src/ui/widgets/sentient_circle_avatar.dart';
export 'src/ui/widgets/sentient_text_enhanced.dart';
export 'src/ui/widgets/sentient_scroll_observer.dart';
export 'src/ui/widgets/sentient_bottom_navigation_bar.dart';
export 'src/ui/widgets/sentient_bottom_navigation_bar_item.dart';
export 'src/ui/widgets/sentient_draggable_scrollable_sheet.dart';
export 'src/ui/widgets/sentient_wrap.dart';
export 'src/ui/widgets/sentient_center.dart';
export 'src/ui/widgets/sentient_rotate.dart';
export 'src/ui/widgets/sentient_app_bar.dart';
export 'src/ui/widgets/sentient_padding.dart';
export 'src/ui/widgets/sentient_ink_well.dart';
export 'src/ui/widgets/sentient_material.dart';
export 'src/ui/widgets/sentient_back_button.dart';
export 'src/ui/widgets/sentient_consent_view.dart';

// --- UI Layout ---
export 'src/ui/layout/sentient_row.dart';
export 'src/ui/layout/sentient_align.dart';
export 'src/ui/layout/sentient_stack.dart';
export 'src/ui/layout/sentient_column.dart';
export 'src/ui/layout/sentient_spacer.dart';
export 'src/ui/layout/sentient_expanded.dart';
export 'src/ui/layout/sentient_scaffold.dart';
export 'src/ui/layout/sentient_container.dart';
export 'src/ui/layout/sentient_grid_view.dart';
export 'src/ui/layout/sentient_list_view.dart';
export 'src/ui/layout/sentient_safe_area.dart';
export 'src/ui/layout/sentient_sized_box.dart';
export 'src/ui/layout/sentient_positioned.dart';
export 'src/ui/layout/sentient_clip_r_rect.dart';
export 'src/ui/layout/sentient_rotated_box.dart';
export 'src/ui/layout/sentient_aspect_ratio.dart';
export 'src/ui/layout/sentient_single_child_scroll_view.dart';

// --- UI Inputs ---
export 'src/ui/inputs/sentient_text_field.dart';
export 'src/ui/inputs/sentient_text_button.dart';
export 'src/ui/inputs/sentient_gesture_detector.dart';

// --- UI Animations ---
export 'src/ui/animations/sentient_animated_builder.dart';
export 'src/ui/animations/sentient_animated_opacity.dart';
export 'src/ui/animations/sentient_animated_switcher.dart';
