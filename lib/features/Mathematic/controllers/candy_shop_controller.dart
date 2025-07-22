// lib/features/Mathematic/controllers/candy_shop_controller.dart

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/models/candy_shop_model.dart';

class CandyShopController extends GetxController {
  // Observable variables
  final currentLevel = 1.obs;
  final availableCoins = 0.obs;
  final purchasedCandies = <Candy>[].obs;
  final completedLevels = <int>[].obs;
  final isLoading = false.obs;
  final showCelebration = false.obs;
  final showLevelComplete = false.obs;
  final isDraggingCoin = false.obs;
  final animationTrigger = 0.obs;

  // Current level data
  final currentLevelData = Rxn<CandyShopLevel>();
  final purchaseHistory = <CandyPurchase>[].obs;

  // Non-reactive variables
  final FlutterTts flutterTts = FlutterTts();
  final int maxLevel = CandyShopData.totalLevels;

  @override
  void onInit() {
    super.onInit();
    initTts();
    _initializeLevel();
  }

  @override
  void onClose() {
    flutterTts.stop();
    super.onClose();
  }

  Future<void> initTts() async {
    try {
      await flutterTts.setLanguage('fr-FR');
      await flutterTts.setSpeechRate(0.6);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.1);
    } catch (e) {
      print('TTS initialization error: $e');
    }
  }

  // Initialize current level
  void _initializeLevel() {
    isLoading.value = true;

    try {
      // Get level data
      currentLevelData.value = CandyShopData.getLevelData(currentLevel.value);

      // Set available coins for this level
      availableCoins.value = currentLevelData.value!.numberOfCoins;

      // Clear purchased candies
      purchasedCandies.clear();
      purchaseHistory.clear();

      // Reset drag state
      isDraggingCoin.value = false;
    } catch (e) {
      print('Error initializing level: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Handle coin drag start
  void onCoinDragStart() {
    isDraggingCoin.value = true;
  }

  // Handle coin drop on candy
  Future<void> purchaseCandy(Candy candy) async {
    if (availableCoins.value <= 0) {
      await _handleInsufficientCoins();
      return;
    }

    try {
      // Deduct coin
      availableCoins.value--;

      // Add candy to purchases
      purchasedCandies.add(candy);

      // Add to purchase history
      purchaseHistory.add(
        CandyPurchase(candy: candy, quantity: 1, purchaseTime: DateTime.now()),
      );

      // Trigger animation
      animationTrigger.value++;

      // Speak the candy name
      await speakCandy(candy);

      // Check if level is complete
      if (availableCoins.value == 0) {
        await _handleLevelComplete();
      }
    } catch (e) {
      print('Error purchasing candy: $e');
    } finally {
      isDraggingCoin.value = false;
    }
  }

  // Handle level completion
  Future<void> _handleLevelComplete() async {
    completedLevels.add(currentLevel.value);
    showLevelComplete.value = true;

    // Speak completion message
    await flutterTts.speak('Bravo! Tu as acheté tous les bonbons!');

    // Count candies purchased
    await speakNumber(purchasedCandies.length);
    await flutterTts.speak('bonbons achetés!');

    // Hide level complete after 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    showLevelComplete.value = false;

    // Check if game is complete
    if (currentLevel.value >= maxLevel) {
      await _handleGameComplete();
    } else {
      // Move to next level
      currentLevel.value++;
      _initializeLevel();
    }
  }

  // Handle game completion
  Future<void> _handleGameComplete() async {
    showCelebration.value = true;
    await flutterTts.speak(
      'Félicitations! Tu es un excellent acheteur de bonbons!',
    );

    // Hide celebration after 4 seconds
    await Future.delayed(const Duration(seconds: 4));
    showCelebration.value = false;
  }

  // Handle insufficient coins
  Future<void> _handleInsufficientCoins() async {
    final messages = [
      'Tu n\'as plus de pièces!',
      'Il faut des pièces pour acheter des bonbons!',
      'Plus de pièces dans ton porte-monnaie!',
    ];
    final message = messages[DateTime.now().millisecond % messages.length];
    await flutterTts.speak(message);
  }

  // Speak number in French
  Future<void> speakNumber(int number) async {
    try {
      final frenchNumbers = {
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
      };

      final frenchNumber = frenchNumbers[number] ?? number.toString();
      await flutterTts.speak(frenchNumber);
    } catch (e) {
      print('TTS speak number error: $e');
    }
  }

  // Speak candy name in French
  Future<void> speakCandy(Candy candy) async {
    try {
      await flutterTts.speak(candy.frenchName);
    } catch (e) {
      print('TTS speak candy error: $e');
    }
  }

  // Speak coins remaining
  Future<void> speakCoinsRemaining() async {
    try {
      final coins = availableCoins.value;
      await speakNumber(coins);

      if (coins == 1) {
        await flutterTts.speak('pièce restante');
      } else {
        await flutterTts.speak('pièces restantes');
      }
    } catch (e) {
      print('Error speaking coins remaining: $e');
    }
  }

  // Reset current level
  void resetCurrentLevel() {
    _initializeLevel();
  }

  // Reset entire game
  void resetGame() {
    currentLevel.value = 1;
    completedLevels.clear();
    showCelebration.value = false;
    showLevelComplete.value = false;
    _initializeLevel();
  }

  // Skip to next level (for testing)
  void skipToNextLevel() {
    if (currentLevel.value < maxLevel) {
      currentLevel.value++;
      _initializeLevel();
    }
  }

  // Get current level description
  String getCurrentLevelDescription() {
    return currentLevelData.value?.description ?? '';
  }

  // Get available candy types for current level
  List<Candy> getAvailableCandies() {
    return currentLevelData.value?.availableCandies ?? [];
  }

  // Get progress percentage for current level
  double getCurrentLevelProgress() {
    if (currentLevelData.value == null) return 0.0;
    final totalCoins = currentLevelData.value!.numberOfCoins;
    final spentCoins = totalCoins - availableCoins.value;
    return spentCoins / totalCoins;
  }

  // Get overall game progress
  double getOverallProgress() {
    return currentLevel.value / maxLevel;
  }

  // Check if can purchase candy
  bool canPurchaseCandy() {
    return availableCoins.value > 0;
  }

  // Get candy count by type
  int getCandyCount(String candyType) {
    return purchasedCandies.where((candy) => candy.type == candyType).length;
  }

  // Get total candies purchased this level
  int getTotalCandiesPurchased() {
    return purchasedCandies.length;
  }

  // Check if level is completed
  bool isLevelCompleted() {
    return availableCoins.value == 0;
  }

  // Get purchase summary for level
  Map<String, int> getPurchaseSummary() {
    final summary = <String, int>{};
    for (final candy in purchasedCandies) {
      summary[candy.type] = (summary[candy.type] ?? 0) + 1;
    }
    return summary;
  }

  // Replay level instructions
  Future<void> replayInstructions() async {
    await flutterTts.speak('Utilise tes pièces pour acheter des bonbons.');
    await speakNumber(availableCoins.value);
    await flutterTts.speak('pièces disponibles.');
  }
}
