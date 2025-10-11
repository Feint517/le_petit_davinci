import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/models/selectable_option_model.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';
import 'package:le_petit_davinci/features/levels/views/activities/multiple_choice_view.dart';

class MultipleChoiceActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  final String instruction;
  final List<SelectableOption> options;
  final List<int> correctIndices;
  final String? question;

  final RxList<int> selectedIndices = <int>[].obs;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  MultipleChoiceActivity({
    required this.instruction,
    required this.options,
    required this.correctIndices,
    this.question,
  }) {
    // Initialize mascot with activity-specific introduction messages
    initializeMascot([
      'Let\'s answer this question!',
      'Choose all the correct answers.',
      'Take your time and think carefully!',
    ]);
  }

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }

  void submitAnswer() => markCompleted(); // Use the new unified helper method

  @override
  Widget build(BuildContext context) {
    return MultipleChoiceView(activity: this);
  }

  @override
  bool get isAnswerReady => selectedIndices.isNotEmpty;

  @override
  Stream<bool> get isAnswerReadyStream =>
      selectedIndices.stream.map((indices) => indices.isNotEmpty);

  @override
  AnswerResult checkAnswer() {
    // Sort both lists for comparison
    final sortedSelected = List<int>.from(selectedIndices)..sort();
    final sortedCorrect = List<int>.from(correctIndices)..sort();

    final bool isCorrect =
        sortedSelected.length == sortedCorrect.length &&
        sortedSelected.every((index) => sortedCorrect.contains(index));

    // Create correct answer text from the correct options
    final correctAnswers = correctIndices
        .map((index) => options[index].label)
        .join(', ');

    return AnswerResult(
      isCorrect: isCorrect,
      correctAnswerText: correctAnswers,
    );
  }

  @override
  void reset() {
    selectedIndices.clear();
  }

  // --- ActivityNavigationInterface Implementation ---

  @override
  bool get useCustomNavigation => false; // Use standard navigation

  @override
  Widget? get customNavigationWidget => null; // Use standard navigation

  @override
  ActivityButtonConfig? get buttonConfig => null; // Use default button config

  @override
  void onNavigationTriggered() {
    // Handle custom navigation logic if needed
  }

  @override
  void dispose() {
    disposeMascotWithFeedback(); // Use enhanced dispose method
    super.dispose();
  }

  // --- Mascot Feedback Methods ---

  /// Show success feedback when answer is correct
  void showCorrectFeedback() {
    showSuccessFeedback();
  }

  /// Show encouragement feedback when answer is incorrect
  void showIncorrectFeedback() {
    showEncouragementFeedback();
  }
}
