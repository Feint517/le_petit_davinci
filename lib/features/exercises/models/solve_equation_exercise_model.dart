class SolveEquationExercise {
  final String equation;
  final int missingNumber;
  final List<int> options;
  final EquationType type;
  final String? hint;
  
  const SolveEquationExercise({
    required this.equation,
    required this.missingNumber,
    required this.options,
    required this.type,
    this.hint,
  });
}

enum EquationType {
  addition,
  subtraction,
  mixed
}