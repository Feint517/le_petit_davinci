// lib/features/Mathematic/controllers/animal_counting_controller.dart
// FIXED VERSION

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/models/animal_counting_model.dart';

class AnimalCountingController extends GetxController {
  // Observable variables
  final selectedNumber = 0.obs;
  final currentAnimals = <Animal>[].obs;
  final completedNumbers = <int>[].obs;
  final isLoading = false.obs;
  final showCelebration = false.obs;
  final animationTrigger = 0.obs;

  // Non-reactive variables
  final FlutterTts flutterTts = FlutterTts();
  final int maxNumber = 10;
  final int minNumber = 1;

  // FIX 8: Add initialization state tracking
  final isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    print('AnimalCountingController onInit called');
    initTts();
  }

  @override
  void onClose() {
    print('AnimalCountingController onClose called');
    flutterTts.stop();
    super.onClose();
  }

  Future<void> initTts() async {
    try {
      print('Initializing TTS...');
      await flutterTts.setLanguage('fr-FR');
      await flutterTts.setSpeechRate(0.6);
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.1);
      isInitialized.value = true;
      print('TTS initialized successfully');
    } catch (e) {
      print('TTS initialization error: $e');
      isInitialized.value = true; // Set to true anyway to not block the UI
    }
  }

  // FIX 9: Add a safe wrapper method that handles loading state properly
  Future<void> selectNumberSafely(int number) async {
    print(
      'selectNumberSafely called with number: $number, isLoading: ${isLoading.value}',
    );

    // Don't proceed if already loading or number is invalid
    if (isLoading.value || number < minNumber || number > maxNumber) {
      print('Blocked: isLoading=${isLoading.value}, number=$number');
      return;
    }

    // FIX 10: Use a timeout to prevent permanent loading state
    try {
      await selectNumber(number).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          print('selectNumber timed out for number: $number');
          isLoading.value = false;
          throw Exception('Operation timed out');
        },
      );
    } catch (e) {
      print('Error in selectNumberSafely: $e');
      isLoading.value = false; // Ensure loading state is reset
    }
  }

  // Main method to select a number and show animals
  Future<void> selectNumber(int number) async {
    if (number < minNumber || number > maxNumber) {
      print('Invalid number: $number');
      return;
    }

    print(
      'selectNumber called with: $number, current isLoading: ${isLoading.value}',
    );

    try {
      isLoading.value = true;
      print('Set isLoading to true');

      selectedNumber.value = number;
      print('Set selectedNumber to: $number');

      // Get animals for this count
      final animals = AnimalCountingData.getAnimalsForCount(number);
      currentAnimals.value = animals;
      print('Set currentAnimals count: ${animals.length}');

      // Add to completed numbers if not already there
      if (!completedNumbers.contains(number)) {
        completedNumbers.add(number);
        print('Added $number to completedNumbers');
      }

      // Trigger entrance animations
      animationTrigger.value++;
      print('Triggered animation');

      // FIX 11: Make TTS non-blocking and handle errors gracefully
      speakNumberAsync(number);

      // Check if all numbers completed
      if (completedNumbers.length >= maxNumber) {
        print('All numbers completed, celebrating...');
        await _celebrateCompletion();
      }

      print('selectNumber completed successfully');
    } catch (e) {
      print('Error selecting number: $e');
    } finally {
      isLoading.value = false;
      print('Set isLoading to false');
    }
  }

  // FIX 12: Make TTS async and non-blocking
  void speakNumberAsync(int number) async {
    try {
      if (!isInitialized.value) {
        print('TTS not initialized, skipping speak');
        return;
      }

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

      final frenchNumber = frenchNumbers[number];
      if (frenchNumber != null) {
        print('Speaking: $frenchNumber');
        await flutterTts.speak(frenchNumber);
      }
    } catch (e) {
      print('TTS speak error: $e');
      // Don't rethrow - TTS errors shouldn't break the game
    }
  }

  // Original speak method for backward compatibility
  Future<void> speakNumber(int number) async {
    try {
      if (!isInitialized.value) {
        print('TTS not initialized, skipping speak');
        return;
      }

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

      final frenchNumber = frenchNumbers[number];
      if (frenchNumber != null) {
        await flutterTts.speak(frenchNumber);
      }
    } catch (e) {
      print('TTS speak error: $e');
    }
  }

  // Speak animal name when tapped
  Future<void> speakAnimalName(Animal animal) async {
    try {
      if (!isInitialized.value) {
        print('TTS not initialized, skipping animal speak');
        return;
      }

      print('Speaking animal: ${animal.frenchName}');
      await flutterTts.speak(animal.frenchName);
    } catch (e) {
      print('Error speaking animal name: $e');
    }
  }

  // Celebration when all numbers completed
  Future<void> _celebrateCompletion() async {
    try {
      showCelebration.value = true;

      // Speak celebration message
      if (isInitialized.value) {
        await flutterTts.speak('Bravo! Tu as compté jusqu\'à dix!');
      }

      // Hide celebration after 3 seconds
      await Future.delayed(const Duration(seconds: 3));
      showCelebration.value = false;
    } catch (e) {
      print('Error in celebration: $e');
      showCelebration.value = false;
    }
  }

  // Reset the game
  void resetGame() {
    print('Resetting game...');
    selectedNumber.value = 0;
    currentAnimals.clear();
    completedNumbers.clear();
    showCelebration.value = false;
    animationTrigger.value = 0;
    isLoading.value = false; // FIX 13: Ensure loading state is reset
    print('Game reset completed');
  }

  // Get progress percentage
  double getProgress() {
    return completedNumbers.length / maxNumber;
  }

  // Check if number is completed
  bool isNumberCompleted(int number) {
    return completedNumbers.contains(number);
  }

  // Get animals currently displayed
  List<Animal> getCurrentAnimals() {
    return currentAnimals.toList();
  }

  // Check if game is completed
  bool isGameCompleted() {
    return completedNumbers.length >= maxNumber;
  }

  // Get next suggested number
  int? getNextNumber() {
    for (int i = minNumber; i <= maxNumber; i++) {
      if (!completedNumbers.contains(i)) {
        return i;
      }
    }
    return null;
  }

  // Replay current number
  Future<void> replayCurrentNumber() async {
    if (selectedNumber.value > 0) {
      print('Replaying number: ${selectedNumber.value}');
      speakNumberAsync(selectedNumber.value);
    }
  }

  // FIX 14: Add method to force reset loading state (for emergency situations)
  void forceResetLoading() {
    print('Force resetting loading state');
    isLoading.value = false;
  }

  // FIX 15: Add debug method to check controller state
  void debugState() {
    print('=== Controller Debug State ===');
    print('selectedNumber: ${selectedNumber.value}');
    print('isLoading: ${isLoading.value}');
    print('isInitialized: ${isInitialized.value}');
    print('currentAnimals: ${currentAnimals.length}');
    print('completedNumbers: ${completedNumbers.toList()}');
    print('showCelebration: ${showCelebration.value}');
    print('==============================');
  }
}
