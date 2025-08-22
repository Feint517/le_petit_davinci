class ArrangeNumbersExercise {
  final List<int> numbers;
  final bool isAscending;
  final String instruction;
  final int? maxNumber;
  final int? minNumber;
  
  const ArrangeNumbersExercise({
    required this.numbers,
    required this.isAscending,
    required this.instruction,
    this.maxNumber,
    this.minNumber,
  });
}