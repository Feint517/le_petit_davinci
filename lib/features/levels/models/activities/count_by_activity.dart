import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/levels/views/activities/count_by_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class CountByActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  final String instruction;
  final List<int> initialSequence;
  final int numberOfInputs;
  final List<int> correctAnswers;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  // State for this exercise: a list to hold the user's input for each box.
  late final RxList<String> userInputs;
  // State to track the active input box
  final RxInt activeInputIndex = 0.obs;

  CountByActivity({
    required this.instruction,
    required this.initialSequence,
    required this.numberOfInputs,
    required this.correctAnswers,
  }) {
    // Ensure the number of inputs matches the number of correct answers.
    assert(numberOfInputs == correctAnswers.length);
    // Initialize user inputs with empty strings.
    userInputs = List.generate(numberOfInputs, (_) => '').obs;

    // Mascot initialization is handled in the view's build method
  }

  void setActiveIndex(int index) {
    activeInputIndex.value = index;
  }

  /// Appends a number to the currently active input box.
  void appendInput(String number) {
    final currentIndex = activeInputIndex.value;
    if (currentIndex < userInputs.length) {
      // 1. Get the expected length of the answer for the current box.
      final correctAnswerLength =
          correctAnswers[currentIndex].toString().length;

      // 2. Only allow input if the current length is less than the expected length.
      if (userInputs[currentIndex].length < correctAnswerLength) {
        userInputs[currentIndex] += number;

        // 3. If the input now matches the expected length and it's not the last box, advance.
        if (userInputs[currentIndex].length == correctAnswerLength &&
            currentIndex < numberOfInputs - 1) {
          activeInputIndex.value++;
        }
      }
    }
  }

  /// Handles the backspace action for the active input box.
  void backspace() {
    final currentIndex = activeInputIndex.value;
    if (currentIndex < userInputs.length &&
        userInputs[currentIndex].isNotEmpty) {
      final currentText = userInputs[currentIndex];
      userInputs[currentIndex] = currentText.substring(
        0,
        currentText.length - 1,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CountByView(activity: this);
  }

  @override
  bool get isAnswerReady {
    // The answer is ready if all input boxes have a value.
    return userInputs.every((input) => input.isNotEmpty);
  }

  @override
  Stream<bool> get isAnswerReadyStream {
    // Emit a new value whenever the list of inputs changes.
    return userInputs.stream.map((list) => list.every((i) => i.isNotEmpty));
  }

  @override
  AnswerResult checkAnswer() {
    bool isCorrect = true;
    for (int i = 0; i < correctAnswers.length; i++) {
      final userInputInt = int.tryParse(userInputs[i]);
      if (userInputInt == null || userInputInt != correctAnswers[i]) {
        isCorrect = false;
        break;
      }
    }
    return AnswerResult(
      isCorrect: isCorrect,
      correctAnswerText:
          'The sequence is: ${[...initialSequence, ...correctAnswers].join(', ')}',
    );
  }

  @override
  void reset() {
    // Clear all user inputs.
    userInputs.fillRange(0, userInputs.length, '');
    // Also reset the active index to the beginning for a clean state.
    activeInputIndex.value = 0;
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
    disposeMascot(); // Use mixin method
    super.dispose();
  }
}
