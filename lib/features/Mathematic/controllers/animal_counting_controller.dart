// lib/features/Mathematic/controllers/animal_counting_controller.dart

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
  final animationTrigger = 0.obs; // Used to trigger animations

  // Non-reactive variables
  final FlutterTts flutterTts = FlutterTts();
  final int maxNumber = 10;
  final int minNumber = 1;

  @override
  void onInit() {
    super.onInit();
    initTts();
  }

  @override
  void onClose() {
    flutterTts.stop();
    super.onClose();
  }

  Future<void> initTts() async {
    try {
      await flutterTts.setLanguage('fr-FR'); // French language
      await flutterTts.setSpeechRate(0.6); // Slower for kids
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.1); // Slightly higher pitch for kids
    } catch (e) {
      print('TTS initialization error: $e');
    }
  }

  // Main method to select a number and show animals
  Future<void> selectNumber(int number) async {
    if (number < minNumber || number > maxNumber) return;
    
    try {
      isLoading.value = true;
      selectedNumber.value = number;
      
      // Get animals for this count
      currentAnimals.value = AnimalCountingData.getAnimalsForCount(number);
      
      // Add to completed numbers if not already there
      if (!completedNumbers.contains(number)) {
        completedNumbers.add(number);
      }
      
      // Trigger entrance animations
      animationTrigger.value++;
      
      // Speak the number in French
      await speakNumber(number);
      
      // Check if all numbers completed
      if (completedNumbers.length >= maxNumber) {
        await _celebrateCompletion();
      }
      
    } catch (e) {
      print('Error selecting number: $e');
    } finally {
      isLoading.value = false;
    }
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
      await flutterTts.speak(animal.frenchName);
    } catch (e) {
      print('Error speaking animal name: $e');
    }
  }

  // Celebration when all numbers completed
  Future<void> _celebrateCompletion() async {
    showCelebration.value = true;
    
    // Speak celebration message
    await flutterTts.speak('Bravo! Tu as compté jusqu\'à dix!');
    
    // Hide celebration after 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    showCelebration.value = false;
  }

  // Reset the game
  void resetGame() {
    selectedNumber.value = 0;
    currentAnimals.clear();
    completedNumbers.clear();
    showCelebration.value = false;
    animationTrigger.value = 0;
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
      await speakNumber(selectedNumber.value);
    }
  }
}