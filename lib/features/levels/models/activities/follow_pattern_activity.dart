import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/levels/views/activities/follow_pattern_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';

class FollowPatternActivity extends Activity {
  final String instruction;
  final List<String> examples;
  final String question;
  final List<int> options;
  final int correctAnswerIndex;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  // State for this exercise: the index of the user's selected choice.
  final Rxn<int> selectedIndex = Rxn<int>();

  FollowPatternActivity({
    required this.instruction,
    required this.examples,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  /// The view will call this to update the state when a choice is selected.
  void selectOption(int index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return FollowPatternView(activity: this);
  }

  @override
  bool get isAnswerReady => selectedIndex.value != null;

  @override
  Stream<bool> get isAnswerReadyStream =>
      selectedIndex.stream.map((index) => index != null);

  @override
  AnswerResult checkAnswer() {
    final bool isCorrect = selectedIndex.value == correctAnswerIndex;
    // Construct the full correct answer string, e.g., "5 + 1 = 6"
    final String correctAnswerText = question.replaceFirst(
      '?',
      options[correctAnswerIndex].toString(),
    );

    return AnswerResult(
      isCorrect: isCorrect,
      correctAnswerText: correctAnswerText,
    );
  }

  @override
  void reset() {
    selectedIndex.value = null;
  }
}
