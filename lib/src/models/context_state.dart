import 'package:flutter/material.dart';

import 'context_result.dart';

/// Holds the application's current known context state.
@immutable
class ContextState {
  final ContextResult result;

  const ContextState({required this.result});

  factory ContextState.initial() => ContextState(result: ContextResult.initial());
}