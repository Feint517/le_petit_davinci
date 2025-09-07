import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/math_crossword_view.dart';

class MathCrosswordExercise extends Exercise {
  final String instruction;
  final List<String> puzzleLayout; // e.g., ["2+_=5", "+ _ ", "_-1=_"]
  final List<String> solutionLayout; // e.g., ["2+3=5", "+ 4 ", "6-1=5"]
  final int gridWidth;
  final int gridHeight;

  // --- State Management ---
  late final RxList<String> userAnswers;
  final Rxn<int> activeCellIndex = Rxn<int>();

  MathCrosswordExercise({
    required this.instruction,
    required List<String> puzzleLayout,
    required List<String> solutionLayout,
  }) : gridHeight = puzzleLayout.length,
       // --- FIX: Calculate width from the longest row and pad all rows ---
       gridWidth = puzzleLayout
           .map((r) => r.length)
           .reduce((a, b) => a > b ? a : b),
       puzzleLayout =
           puzzleLayout
               .map(
                 (row) => row.padRight(
                   puzzleLayout
                       .map((r) => r.length)
                       .reduce((a, b) => a > b ? a : b),
                   ' ',
                 ),
               )
               .toList(),
       solutionLayout =
           solutionLayout
               .map(
                 (row) => row.padRight(
                   puzzleLayout
                       .map((r) => r.length)
                       .reduce((a, b) => a > b ? a : b),
                   ' ',
                 ),
               )
               .toList() {
    // Flatten the now-padded puzzle layout into a 1D list.
    final flatLayout = this.puzzleLayout.join('');
    userAnswers =
        List.generate(
          flatLayout.length,
          (index) => flatLayout[index] == '_' ? '' : flatLayout[index],
        ).obs;
  }

  /// Sets the currently focused input cell.
  void setActiveCell(int index) {
    // Only allow input cells ('_') to be selected.
    if (puzzleLayout.join('')[index] == '_') {
      activeCellIndex.value = index;
    }
  }

  /// Enters a number into the active cell and advances to the next available one.
  void enterDigit(String digit) {
    if (activeCellIndex.value != null) {
      userAnswers[activeCellIndex.value!] = digit;
      _advanceToNextInputCell(activeCellIndex.value!);
    }
  }

  /// Clears the content of the active cell.
  void backspace() {
    if (activeCellIndex.value != null) {
      userAnswers[activeCellIndex.value!] = '';
    }
  }

  /// Finds the next empty input cell and sets it as active.
  void _advanceToNextInputCell(int currentIndex) {
    final flatLayout = puzzleLayout.join('');
    int nextIndex = (currentIndex + 1) % userAnswers.length;
    while (nextIndex != currentIndex) {
      if (flatLayout[nextIndex] == '_' && userAnswers[nextIndex].isEmpty) {
        activeCellIndex.value = nextIndex;
        return;
      }
      nextIndex = (nextIndex + 1) % userAnswers.length;
    }
    // If no other empty cells are found, stay on the current one.
    activeCellIndex.value = currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return MathCrosswordView(exercise: this);
  }

  @override
  bool get isAnswerReady {
    final flatLayout = puzzleLayout.join('');
    for (int i = 0; i < userAnswers.length; i++) {
      if (flatLayout[i] == '_' && userAnswers[i].isEmpty) {
        return false; // Found an empty input cell.
      }
    }
    return true; // All input cells are filled.
  }

  @override
  Stream<bool> get isAnswerReadyStream =>
      userAnswers.stream.map((_) => isAnswerReady);

  @override
  AnswerResult checkAnswer() {
    final userAnswerString = userAnswers.join('');
    final solutionString = solutionLayout.join('');
    return AnswerResult(
      isCorrect: userAnswerString == solutionString,
      correctAnswerText: 'The puzzle was completed!',
    );
  }

  @override
  void reset() {
    final flatLayout = puzzleLayout.join('');
    for (int i = 0; i < userAnswers.length; i++) {
      userAnswers[i] = flatLayout[i] == '_' ? '' : flatLayout[i];
    }
    activeCellIndex.value = null;
  }
}
