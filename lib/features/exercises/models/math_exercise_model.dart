import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/exercises/models/arrange_number_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/number_matching_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/shape_pattern_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/solve_equation_exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/arrange_numbers_view.dart';
import 'package:le_petit_davinci/features/exercises/views/number_matching_view.dart';
import 'package:le_petit_davinci/features/exercises/views/shape_pattern_view.dart';
import 'package:le_petit_davinci/features/exercises/views/solve_equation_view.dart';

enum MathExerciseType {
  numberMatching,
  solveEquation,
  arrangeNumbers,
  shapePattern,
}

class MathExercise {
  final MathExerciseType type;
  final NumberMatchingExercise? numberMatchingExercise;
  final SolveEquationExercise? solveEquationExercise;
  final ArrangeNumbersExercise? arrangeNumbersExercise;
  final ShapePatternExercise? shapePatternExercise;

  const MathExercise._({
    required this.type,
    this.numberMatchingExercise,
    this.solveEquationExercise,
    this.arrangeNumbersExercise,
    this.shapePatternExercise,
  });

  /// Constructor for NumberMatching exercises
  factory MathExercise.numberMatching(NumberMatchingExercise exercise) {
    return MathExercise._(
      type: MathExerciseType.numberMatching,
      numberMatchingExercise: exercise,
    );
  }

  /// Constructor for SolveEquation exercises
  factory MathExercise.solveEquation(SolveEquationExercise exercise) {
    return MathExercise._(
      type: MathExerciseType.solveEquation,
      solveEquationExercise: exercise,
    );
  }

  /// Constructor for ArrangeNumbers exercises
  factory MathExercise.arrangeNumbers(ArrangeNumbersExercise exercise) {
    return MathExercise._(
      type: MathExerciseType.arrangeNumbers,
      arrangeNumbersExercise: exercise,
    );
  }

  /// Constructor for ShapePattern exercises
  factory MathExercise.shapePattern(ShapePatternExercise exercise) {
    return MathExercise._(
      type: MathExerciseType.shapePattern,
      shapePatternExercise: exercise,
    );
  }

  /// Builds the appropriate UI widget for the exercise
  Widget build(BuildContext context) {
    switch (type) {
      case MathExerciseType.numberMatching:
        return NumberMatchingView(exercise: numberMatchingExercise!);
      case MathExerciseType.solveEquation:
        return SolveEquationView(exercise: solveEquationExercise!);
      case MathExerciseType.arrangeNumbers:
        return ArrangeNumbersView(exercise: arrangeNumbersExercise!);
      case MathExerciseType.shapePattern:
        return ShapePatternView(exercise: shapePatternExercise!);
    }
  }
}