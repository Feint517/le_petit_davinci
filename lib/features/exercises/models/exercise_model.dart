import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';

/// An abstract base class for all exercise types.
/// Each specific exercise model will extend this class and provide its own
/// implementation for the `build` method.
abstract class Exercise {
  const Exercise();

  /// Builds the appropriate UI widget for this specific exercise.
  Widget build(BuildContext context);

  /// Checks the user's answer and returns a result.
  /// This must be implemented by all concrete exercise classes.
  // AnswerResult checkAnswer(dynamic userAnswer);
  AnswerResult checkAnswer();

  /// A getter to determine if the user has provided enough input to check the answer.
  /// Must be implemented by subclasses.
  bool get isAnswerReady;

  /// Resets the user's input for the current exercise.
  /// Must be implemented by subclasses.
  void reset();
}
