// lib/features/Mathematic/models/treasure_chest_model.dart

class TreasureItem {
  final String id;
  final String type;
  final String frenchName;
  final String emoji;
  final int value; // All items worth 1 for simplicity
  final String color;

  const TreasureItem({
    required this.id,
    required this.type,
    required this.frenchName,
    required this.emoji,
    this.value = 1,
    required this.color,
  });
}

class NumberBond {
  final int firstNumber;
  final int secondNumber;
  final int target;
  final bool isDiscovered;

  const NumberBond({
    required this.firstNumber,
    required this.secondNumber,
    required this.target,
    this.isDiscovered = false,
  });

  NumberBond copyWith({
    int? firstNumber,
    int? secondNumber,
    int? target,
    bool? isDiscovered,
  }) {
    return NumberBond(
      firstNumber: firstNumber ?? this.firstNumber,
      secondNumber: secondNumber ?? this.secondNumber,
      target: target ?? this.target,
      isDiscovered: isDiscovered ?? this.isDiscovered,
    );
  }

  String get equation => '$firstNumber + $secondNumber = $target';
  String get frenchEquation => '$firstNumber plus $secondNumber fait $target';
}

enum ChestState { closed, glowing, opening, opened, sparkling }

class TreasureChest {
  final String id;
  final int targetAmount;
  final int currentAmount;
  final ChestState state;
  final List<TreasureItem> containedItems;
  final String title;
  final String frenchTitle;

  const TreasureChest({
    required this.id,
    required this.targetAmount,
    required this.currentAmount,
    required this.state,
    required this.containedItems,
    required this.title,
    required this.frenchTitle,
  });

  TreasureChest copyWith({
    String? id,
    int? targetAmount,
    int? currentAmount,
    ChestState? state,
    List<TreasureItem>? containedItems,
    String? title,
    String? frenchTitle,
  }) {
    return TreasureChest(
      id: id ?? this.id,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      state: state ?? this.state,
      containedItems: containedItems ?? this.containedItems,
      title: title ?? this.title,
      frenchTitle: frenchTitle ?? this.frenchTitle,
    );
  }

  bool get isFull => currentAmount == targetAmount;
  bool get isOverfull => currentAmount > targetAmount;
  bool get isEmpty => currentAmount == 0;
  double get fillPercentage =>
      targetAmount == 0 ? 0.0 : currentAmount / targetAmount;
  int get remainingSpace =>
      (targetAmount - currentAmount).clamp(0, targetAmount);
  bool get isNearTarget => remainingSpace <= 2 && remainingSpace > 0;
}

enum LevelType {
  visualMake10, // Visual completion with pre-existing items
  numberBonds, // Equation-based number bonds
  discoverAll, // Find all combinations
  otherTargets, // Different target numbers
}

class TreasureLevel {
  final int level;
  final LevelType type;
  final String title;
  final String frenchTitle;
  final String description;
  final String instruction;
  final int targetNumber;
  final List<TreasureItem> availableItems;
  final TreasureChest initialChest;
  final List<NumberBond> targetBonds;
  final int maxAttempts;

  const TreasureLevel({
    required this.level,
    required this.type,
    required this.title,
    required this.frenchTitle,
    required this.description,
    required this.instruction,
    required this.targetNumber,
    required this.availableItems,
    required this.initialChest,
    required this.targetBonds,
    this.maxAttempts = 20,
  });
}

class TreasureChestData {
  // Available treasure items
  static const List<TreasureItem> allTreasureItems = [
    // Gold coins
    TreasureItem(
      id: 'gold_coin',
      type: 'coin',
      frenchName: 'pièce d\'or',
      emoji: '🪙',
      color: 'gold',
    ),

    // Gems
    TreasureItem(
      id: 'ruby',
      type: 'gem',
      frenchName: 'rubis',
      emoji: '💎',
      color: 'red',
    ),
    TreasureItem(
      id: 'emerald',
      type: 'gem',
      frenchName: 'émeraude',
      emoji: '💚',
      color: 'green',
    ),
    TreasureItem(
      id: 'sapphire',
      type: 'gem',
      frenchName: 'saphir',
      emoji: '💙',
      color: 'blue',
    ),

    // Jewelry
    TreasureItem(
      id: 'crown',
      type: 'jewelry',
      frenchName: 'couronne',
      emoji: '👑',
      color: 'gold',
    ),
    TreasureItem(
      id: 'ring',
      type: 'jewelry',
      frenchName: 'bague',
      emoji: '💍',
      color: 'gold',
    ),

    // Pearls
    TreasureItem(
      id: 'pearl',
      type: 'pearl',
      frenchName: 'perle',
      emoji: '🦪',
      color: 'white',
    ),
  ];

