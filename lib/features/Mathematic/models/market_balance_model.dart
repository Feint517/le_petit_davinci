// lib/features/Mathematic/models/market_balance_model.dart

import 'package:get/get.dart';

class MarketItem {
  final String id;
  final String type;
  final String frenchName;
  final String emoji;
  final String color;
  final double weight; // For visual effect (all items weight 1 for simplicity)

  const MarketItem({
    required this.id,
    required this.type,
    required this.frenchName,
    required this.emoji,
    required this.color,
    this.weight = 1.0,
  });
}

enum ScaleSide { left, right }

enum ComparisonType {
  equal, // =
  leftGreater, // >
  rightGreater, // <
}

enum LevelType {
  visualComparison, // Compare different items
  sameItemComparison, // Compare quantities of same item
  makeEqual, // Balance the scales
  numberVsObject, // Match number to quantity
}

class ScaleState {
  final List<MarketItem> leftItems;
  final List<MarketItem> rightItems;
  final ComparisonType comparison;
  final double leftWeight;
  final double rightWeight;
  final double tiltAngle; // For visual tipping effect

  const ScaleState({
    required this.leftItems,
    required this.rightItems,
    required this.comparison,
    required this.leftWeight,
    required this.rightWeight,
    required this.tiltAngle,
  });

  ScaleState copyWith({
    List<MarketItem>? leftItems,
    List<MarketItem>? rightItems,
    ComparisonType? comparison,
    double? leftWeight,
    double? rightWeight,
    double? tiltAngle,
  }) {
    return ScaleState(
      leftItems: leftItems ?? this.leftItems,
      rightItems: rightItems ?? this.rightItems,
      comparison: comparison ?? this.comparison,
      leftWeight: leftWeight ?? this.leftWeight,
      rightWeight: rightWeight ?? this.rightWeight,
      tiltAngle: tiltAngle ?? this.tiltAngle,
    );
  }

  bool get isBalanced => comparison == ComparisonType.equal;
  bool get isLeftHeavier => comparison == ComparisonType.leftGreater;
  bool get isRightHeavier => comparison == ComparisonType.rightGreater;
}

class BalanceLevel {
  final int level;
  final LevelType type;
  final String title;
  final String frenchTitle;
  final String description;
  final String instruction;
  final List<MarketItem> availableItems;
  final ScaleState initialState;
  final ScaleState targetState;
  final int maxItemsPerSide;

  const BalanceLevel({
    required this.level,
    required this.type,
    required this.title,
    required this.frenchTitle,
    required this.description,
    required this.instruction,
    required this.availableItems,
    required this.initialState,
    required this.targetState,
    this.maxItemsPerSide = 10,
  });
}

class MarketBalanceData {
  // Available market items
  static const List<MarketItem> allItems = [
    // Fruits
    MarketItem(
      id: 'apple',
      type: 'fruit',
      frenchName: 'pomme',
      emoji: '🍎',
      color: 'red',
    ),
    MarketItem(
      id: 'orange',
      type: 'fruit',
      frenchName: 'orange',
      emoji: '🍊',
      color: 'orange',
    ),
    MarketItem(
      id: 'banana',
      type: 'fruit',
      frenchName: 'banane',
      emoji: '🍌',
      color: 'yellow',
    ),
    MarketItem(
      id: 'grapes',
      type: 'fruit',
      frenchName: 'raisin',
      emoji: '🍇',
      color: 'purple',
    ),
    MarketItem(
      id: 'strawberry',
      type: 'fruit',
      frenchName: 'fraise',
      emoji: '🍓',
      color: 'red',
    ),

    // Vegetables
    MarketItem(
      id: 'carrot',
      type: 'vegetable',
      frenchName: 'carotte',
      emoji: '🥕',
      color: 'orange',
    ),
    MarketItem(
      id: 'tomato',
      type: 'vegetable',
      frenchName: 'tomate',
      emoji: '🍅',
      color: 'red',
    ),
    MarketItem(
      id: 'broccoli',
      type: 'vegetable',
      frenchName: 'brocoli',
      emoji: '🥦',
      color: 'green',
    ),
    MarketItem(
      id: 'corn',
      type: 'vegetable',
      frenchName: 'maïs',
      emoji: '🌽',
      color: 'yellow',
    ),
    MarketItem(
      id: 'potato',
      type: 'vegetable',
      frenchName: 'pomme de terre',
      emoji: '🥔',
      color: 'brown',
    ),
  ];

