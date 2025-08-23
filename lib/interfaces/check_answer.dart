import 'package:flutter/material.dart';

/// A class to hold the result of an answer check.
class CheckResult {
  final bool isCorrect;
  final String correctAnswerText;

  const CheckResult({required this.isCorrect, required this.correctAnswerText});
}

/// An abstract base class for all exercise types.
abstract class Exercise {
  const Exercise();

  /// Builds the appropriate UI widget for this specific exercise.
  Widget build(BuildContext context);

  /// Checks the user's answer and returns the result.
  /// The controller will provide the user's input.
  CheckResult checkAnswer(dynamic userAnswer);

  /// Determines if the user has provided enough input to check the answer.
  bool get isAnswerReady;
}
