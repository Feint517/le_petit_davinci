// lib/features/Mathematic/models/candy_shop_model.dart

class Candy {
  final String type;
  final String frenchName;
  final String emoji;
  final String color;
  final double price; // Always 1 coin for simplicity

  const Candy({
    required this.type,
    required this.frenchName,
    required this.emoji,
    required this.color,
    this.price = 1.0,
  });
}

class CandyShopLevel {
  final int level;
  final int numberOfCoins;
  final List<Candy> availableCandies;
  final String description;
  final int maxCandiesPerType;

  const CandyShopLevel({
    required this.level,
    required this.numberOfCoins,
    required this.availableCandies,
    required this.description,
    this.maxCandiesPerType = 10,
  });
}

class CandyPurchase {
  final Candy candy;
  final int quantity;
  final DateTime purchaseTime;

  const CandyPurchase({
    required this.candy,
    required this.quantity,
    required this.purchaseTime,
  });
}

class CandyShopData {
  // Available candy types
  static const List<Candy> allCandies = [
    Candy(type: 'lollipop', frenchName: 'sucette', emoji: '🍭', color: 'red'),
    Candy(
      type: 'chocolate',
      frenchName: 'chocolat',
      emoji: '🍫',
      color: 'brown',
    ),
    Candy(
      type: 'gummy_bear',
      frenchName: 'ourson',
      emoji: '🧸',
      color: 'green',
    ),
    Candy(type: 'candy', frenchName: 'bonbon', emoji: '🍬', color: 'rainbow'),
    Candy(type: 'cupcake', frenchName: 'gâteau', emoji: '🧁', color: 'pink'),
    Candy(type: 'donut', frenchName: 'beignet', emoji: '🍩', color: 'orange'),
    Candy(type: 'cookie', frenchName: 'biscuit', emoji: '🍪', color: 'brown'),
    Candy(type: 'ice_cream', frenchName: 'glace', emoji: '🍦', color: 'white'),
  ];

  // Progressive levels
  static final List<CandyShopLevel> levels = [
    CandyShopLevel(
      level: 1,
      numberOfCoins: 3,
      availableCandies: [
        allCandies[0],
        allCandies[1],
        allCandies[2],
      ], // 3 types
      description: 'Achète 3 bonbons avec 3 pièces',
      maxCandiesPerType: 5,
    ),
    CandyShopLevel(
      level: 2,
      numberOfCoins: 5,
      availableCandies: [
        allCandies[0],
        allCandies[1],
        allCandies[2],
        allCandies[3],
      ], // 4 types
      description: 'Achète 5 bonbons avec 5 pièces',
      maxCandiesPerType: 8,
    ),
    CandyShopLevel(
      level: 3,
      numberOfCoins: 7,
      availableCandies: [
        allCandies[0],
        allCandies[1],
        allCandies[2],
        allCandies[3],
        allCandies[4],
      ], // 5 types
      description: 'Achète 7 bonbons avec 7 pièces',
      maxCandiesPerType: 10,
    ),
    const CandyShopLevel(
      level: 4,
      numberOfCoins: 10,
      availableCandies: allCandies, // All types available
      description: 'Achète 10 bonbons avec 10 pièces',
      maxCandiesPerType: 15,
    ),
  ];

  // Get level data
  static CandyShopLevel getLevelData(int level) {
    if (level < 1 || level > levels.length) {
      return levels[0]; // Default to level 1
    }
    return levels[level - 1];
  }

  // Get total number of levels
  static int get totalLevels => levels.length;

  // Get random candy from available types
  static Candy getRandomCandy(List<Candy> availableCandies) {
    availableCandies.shuffle();
    return availableCandies.first;
  }

  // Validate purchase (always true since 1 coin = 1 candy)
  static bool canPurchase(int coinsAvailable, Candy candy) {
    return coinsAvailable >= candy.price.toInt();
  }
}

// Model for tracking shop progress
class ShopProgress {
  final int currentLevel;
  final int totalLevels;
  final int coinsSpent;
  final int candiesPurchased;
  final bool isLevelCompleted;
  final bool isGameCompleted;
  final List<CandyPurchase> purchaseHistory;
  final List<int> completedLevels;

  const ShopProgress({
    required this.currentLevel,
    required this.totalLevels,
    required this.coinsSpent,
    required this.candiesPurchased,
    required this.isLevelCompleted,
    required this.isGameCompleted,
    required this.purchaseHistory,
    required this.completedLevels,
  });

  ShopProgress copyWith({
    int? currentLevel,
    int? totalLevels,
    int? coinsSpent,
    int? candiesPurchased,
    bool? isLevelCompleted,
    bool? isGameCompleted,
    List<CandyPurchase>? purchaseHistory,
    List<int>? completedLevels,
  }) {
    return ShopProgress(
      currentLevel: currentLevel ?? this.currentLevel,
      totalLevels: totalLevels ?? this.totalLevels,
      coinsSpent: coinsSpent ?? this.coinsSpent,
      candiesPurchased: candiesPurchased ?? this.candiesPurchased,
      isLevelCompleted: isLevelCompleted ?? this.isLevelCompleted,
      isGameCompleted: isGameCompleted ?? this.isGameCompleted,
      purchaseHistory: purchaseHistory ?? this.purchaseHistory,
      completedLevels: completedLevels ?? this.completedLevels,
    );
  }

  double get progressPercentage {
    if (totalLevels == 0) return 0.0;
    return currentLevel / totalLevels;
  }
}

// Model for drag and drop state
class CoinDragState {
  final int availableCoins;
  final List<Candy> purchasedCandies;
  final bool isDragging;
  final Candy? targetCandy;

  const CoinDragState({
    required this.availableCoins,
    required this.purchasedCandies,
    this.isDragging = false,
    this.targetCandy,
  });

  CoinDragState copyWith({
    int? availableCoins,
    List<Candy>? purchasedCandies,
    bool? isDragging,
    Candy? targetCandy,
  }) {
    return CoinDragState(
      availableCoins: availableCoins ?? this.availableCoins,
      purchasedCandies: purchasedCandies ?? this.purchasedCandies,
      isDragging: isDragging ?? this.isDragging,
      targetCandy: targetCandy,
    );
  }

  bool get hasCoins => availableCoins > 0;
  bool get canPurchase => hasCoins;
  int get totalCandiesPurchased => purchasedCandies.length;
}