  // Get items by type
  static List<MarketItem> getItemsByType(String type) {
    return allItems.where((item) => item.type == type).toList();
  }

  // Get item by ID
  static MarketItem? getItemById(String id) {
    return allItems.firstWhereOrNull((item) => item.id == id);
  }

  // Progressive levels
  static final List<BalanceLevel> levels = [
    // Level 1: Visual Comparison (Different Items)
    BalanceLevel(
      level: 1,
      type: LevelType.visualComparison,
      title: 'Visual Comparison',
      frenchTitle: 'Comparaison Visuelle',
      description:
          'Compare les quantités: y a-t-il plus de pommes ou d\'oranges?',
      instruction: 'Regarde bien et compare les deux côtés',
      availableItems: [], // Pre-set items
      initialState: ScaleState(
        leftItems: [allItems[0], allItems[0], allItems[0]], // 3 apples
        rightItems: [
          allItems[1],
          allItems[1],
          allItems[1],
          allItems[1],
          allItems[1],
        ], // 5 oranges
        comparison: ComparisonType.rightGreater,
        leftWeight: 3,
        rightWeight: 5,
        tiltAngle: -15, // Tilts right
      ),
      targetState: ScaleState(
        leftItems: [allItems[0], allItems[0], allItems[0]],
        rightItems: [
          allItems[1],
          allItems[1],
          allItems[1],
          allItems[1],
          allItems[1],
        ],
        comparison: ComparisonType.rightGreater,
        leftWeight: 3,
        rightWeight: 5,
        tiltAngle: -15,
      ),
    ),

    // Level 2: Same Items, Different Quantities
    BalanceLevel(
      level: 2,
      type: LevelType.sameItemComparison,
      title: 'Same Items Comparison',
      frenchTitle: 'Comparaison des Mêmes Objets',
      description: 'Compare les quantités de carottes: quel côté en a plus?',
      instruction: 'Compare les carottes des deux côtés',
      availableItems: [], // Pre-set items
      initialState: ScaleState(
        leftItems: List.filled(4, allItems[5]), // 4 carrots
        rightItems: List.filled(6, allItems[5]), // 6 carrots
        comparison: ComparisonType.rightGreater,
        leftWeight: 4,
        rightWeight: 6,
        tiltAngle: -10,
      ),
      targetState: ScaleState(
        leftItems: List.filled(4, allItems[5]),
        rightItems: List.filled(6, allItems[5]),
        comparison: ComparisonType.rightGreater,
        leftWeight: 4,
        rightWeight: 6,
        tiltAngle: -10,
      ),
    ),

    // Level 3: Make It Equal
    BalanceLevel(
      level: 3,
      type: LevelType.makeEqual,
      title: 'Balance the Scale',
      frenchTitle: 'Équilibrer la Balance',
      description: 'Ajoute des pommes pour équilibrer la balance parfaitement.',
      instruction: 'Fais glisser des pommes pour équilibrer',
      availableItems: List.filled(10, allItems[0]), // 10 apples available
      initialState: ScaleState(
        leftItems: List.filled(3, allItems[0]), // 3 apples already
        rightItems: List.filled(7, allItems[0]), // 7 apples on right
        comparison: ComparisonType.rightGreater,
        leftWeight: 3,
        rightWeight: 7,
        tiltAngle: -20,
      ),
      targetState: ScaleState(
        leftItems: List.filled(7, allItems[0]), // Need 7 apples total
        rightItems: List.filled(7, allItems[0]),
        comparison: ComparisonType.equal,
        leftWeight: 7,
        rightWeight: 7,
        tiltAngle: 0,
      ),
    ),

    // Level 4: Numbers vs Objects
    BalanceLevel(
      level: 4,
      type: LevelType.numberVsObject,
      title: 'Numbers vs Objects',
      frenchTitle: 'Chiffres contre Objets',
      description:
          'Le chiffre 8 est sur la balance. Ajoute 8 tomates pour équilibrer.',
      instruction: 'Égale le nombre avec des objets',
      availableItems: List.filled(12, allItems[6]), // 12 tomatoes available
      initialState: ScaleState(
        leftItems: [], // Number 8 will be shown visually
        rightItems: [],
        comparison: ComparisonType.leftGreater, // Number side starts heavy
        leftWeight: 8, // Represents number weight
        rightWeight: 0,
        tiltAngle: 20,
      ),
      targetState: ScaleState(
        leftItems: [],
        rightItems: List.filled(8, allItems[6]), // 8 tomatoes
        comparison: ComparisonType.equal,
        leftWeight: 8,
        rightWeight: 8,
        tiltAngle: 0,
      ),
    ),
  ];

