// lib/features/Mathematic/models/number_puzzle_model.dart

class NumberSequence {
  final List<int?> sequence; // null represents missing numbers
  final List<int> missingNumbers; // Numbers that need to be placed
  final String description;
  final SequenceDifficulty difficulty;
  final int level;

  const NumberSequence({
    required this.sequence,
    required this.missingNumbers,
    required this.description,
    required this.difficulty,
    required this.level,
  });

  // Check if sequence is complete
  bool get isComplete {
    return !sequence.contains(null);
  }

  // Get the correct number for a specific position
  int? getCorrectNumberAt(int index) {
    if (index < 0 || index >= sequence.length) return null;
    
    // Calculate what the number should be based on the pattern
    switch (difficulty) {
      case SequenceDifficulty.sequential:
        return _getSequentialNumber(index);
      case SequenceDifficulty.skipByTwo:
        return _getSkipByTwoNumber(index);
      case SequenceDifficulty.skipByFive:
        return _getSkipByFiveNumber(index);
      case SequenceDifficulty.backwards:
        return _getBackwardsNumber(index);
    }
  }

  int? _getSequentialNumber(int index) {
    // Find first non-null number to establish the starting point
    for (int i = 0; i < sequence.length; i++) {
      if (sequence[i] != null) {
        return sequence[i]! + (index - i);
      }
    }
    return index + 1; // Default start from 1
  }

  int? _getSkipByTwoNumber(int index) {
    for (int i = 0; i < sequence.length; i++) {
      if (sequence[i] != null) {
        return sequence[i]! + ((index - i) * 2);
      }
    }
    return (index * 2) + 2; // Default start from 2
  }

  int? _getSkipByFiveNumber(int index) {
    for (int i = 0; i < sequence.length; i++) {
      if (sequence[i] != null) {
        return sequence[i]! + ((index - i) * 5);
      }
    }
    return (index * 5) + 5; // Default start from 5
  }

  int? _getBackwardsNumber(int index) {
    for (int i = 0; i < sequence.length; i++) {
      if (sequence[i] != null) {
        return sequence[i]! - (index - i);
      }
    }
    return 10 - index; // Default start from 10
  }
}

enum SequenceDifficulty {
  sequential,    // 1, 2, 3, 4, 5
  skipByTwo,     // 2, 4, 6, 8, 10
  skipByFive,    // 5, 10, 15, 20, 25
  backwards,     // 10, 9, 8, 7, 6
}

class NumberPuzzleData {
  // Level 1: Simple sequential patterns
  static const List<NumberSequence> level1Sequences = [
    NumberSequence(
      sequence: [1, 2, null, 4, 5],
      missingNumbers: [3],
      description: "Compte de 1 à 5",
      difficulty: SequenceDifficulty.sequential,
      level: 1,
    ),
    NumberSequence(
      sequence: [null, 3, 4, 5, null],
      missingNumbers: [2, 6],
      description: "Complète la séquence",
      difficulty: SequenceDifficulty.sequential,
      level: 1,
    ),
    NumberSequence(
      sequence: [6, 7, null, null, 10],
      missingNumbers: [8, 9],
      description: "Continue à compter",
      difficulty: SequenceDifficulty.sequential,
      level: 1,
    ),
  ];

  // Level 2: Skip counting by 2
  static const List<NumberSequence> level2Sequences = [
    NumberSequence(
      sequence: [2, 4, null, 8, null],
      missingNumbers: [6, 10],
      description: "Compte par bonds de 2",
      difficulty: SequenceDifficulty.skipByTwo,
      level: 2,
    ),
    NumberSequence(
      sequence: [null, 6, 8, null, 12],
      missingNumbers: [4, 10],
      description: "Les nombres pairs",
      difficulty: SequenceDifficulty.skipByTwo,
      level: 2,
    ),
    NumberSequence(
      sequence: [12, null, 16, 18, null],
      missingNumbers: [14, 20],
      description: "Continue les nombres pairs",
      difficulty: SequenceDifficulty.skipByTwo,
      level: 2,
    ),
  ];

