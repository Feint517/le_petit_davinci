import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/crossword_equation_view.dart';

/// Represents a single equation in the crossword
class CrosswordEquation {
  final String equation; // Format like "2+?=5" where ? is the blank to fill
  final int answer; // The correct answer for the blank
  final bool isHorizontal; // Direction of the equation
  final int row; // Starting row position
  final int column; // Starting column position

  CrosswordEquation({
    required this.equation,
    required this.answer,
    required this.isHorizontal,
    required this.row,
    required this.column,
  });

  /// Returns the coordinate [row, col] of the blank in this equation
  List<int> get blankPosition {
    final blankIndex = equation.indexOf('?');
    if (isHorizontal) {
      return [row, column + blankIndex];
    } else {
      return [row + blankIndex, column];
    }
  }
}

class MathEquationCrosswordExercise extends Exercise {
  final String instruction;
  final List<CrosswordEquation> equations;
  final int gridSize; // Size of the grid (assumes square grid)

  /// Store user inputs for each cell in the grid
  final RxList<RxList<String>> gridValues;

  /// Track which cell is currently selected
  final Rx<List<int>> selectedCell = Rx<List<int>>([0, 0]);

  MathEquationCrosswordExercise({
    required this.instruction,
    required this.equations,
    required this.gridSize,
  }) : gridValues =
           List.generate(
             gridSize,
             (_) => List.generate(gridSize, (_) => '').obs,
           ).obs;

  /// Sets the currently selected cell
  void selectCell(int row, int col) {
    // Only allow selection of cells that are part of an equation's blank
    for (final eq in equations) {
      final blankPos = eq.blankPosition;
      if (blankPos[0] == row && blankPos[1] == col) {
        selectedCell.value = [row, col];
        return;
      }
    }
  }

  /// Enters a digit in the selected cell
  void enterDigit(String digit) {
    final row = selectedCell.value[0];
    final col = selectedCell.value[1];

    if (row >= 0 && row < gridSize && col >= 0 && col < gridSize) {
      gridValues[row][col] = digit;
    }
  }

  /// Clears the selected cell
  void backspace() {
    final row = selectedCell.value[0];
    final col = selectedCell.value[1];

    if (row >= 0 && row < gridSize && col >= 0 && col < gridSize) {
      gridValues[row][col] = '';
    }
  }

  /// Checks if a given cell is part of an equation
  bool isEquationCell(int row, int col) {
    for (final eq in equations) {
      final eqLength = eq.equation.length;
      if (eq.isHorizontal) {
        if (row == eq.row && col >= eq.column && col < eq.column + eqLength) {
          return true;
        }
      } else {
        if (col == eq.column && row >= eq.row && row < eq.row + eqLength) {
          return true;
        }
      }
    }
    return false;
  }

  /// Checks if a given cell is a blank to be filled
  bool isBlankCell(int row, int col) {
    for (final eq in equations) {
      final blankPos = eq.blankPosition;
      if (blankPos[0] == row && blankPos[1] == col) {
        return true;
      }
    }
    return false;
  }

  /// Gets the character at a given position in the grid
  String getCellContent(int row, int col) {
    // If this is a blank cell, return the user input
    if (isBlankCell(row, col)) {
      return gridValues[row][col];
    }

    // Otherwise find which equation this cell belongs to
    for (final eq in equations) {
      final eqLength = eq.equation.length;
      int cellIndex = -1;

      if (eq.isHorizontal &&
          row == eq.row &&
          col >= eq.column &&
          col < eq.column + eqLength) {
        cellIndex = col - eq.column;
      } else if (!eq.isHorizontal &&
          col == eq.column &&
          row >= eq.row &&
          row < eq.row + eqLength) {
        cellIndex = row - eq.row;
      }

      if (cellIndex >= 0) {
        return eq.equation[cellIndex] == '?'
            ? gridValues[row][col]
            : eq.equation[cellIndex];
      }
    }

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return MathEquationCrosswordView(exercise: this);
  }

  @override
  bool get isAnswerReady {
    // All blank cells must be filled
    for (final eq in equations) {
      final blankPos = eq.blankPosition;
      final row = blankPos[0];
      final col = blankPos[1];
      if (gridValues[row][col].isEmpty) {
        return false;
      }
    }
    return true;
  }

  // @override
  // Stream<bool> get isAnswerReadyStream {
  //   // Return a stream that emits whenever any cell value changes
  //   return Rx.combineLatest(
  //     gridValues.expand((row) => row).toList(),
  //     (_) => isAnswerReady,
  //   );
  // }
  // Add this as a class property
  final Rx<bool> isAnswerReadyRx = false.obs;

  // Then update this in your methods that modify the grid
  void updateCell(int row, int col, String value) {
    gridValues[row][col] = value;
    // Update the ready state
    isAnswerReadyRx.value = isAnswerReady;
  }

  @override
  Stream<bool> get isAnswerReadyStream => isAnswerReadyRx.stream;

  @override
  AnswerResult checkAnswer() {
    bool isCorrect = true;
    List<String> incorrectEquations = [];

    for (final eq in equations) {
      final blankPos = eq.blankPosition;
      final row = blankPos[0];
      final col = blankPos[1];
      final userAnswer = int.tryParse(gridValues[row][col]) ?? -1;

      if (userAnswer != eq.answer) {
        isCorrect = false;
        incorrectEquations.add(
          eq.equation.replaceFirst('?', eq.answer.toString()),
        );
      }
    }

    return AnswerResult(
      isCorrect: isCorrect,
      correctAnswerText:
          isCorrect
              ? 'All equations are correct!'
              : 'Correct equations: ${incorrectEquations.join(", ")}',
    );
  }

  @override
  void reset() {
    // Clear all user inputs
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        gridValues[i][j] = '';
      }
    }
    selectedCell.value = [0, 0];
  }
}