  // Get all possible number bonds for a target
  static List<NumberBond> getAllBondsForTarget(int target) {
    final bonds = <NumberBond>[];

    for (int i = 0; i <= target; i++) {
      final complement = target - i;
      if (complement >= 0) {
        bonds.add(
          NumberBond(firstNumber: i, secondNumber: complement, target: target),
        );
      }
    }

    return bonds;
  }

  // Get specific number bonds (avoiding duplicates like 3+7 and 7+3)
  static List<NumberBond> getUniqueBondsForTarget(int target) {
    final bonds = <NumberBond>[];

    for (int i = 0; i <= target ~/ 2; i++) {
      final complement = target - i;
      bonds.add(
        NumberBond(firstNumber: i, secondNumber: complement, target: target),
      );
    }

    return bonds;
  }

  // Progressive levels
  static final List<TreasureLevel> levels = [
    // Level 1: Visual Make 10
    TreasureLevel(
      level: 1,
      type: LevelType.visualMake10,
      title: 'Complete the Treasure',
      frenchTitle: 'Compléter le Trésor',
      description:
          'Il y a déjà 6 pièces d\'or dans le coffre. Ajoute les pièces manquantes pour faire exactement 10!',
      instruction: 'Fais glisser des pièces pour compléter le trésor',
      targetNumber: 10,
      availableItems: List.filled(10, allTreasureItems[0]), // 10 gold coins
      initialChest: TreasureChest(
        id: 'main_chest',
        targetAmount: 10,
        currentAmount: 6, // Pre-filled with 6 items
        state: ChestState.closed,
        containedItems: List.filled(6, allTreasureItems[0]),
        title: 'Magic Chest',
        frenchTitle: 'Coffre Magique',
      ),
      targetBonds: [NumberBond(firstNumber: 6, secondNumber: 4, target: 10)],
    ),

    // Level 2: Number Bonds to 10
    TreasureLevel(
      level: 2,
      type: LevelType.numberBonds,
      title: 'Number Bonds to 10',
      frenchTitle: 'Combinaisons pour 10',
      description:
          'Résous l\'équation: 7 + ? = 10. Glisse le bon nombre de trésors dans le coffre!',
      instruction: 'Complete l\'équation avec des trésors',
      targetNumber: 10,
      availableItems: List.filled(15, allTreasureItems[1]), // 15 rubies
      initialChest: TreasureChest(
        id: 'equation_chest',
        targetAmount: 10,
        currentAmount: 7, // Pre-filled with 7 items
        state: ChestState.closed,
        containedItems: List.filled(7, allTreasureItems[1]),
        title: 'Equation Chest',
        frenchTitle: 'Coffre des Équations',
      ),
      targetBonds: [
        NumberBond(firstNumber: 7, secondNumber: 3, target: 10),
        NumberBond(firstNumber: 8, secondNumber: 2, target: 10),
        NumberBond(firstNumber: 9, secondNumber: 1, target: 10),
        NumberBond(firstNumber: 5, secondNumber: 5, target: 10),
      ],
    ),

    // Level 3: Discover All Combinations
    TreasureLevel(
      level: 3,
      type: LevelType.discoverAll,
      title: 'Discover All Ways',
      frenchTitle: 'Découvrir Toutes les Façons',
      description:
          'Trouve TOUTES les façons de faire 10! Chaque nouvelle combinaison révèle un morceau de la carte au trésor.',
      instruction: 'Trouve toutes les combinaisons possibles',
      targetNumber: 10,
      availableItems: List.filled(20, allTreasureItems[2]), // 20 emeralds
      initialChest: TreasureChest(
        id: 'discovery_chest',
        targetAmount: 10,
        currentAmount: 0, // Start empty
        state: ChestState.closed,
        containedItems: [],
        title: 'Discovery Chest',
        frenchTitle: 'Coffre de Découverte',
      ),
      targetBonds: getUniqueBondsForTarget(10), // All unique combinations
    ),

    // Level 4: Other Target Numbers
    TreasureLevel(
      level: 4,
      type: LevelType.otherTargets,
      title: 'New Challenges',
      frenchTitle: 'Nouveaux Défis',
      description:
          'Maîtrise d\'autres nombres! Trouve les façons de faire 8, puis 12.',
      instruction: 'Explore différents nombres cibles',
      targetNumber: 8, // Will cycle through 8, 9, 12
      availableItems: allTreasureItems, // Mix of all treasures
      initialChest: TreasureChest(
        id: 'challenge_chest',
        targetAmount: 8,
        currentAmount: 0,
        state: ChestState.closed,
        containedItems: [],
        title: 'Challenge Chest',
        frenchTitle: 'Coffre des Défis',
      ),
      targetBonds: [
        ...getUniqueBondsForTarget(8),
        ...getUniqueBondsForTarget(9),
        ...getUniqueBondsForTarget(12),
      ],
    ),
  ];

