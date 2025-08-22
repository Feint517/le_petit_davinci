class ShapePatternExercise {
  final List<String> patternImages;
  final List<String> optionImages;
  final int correctIndex;
  final String instruction;
  final PatternType patternType;
  
  const ShapePatternExercise({
    required this.patternImages,
    required this.optionImages,
    required this.correctIndex,
    required this.instruction,
    required this.patternType,
  });
}

enum PatternType {
  shapes,
  numbers,
  colors
}