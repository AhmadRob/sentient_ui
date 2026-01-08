# Details

Date : 2025-12-26 23:34:34

Directory d:\\My other stuff\\AndroidStudioProjects\\Flutter\\sentient_ui_demo\\packages\\sentient_ui

Total : 85 files,  5670 codes, 2125 comments, 1208 blanks, all 9003 lines

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)

## Files
| filename                                                                                                                                                   | language | code | comment | blank | total |
|:-----------------------------------------------------------------------------------------------------------------------------------------------------------| :--- | ---: | ---: | ---: | ---: |
| [packages/sentient\_ui/CHANGELOG.md](/packages/sentient_ui/CHANGELOG.md)                                                                                   | Markdown | 2 | 0 | 2 | 4 |
| [packages/sentient\_ui/README.md](/packages/sentient_ui/README.md)                                                                                         | Markdown | 84 | 0 | 38 | 122 |
| [packages/sentient\_ui/analysis\_options.yaml](/packages/sentient_ui/analysis_options.yaml)                                                                | YAML | 1 | 2 | 2 | 5 |
| [packages/sentient\_ui/assets/config.json](/packages/sentient_ui/assets/config.json)                                                                       | JSON | 24 | 0 | 0 | 24 |
| [packages/sentient\_ui/devtools\_options.yaml](/packages/sentient_ui/devtools_options.yaml)                                                                | YAML | 4 | 0 | 0 | 4 |
| [packages/sentient\_ui/lib/others/emotion\_theme\_v2.dart](/packages/sentient_ui/lib/others/emotion_theme_v2.dart)                                         | Dart | 28 | 10 | 9 | 47 |
| [packages/sentient\_ui/lib/sentient\_ui.dart](/packages/sentient_ui/lib/sentient_ui.dart)                                                                  | Dart | 16 | 8 | 7 | 31 |
| [packages/sentient\_ui/lib/src/core/sentient\_engine.dart](/packages/sentient_ui/lib/src/domain/facades/sentient_engine_facade.dart)                                 | Dart | 113 | 24 | 31 | 168 |
| [packages/sentient\_ui/lib/src/sensing/behavior\_tracker.dart](/packages/sentient_ui/lib/src/sensing/trackers/tap_behavior_tracker.dart)                                | Dart | 31 | 21 | 14 | 66 |
| [packages/sentient\_ui/lib/src/sensing/context\_manager.dart](/packages/sentient_ui/lib/src/sensing/providers/context_manager.dart)                                  | Dart | 58 | 30 | 21 | 109 |
| [packages/sentient\_ui/lib/src/sensing/emotion\_detector.dart](/packages/sentient_ui/lib/src/sensing/detectors/camera_emotion_detector.dart)                                    | Dart | 86 | 7 | 20 | 113 |
| [packages/sentient\_ui/lib/src/logic/adaptation\_manager.dart](/packages/sentient_ui/lib/src/decision/adaptation_manager.dart)                                | Dart | 42 | 15 | 10 | 67 |
| [packages/sentient\_ui/lib/src/logic/rule\_engine.dart](/packages/sentient_ui/lib/src/decision/rule_engine.dart)                                              | Dart | 33 | 35 | 11 | 79 |
| [packages/sentient\_ui/lib/src/logic/state\_manager.dart](/packages/sentient_ui/lib/src/decision/state_manager.dart)                                          | Dart | 26 | 31 | 11 | 68 |
| [packages/sentient\_ui/lib/src/models/behavior\_state.dart](/packages/sentient_ui/lib/src/domain/states/behavior_state.dart)                                      | Dart | 27 | 8 | 7 | 42 |
| [packages/sentient\_ui/lib/src/models/context\_state.dart](/packages/sentient_ui/lib/src/domain/states/context_state.dart)                                        | Dart | 0 | 0 | 1 | 1 |
| [packages/sentient\_ui/lib/src/models/emotion\_result.dart](/packages/sentient_ui/lib/src/sensing/outputs/emotion_result.dart)                                      | Dart | 31 | 1 | 8 | 40 |
| [packages/sentient\_ui/lib/src/models/emotion\_state.dart](/packages/sentient_ui/lib/src/domain/states/emotion_state.dart)                                        | Dart | 10 | 2 | 1 | 13 |
| [packages/sentient\_ui/lib/src/processing/bayesian\_filter.dart](/packages/sentient_ui/lib/src/analysis/bayesian_filter.dart)                            | Dart | 38 | 23 | 13 | 74 |
| [packages/sentient\_ui/lib/src/processing/normalization\_utils.dart](/packages/sentient_ui/lib/src/analysis/normalization_utils.dart)                    | Dart | 33 | 43 | 9 | 85 |
| [packages/sentient\_ui/lib/src/processing/signal\_fusion.dart](/packages/sentient_ui/lib/src/analysis/signal_fusion.dart)                                | Dart | 0 | 0 | 1 | 1 |
| [packages/sentient\_ui/lib/src/ui/configs/align\_config.dart](/packages/sentient_ui/lib/src/ui/configs/align_config.dart)                                  | Dart | 9 | 5 | 6 | 20 |
| [packages/sentient\_ui/lib/src/ui/configs/animated\_switcher\_config.dart](/packages/sentient_ui/lib/src/ui/configs/animated_switcher_config.dart)         | Dart | 27 | 7 | 8 | 42 |
| [packages/sentient\_ui/lib/src/ui/configs/animation\_config.dart](/packages/sentient_ui/lib/src/ui/configs/animation_config.dart)                          | Dart | 37 | 6 | 10 | 53 |
| [packages/sentient\_ui/lib/src/ui/configs/button\_config.dart](/packages/sentient_ui/lib/src/ui/configs/button_config.dart)                                | Dart | 37 | 6 | 10 | 53 |
| [packages/sentient\_ui/lib/src/ui/configs/clip\_r\_rect\_config.dart](/packages/sentient_ui/lib/src/ui/configs/clip_r_rect_config.dart)                    | Dart | 17 | 5 | 6 | 28 |
| [packages/sentient\_ui/lib/src/ui/configs/column\_config.dart](/packages/sentient_ui/lib/src/ui/configs/column_config.dart)                                | Dart | 28 | 4 | 6 | 38 |
| [packages/sentient\_ui/lib/src/ui/configs/container\_config.dart](/packages/sentient_ui/lib/src/ui/configs/container_config.dart)                          | Dart | 47 | 11 | 12 | 70 |
| [packages/sentient\_ui/lib/src/ui/configs/expanded\_config.dart](/packages/sentient_ui/lib/src/ui/configs/expanded_config.dart)                            | Dart | 37 | 9 | 10 | 56 |
| [packages/sentient\_ui/lib/src/ui/configs/feedback\_config.dart](/packages/sentient_ui/lib/src/ui/configs/feedback_config.dart)                            | Dart | 15 | 5 | 7 | 27 |
| [packages/sentient\_ui/lib/src/ui/configs/grid\_view\_config.dart](/packages/sentient_ui/lib/src/ui/configs/grid_view_config.dart)                         | Dart | 37 | 8 | 6 | 51 |
| [packages/sentient\_ui/lib/src/ui/configs/icon\_config.dart](/packages/sentient_ui/lib/src/ui/configs/icon_config.dart)                                    | Dart | 22 | 6 | 7 | 35 |
| [packages/sentient\_ui/lib/src/ui/configs/image\_config.dart](/packages/sentient_ui/lib/src/ui/configs/image_config.dart)                                  | Dart | 22 | 7 | 7 | 36 |
| [packages/sentient\_ui/lib/src/ui/configs/input\_decoration\_config.dart](/packages/sentient_ui/lib/src/ui/configs/input_decoration_config.dart)           | Dart | 37 | 9 | 10 | 56 |
| [packages/sentient\_ui/lib/src/ui/configs/layout\_config.dart](/packages/sentient_ui/lib/src/ui/configs/layout_config.dart)                                | Dart | 37 | 6 | 10 | 53 |
| [packages/sentient\_ui/lib/src/ui/configs/list\_view\_config.dart](/packages/sentient_ui/lib/src/ui/configs/list_view_config.dart)                         | Dart | 32 | 8 | 9 | 49 |
| [packages/sentient\_ui/lib/src/ui/configs/rotated\_box\_config.dart](/packages/sentient_ui/lib/src/ui/configs/rotated_box_config.dart)                     | Dart | 17 | 4 | 6 | 27 |
| [packages/sentient\_ui/lib/src/ui/configs/row\_config.dart](/packages/sentient_ui/lib/src/ui/configs/row_config.dart)                                      | Dart | 37 | 9 | 10 | 56 |
| [packages/sentient\_ui/lib/src/ui/configs/safe\_area\_config.dart](/packages/sentient_ui/lib/src/ui/configs/safe_area_config.dart)                         | Dart | 17 | 4 | 6 | 27 |
| [packages/sentient\_ui/lib/src/ui/configs/scaffold\_config.dart](/packages/sentient_ui/lib/src/ui/configs/scaffold_config.dart)                            | Dart | 30 | 4 | 6 | 40 |
| [packages/sentient\_ui/lib/src/ui/configs/scroll\_view\_config.dart](/packages/sentient_ui/lib/src/ui/configs/scroll_view_config.dart)                     | Dart | 46 | 10 | 12 | 68 |
| [packages/sentient\_ui/lib/src/ui/configs/sized\_box\_config.dart](/packages/sentient_ui/lib/src/ui/configs/sized_box_config.dart)                         | Dart | 22 | 7 | 7 | 36 |
| [packages/sentient\_ui/lib/src/ui/configs/spacer\_config.dart](/packages/sentient_ui/lib/src/ui/configs/spacer_config.dart)                                | Dart | 9 | 5 | 6 | 20 |
| [packages/sentient\_ui/lib/src/ui/configs/stack\_config.dart](/packages/sentient_ui/lib/src/ui/configs/stack_config.dart)                                  | Dart | 22 | 5 | 6 | 33 |
| [packages/sentient\_ui/lib/src/ui/configs/text\_field\_config.dart](/packages/sentient_ui/lib/src/ui/configs/text_field_config.dart)                       | Dart | 57 | 10 | 11 | 78 |
| [packages/sentient\_ui/lib/src/ui/configs/typography\_config.dart](/packages/sentient_ui/lib/src/ui/configs/typography_config.dart)                        | Dart | 44 | 8 | 12 | 64 |
| [packages/sentient\_ui/lib/src/ui/emotion\_theme.dart](/packages/sentient_ui/lib/src/ui/emotion_theme.dart)                                                | Dart | 602 | 41 | 42 | 685 |
| [packages/sentient\_ui/lib/src/ui/sentient\_align.dart](/packages/sentient_ui/lib/src/ui/sentient_align.dart)                                              | Dart | 39 | 7 | 10 | 56 |
| [packages/sentient\_ui/lib/src/ui/sentient\_animated\_builder.dart](/packages/sentient_ui/lib/src/ui/sentient_animated_builder.dart)                       | Dart | 164 | 92 | 40 | 296 |
| [packages/sentient\_ui/lib/src/ui/sentient\_animated\_opacity.dart](/packages/sentient_ui/lib/src/ui/sentient_animated_opacity.dart)                       | Dart | 177 | 99 | 43 | 319 |
| [packages/sentient\_ui/lib/src/ui/sentient\_animated\_switcher.dart](/packages/sentient_ui/lib/src/ui/sentient_animated_switcher.dart)                     | Dart | 41 | 7 | 11 | 59 |
| [packages/sentient\_ui/lib/src/ui/sentient\_aspect\_ratio.dart](/packages/sentient_ui/lib/src/ui/sentient_aspect_ratio.dart)                               | Dart | 55 | 61 | 15 | 131 |
| [packages/sentient\_ui/lib/src/ui/sentient\_bottom\_navigation\_bar.dart](/packages/sentient_ui/lib/src/ui/sentient_bottom_navigation_bar.dart)            | Dart | 205 | 83 | 33 | 321 |
| [packages/sentient\_ui/lib/src/ui/sentient\_bottom\_navigation\_bar\_item.dart](/packages/sentient_ui/lib/src/ui/sentient_bottom_navigation_bar_item.dart) | Dart | 167 | 82 | 30 | 279 |
| [packages/sentient\_ui/lib/src/ui/sentient\_circle\_avatar.dart](/packages/sentient_ui/lib/src/ui/sentient_circle_avatar.dart)                             | Dart | 142 | 71 | 29 | 242 |
| [packages/sentient\_ui/lib/src/ui/sentient\_clip\_r\_rect.dart](/packages/sentient_ui/lib/src/ui/sentient_clip_r_rect.dart)                                | Dart | 41 | 7 | 10 | 58 |
| [packages/sentient\_ui/lib/src/ui/sentient\_column.dart](/packages/sentient_ui/lib/src/ui/sentient_column.dart)                                            | Dart | 62 | 30 | 15 | 107 |
| [packages/sentient\_ui/lib/src/ui/sentient\_container.dart](/packages/sentient_ui/lib/src/ui/sentient_container.dart)                                      | Dart | 127 | 93 | 28 | 248 |
| [packages/sentient\_ui/lib/src/ui/sentient\_divider.dart](/packages/sentient_ui/lib/src/ui/sentient_divider.dart)                                          | Dart | 101 | 69 | 23 | 193 |
| [packages/sentient\_ui/lib/src/ui/sentient\_draggable\_scrollable\_sheet.dart](/packages/sentient_ui/lib/src/ui/sentient_draggable_scrollable_sheet.dart)  | Dart | 178 | 87 | 30 | 295 |
| [packages/sentient\_ui/lib/src/ui/sentient\_expanded.dart](/packages/sentient_ui/lib/src/ui/sentient_expanded.dart)                                        | Dart | 56 | 18 | 14 | 88 |
| [packages/sentient\_ui/lib/src/ui/sentient\_gesture\_detector.dart](/packages/sentient_ui/lib/src/ui/sentient_gesture_detector.dart)                       | Dart | 227 | 89 | 48 | 364 |
| [packages/sentient\_ui/lib/src/ui/sentient\_gesture\_detector1.dart](/packages/sentient_ui/lib/src/ui/sentient_gesture_detector1.dart)                     | Dart | 25 | 8 | 5 | 38 |
| [packages/sentient\_ui/lib/src/ui/sentient\_grid\_view.dart](/packages/sentient_ui/lib/src/ui/sentient_grid_view.dart)                                     | Dart | 54 | 42 | 16 | 112 |
| [packages/sentient\_ui/lib/src/ui/sentient\_icon.dart](/packages/sentient_ui/lib/src/ui/sentient_icon.dart)                                                | Dart | 44 | 10 | 13 | 67 |
| [packages/sentient\_ui/lib/src/ui/sentient\_image.dart](/packages/sentient_ui/lib/src/ui/sentient_image.dart)                                              | Dart | 49 | 11 | 14 | 74 |
| [packages/sentient\_ui/lib/src/ui/sentient\_input\_decoration.dart](/packages/sentient_ui/lib/src/ui/sentient_input_decoration.dart)                       | Dart | 53 | 44 | 11 | 108 |
| [packages/sentient\_ui/lib/src/ui/sentient\_list\_tile.dart](/packages/sentient_ui/lib/src/ui/sentient_list_tile.dart)                                     | Dart | 295 | 79 | 44 | 418 |
| [packages/sentient\_ui/lib/src/ui/sentient\_list\_view.dart](/packages/sentient_ui/lib/src/ui/sentient_list_view.dart)                                     | Dart | 47 | 10 | 11 | 68 |
| [packages/sentient\_ui/lib/src/ui/sentient\_positioned.dart](/packages/sentient_ui/lib/src/ui/sentient_positioned.dart)                                    | Dart | 124 | 76 | 26 | 226 |
| [packages/sentient\_ui/lib/src/ui/sentient\_rotated\_box.dart](/packages/sentient_ui/lib/src/ui/sentient_rotated_box.dart)                                 | Dart | 41 | 7 | 11 | 59 |
| [packages/sentient\_ui/lib/src/ui/sentient\_row.dart](/packages/sentient_ui/lib/src/ui/sentient_row.dart)                                                  | Dart | 62 | 50 | 15 | 127 |
| [packages/sentient\_ui/lib/src/ui/sentient\_safe\_area.dart](/packages/sentient_ui/lib/src/ui/sentient_safe_area.dart)                                     | Dart | 39 | 8 | 10 | 57 |
| [packages/sentient\_ui/lib/src/ui/sentient\_scaffold.dart](/packages/sentient_ui/lib/src/ui/sentient_scaffold.dart)                                        | Dart | 55 | 9 | 10 | 74 |
| [packages/sentient\_ui/lib/src/ui/sentient\_scroll\_observer.dart](/packages/sentient_ui/lib/src/ui/sentient_scroll_observer.dart)                         | Dart | 12 | 2 | 4 | 18 |
| [packages/sentient\_ui/lib/src/ui/sentient\_single\_child\_scroll\_view.dart](/packages/sentient_ui/lib/src/ui/sentient_single_child_scroll_view.dart)     | Dart | 57 | 66 | 14 | 137 |
| [packages/sentient\_ui/lib/src/ui/sentient\_sized\_box.dart](/packages/sentient_ui/lib/src/ui/sentient_sized_box.dart)                                     | Dart | 40 | 9 | 10 | 59 |
| [packages/sentient\_ui/lib/src/ui/sentient\_spacer.dart](/packages/sentient_ui/lib/src/ui/sentient_spacer.dart)                                            | Dart | 31 | 6 | 10 | 47 |
| [packages/sentient\_ui/lib/src/ui/sentient\_stack.dart](/packages/sentient_ui/lib/src/ui/sentient_stack.dart)                                              | Dart | 44 | 6 | 10 | 60 |
| [packages/sentient\_ui/lib/src/ui/sentient\_text.dart](/packages/sentient_ui/lib/src/ui/sentient_text.dart)                                                | Dart | 202 | 113 | 34 | 349 |
| [packages/sentient\_ui/lib/src/ui/sentient\_text\_button.dart](/packages/sentient_ui/lib/src/ui/sentient_text_button.dart)                                 | Dart | 239 | 73 | 30 | 342 |
| [packages/sentient\_ui/lib/src/ui/sentient\_text\_enhanced.dart](/packages/sentient_ui/lib/src/ui/sentient_text_enhanced.dart)                             | Dart | 245 | 84 | 40 | 369 |
| [packages/sentient\_ui/lib/src/ui/sentient\_text\_field.dart](/packages/sentient_ui/lib/src/ui/sentient_text_field.dart)                                   | Dart | 62 | 19 | 15 | 96 |
| [packages/sentient\_ui/pubspec.yaml](/packages/sentient_ui/pubspec.yaml)                                                                                   | YAML | 31 | 29 | 8 | 68 |
| [packages/sentient\_ui/test/sentient\_ui\_test.dart](/packages/sentient_ui/test/sentient_ui_test.dart)                                                     | Dart | 6 | 0 | 4 | 10 |

[Summary](results.md) / Details / [Diff Summary](diff.md) / [Diff Details](diff-details.md)