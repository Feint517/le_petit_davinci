import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/levels/views/activities/listen_and_choose_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/mixin/audible_mixin.dart';

class ListenAndChooseActivity extends Activity with Audible {
  final List<String> imageAssets;
  final int correctAnswer;
  final String label;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  ListenAndChooseActivity({
    required this.imageAssets,
    required this.correctAnswer,
    required this.label,
  });

  // --- State Management for this specific exercise type ---
  final Rxn<int> selectedIndex = Rxn<int>();
  final RxBool showHint = false.obs;

  /// The view will call this method when the user selects an image.
  void selectOption(int index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return ListenAndChooseView(activity: this);
  }

  @override
  AnswerResult checkAnswer() {
    final bool isCorrect = selectedIndex.value == correctAnswer;

    // The correct answer text is the label that was spoken.
    return AnswerResult(isCorrect: isCorrect, correctAnswerText: label);
  }

  @override
  bool get isAnswerReady => selectedIndex.value != null;

  @override
  void reset() {
    selectedIndex.value = null;
    resetAudio();
  }

  //? This is required by the Audible mixin.
  @override
  String get audioText => label;

  @override
  Stream<bool> get isAnswerReadyStream =>
      selectedIndex.stream.map((index) => index != null);
}
