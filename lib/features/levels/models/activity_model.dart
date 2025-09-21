import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';

/// Unified base class for all activities in a level.
/// This replaces the separate Activity and Exercise classes.
abstract class Activity {
  //? A reactive boolean to track if the activity has been completed.
  //? It starts as false.
  final RxBool isCompleted = false.obs;

  Widget build(BuildContext context);

  /// An optional method for activities to clean up their resources (e.g., controllers).
  /// It has a default empty implementation so not all activities need to define it.
  void dispose() {}

  // --- Exercise-like behavior (optional) ---

  /// Whether this activity requires answer validation before completion.
  /// If true, the activity will show a "Check" button and require validation.
  /// If false, the activity completes automatically when user interaction is done.
  bool get requiresValidation => false;

  /// A getter to determine if the user has provided enough input to check the answer.
  /// Only relevant if requiresValidation is true.
  /// Default implementation returns true (always ready for validation).
  bool get isAnswerReady => true;

  /// A stream that emits a value whenever `isAnswerReady` might have changed.
  /// Only relevant if requiresValidation is true.
  /// Default implementation returns a stream that always emits true.
  Stream<bool> get isAnswerReadyStream => Stream.value(true);

  /// Checks the user's answer and returns a result.
  /// Only relevant if requiresValidation is true.
  /// Default implementation returns a successful result.
  AnswerResult checkAnswer() =>
      AnswerResult(isCorrect: true, correctAnswerText: '');

  /// Resets the user's input for the current activity.
  /// Only relevant if requiresValidation is true.
  /// Default implementation does nothing.
  void reset() {}

  // --- Helper methods ---

  /// Marks the activity as completed and triggers progression.
  void markCompleted() {
    isCompleted.value = true;
  }

  /// Checks if this activity is an "exercise" (requires validation).
  bool get isExercise => requiresValidation;

  /// Checks if this activity is a "lesson activity" (auto-completes).
  bool get isLessonActivity => !requiresValidation;
}