  // Level 3: Backwards counting
  static const List<NumberSequence> level3Sequences = [
    NumberSequence(
      sequence: [10, 9, null, 7, null],
      missingNumbers: [8, 6],
      description: "Compte à l'envers",
      difficulty: SequenceDifficulty.backwards,
      level: 3,
    ),
    NumberSequence(
      sequence: [null, 4, 3, null, 1],
      missingNumbers: [5, 2],
      description: "Continue à reculer",
      difficulty: SequenceDifficulty.backwards,
      level: 3,
    ),
    NumberSequence(
      sequence: [8, null, 6, 5, null],
      missingNumbers: [7, 4],
      description: "Décompte",
      difficulty: SequenceDifficulty.backwards,
      level: 3,
    ),
  ];

  // Get sequences for a specific level
  static List<NumberSequence> getSequencesForLevel(int level) {
    switch (level) {
      case 1:
        return level1Sequences;
      case 2:
        return level2Sequences;
      case 3:
        return level3Sequences;
      default:
        return level1Sequences;
    }
  }

  // Get total number of levels
  static int get totalLevels => 3;

  // Get all available missing numbers for a level (shuffled)
  static List<int> getAllMissingNumbersForLevel(int level) {
    final sequences = getSequencesForLevel(level);
    final allNumbers = <int>[];
    
    for (final sequence in sequences) {
      allNumbers.addAll(sequence.missingNumbers);
    }
    
    // Add some extra distractors
    final distractors = _getDistractorsForLevel(level);
    allNumbers.addAll(distractors);
    
    allNumbers.shuffle();
    return allNumbers;
  }

  // Get distractor numbers (wrong answers) for each level
  static List<int> _getDistractorsForLevel(int level) {
    switch (level) {
      case 1:
        return [11, 12, 13]; // Sequential distractors
      case 2:
        return [3, 5, 7, 11]; // Odd numbers as distractors for even sequences
      case 3:
        return [0, 11, 12]; // Numbers outside typical backwards range
      default:
        return [];
    }
  }
}

// Model for tracking puzzle progress
class PuzzleProgress {
  final int currentLevel;
  final int currentSequenceIndex;
  final int totalLevels;
  final bool isLevelCompleted;
  final bool isGameCompleted;
  final List<int> completedLevels;

  const PuzzleProgress({
    required this.currentLevel,
    required this.currentSequenceIndex,
    required this.totalLevels,
    required this.isLevelCompleted,
    required this.isGameCompleted,
    required this.completedLevels,
  });

  PuzzleProgress copyWith({
    int? currentLevel,
    int? currentSequenceIndex,
    int? totalLevels,
    bool? isLevelCompleted,
    bool? isGameCompleted,
    List<int>? completedLevels,
  }) {
    return PuzzleProgress(
      currentLevel: currentLevel ?? this.currentLevel,
      currentSequenceIndex: currentSequenceIndex ?? this.currentSequenceIndex,
      totalLevels: totalLevels ?? this.totalLevels,
      isLevelCompleted: isLevelCompleted ?? this.isLevelCompleted,
      isGameCompleted: isGameCompleted ?? this.isGameCompleted,
      completedLevels: completedLevels ?? this.completedLevels,
    );
  }
}

// Model for drag and drop state
class DragDropState {
  final Map<int, int?> droppedNumbers; // position -> number
  final List<int> availableNumbers;
  final int? draggedNumber;
  final bool isValidDrop;

  const DragDropState({
    required this.droppedNumbers,
    required this.availableNumbers,
    this.draggedNumber,
    this.isValidDrop = false,
  });

  DragDropState copyWith({
    Map<int, int?>? droppedNumbers,
    List<int>? availableNumbers,
    int? draggedNumber,
    bool? isValidDrop,
  }) {
    return DragDropState(
      droppedNumbers: droppedNumbers ?? this.droppedNumbers,
      availableNumbers: availableNumbers ?? this.availableNumbers,
      draggedNumber: draggedNumber,
      isValidDrop: isValidDrop ?? this.isValidDrop,
    );
  }
}