  // Get level data
  static BalanceLevel getLevelData(int level) {
    if (level < 1 || level > levels.length) {
      return levels[0];
    }
    return levels[level - 1];
  }

  // Get total number of levels
  static int get totalLevels => levels.length;

  // Calculate comparison from weights
  static ComparisonType calculateComparison(
    double leftWeight,
    double rightWeight,
  ) {
    const threshold = 0.1; // Small threshold for floating point comparison

    if ((leftWeight - rightWeight).abs() < threshold) {
      return ComparisonType.equal;
    } else if (leftWeight > rightWeight) {
      return ComparisonType.leftGreater;
    } else {
      return ComparisonType.rightGreater;
    }
  }

  // Calculate tilt angle from weights
  static double calculateTiltAngle(double leftWeight, double rightWeight) {
    const maxAngle = 25.0;
    const sensitivity = 2.0;

    final difference = leftWeight - rightWeight;
    final angle = (difference * sensitivity).clamp(-maxAngle, maxAngle);

    return angle;
  }

  // Get French comparison phrase
  static String getComparisonPhrase(
    ComparisonType comparison,
    String leftItem,
    String rightItem,
  ) {
    switch (comparison) {
      case ComparisonType.equal:
        return 'Il y a autant de $leftItem que de $rightItem';
      case ComparisonType.leftGreater:
        return 'Il y a plus de $leftItem que de $rightItem';
      case ComparisonType.rightGreater:
        return 'Il y a plus de $rightItem que de $leftItem';
    }
  }

  // Get comparison symbol
  static String getComparisonSymbol(ComparisonType comparison) {
    switch (comparison) {
      case ComparisonType.equal:
        return '=';
      case ComparisonType.leftGreater:
        return '>';
      case ComparisonType.rightGreater:
        return '<';
    }
  }
}

// Model for tracking balance progress
class BalanceProgress {
  final int currentLevel;
  final int totalLevels;
  final bool isLevelCompleted;
  final bool isGameCompleted;
  final List<int> completedLevels;
  final ScaleState currentState;
  final int correctComparisons;
  final int totalComparisons;

  const BalanceProgress({
    required this.currentLevel,
    required this.totalLevels,
    required this.isLevelCompleted,
    required this.isGameCompleted,
    required this.completedLevels,
    required this.currentState,
    required this.correctComparisons,
    required this.totalComparisons,
  });

  BalanceProgress copyWith({
    int? currentLevel,
    int? totalLevels,
    bool? isLevelCompleted,
    bool? isGameCompleted,
    List<int>? completedLevels,
    ScaleState? currentState,
    int? correctComparisons,
    int? totalComparisons,
  }) {
    return BalanceProgress(
      currentLevel: currentLevel ?? this.currentLevel,
      totalLevels: totalLevels ?? this.totalLevels,
      isLevelCompleted: isLevelCompleted ?? this.isLevelCompleted,
      isGameCompleted: isGameCompleted ?? this.isGameCompleted,
      completedLevels: completedLevels ?? this.completedLevels,
      currentState: currentState ?? this.currentState,
      correctComparisons: correctComparisons ?? this.correctComparisons,
      totalComparisons: totalComparisons ?? this.totalComparisons,
    );
  }

  double get progressPercentage {
    if (totalLevels == 0) return 0.0;
    return currentLevel / totalLevels;
  }

  double get accuracyPercentage {
    if (totalComparisons == 0) return 0.0;
    return correctComparisons / totalComparisons;
  }
}