  // Get level data
  static TreasureLevel getLevelData(int level) {
    if (level < 1 || level > levels.length) {
      return levels[0];
    }
    return levels[level - 1];
  }

  // Get total number of levels
  static int get totalLevels => levels.length;

  // Calculate chest state based on current amount
  static ChestState calculateChestState(int currentAmount, int targetAmount) {
    if (currentAmount == 0) {
      return ChestState.closed;
    } else if (currentAmount == targetAmount) {
      return ChestState.opened;
    } else if (currentAmount > targetAmount) {
      return ChestState.closed; // Too much, chest won't open
    } else if (targetAmount - currentAmount <= 2) {
      return ChestState.glowing; // Getting close
    } else {
      return ChestState.closed;
    }
  }

  // Get French number name
  static String getFrenchNumber(int number) {
    const frenchNumbers = {
      0: 'zéro',
      1: 'un',
      2: 'deux',
      3: 'trois',
      4: 'quatre',
      5: 'cinq',
      6: 'six',
      7: 'sept',
      8: 'huit',
      9: 'neuf',
      10: 'dix',
      11: 'onze',
      12: 'douze',
      13: 'treize',
      14: 'quatorze',
      15: 'quinze',
      16: 'seize',
      17: 'dix-sept',
      18: 'dix-huit',
      19: 'dix-neuf',
      20: 'vingt',
    };

    return frenchNumbers[number] ?? number.toString();
  }

  // Get completion message for number bonds
  static String getCompletionMessage(
    int target,
    int firstNumber,
    int secondNumber,
  ) {
    final frenchTarget = getFrenchNumber(target);
    final frenchFirst = getFrenchNumber(firstNumber);
    final frenchSecond = getFrenchNumber(secondNumber);

    return '$frenchFirst plus $frenchSecond font $frenchTarget!';
  }

  // Get progress towards target
  static double getProgressToTarget(int currentAmount, int targetAmount) {
    if (targetAmount == 0) return 1.0;
    return (currentAmount / targetAmount).clamp(0.0, 1.0);
  }
}

// Model for tracking treasure progress
class TreasureProgress {
  final int currentLevel;
  final int totalLevels;
  final bool isLevelCompleted;
  final bool isGameCompleted;
  final List<int> completedLevels;
  final List<NumberBond> discoveredBonds;
  final int totalBondsToDiscover;
  final TreasureChest currentChest;

  const TreasureProgress({
    required this.currentLevel,
    required this.totalLevels,
    required this.isLevelCompleted,
    required this.isGameCompleted,
    required this.completedLevels,
    required this.discoveredBonds,
    required this.totalBondsToDiscover,
    required this.currentChest,
  });

  TreasureProgress copyWith({
    int? currentLevel,
    int? totalLevels,
    bool? isLevelCompleted,
    bool? isGameCompleted,
    List<int>? completedLevels,
    List<NumberBond>? discoveredBonds,
    int? totalBondsToDiscover,
    TreasureChest? currentChest,
  }) {
    return TreasureProgress(
      currentLevel: currentLevel ?? this.currentLevel,
      totalLevels: totalLevels ?? this.totalLevels,
      isLevelCompleted: isLevelCompleted ?? this.isLevelCompleted,
      isGameCompleted: isGameCompleted ?? this.isGameCompleted,
      completedLevels: completedLevels ?? this.completedLevels,
      discoveredBonds: discoveredBonds ?? this.discoveredBonds,
      totalBondsToDiscover: totalBondsToDiscover ?? this.totalBondsToDiscover,
      currentChest: currentChest ?? this.currentChest,
    );
  }

  double get discoveryProgress {
    if (totalBondsToDiscover == 0) return 1.0;
    return discoveredBonds.length / totalBondsToDiscover;
  }

  double get overallProgress {
    if (totalLevels == 0) return 0.0;
    return completedLevels.length / totalLevels;
  }
}
