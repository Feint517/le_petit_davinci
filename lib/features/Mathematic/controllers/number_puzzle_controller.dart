// lib/features/Mathematic/controllers/number_puzzle_controller.dart

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/Mathematic/models/number_puzzle_model.dart';

class NumberPuzzleController extends GetxController {
  // Observable variables
  final currentLevel = 1.obs;
  final currentSequenceIndex = 0.obs;
  final isLoading = false.obs;
  final showCelebration = false.obs;
  final showLevelComplete = false.obs;
  
  // Drag and drop state
  final availableNumbers = <int>[].obs;
  final droppedNumbers = <int, int?>{}.obs; // position -> number
  final draggedNumber = Rxn<int>();
  
  // Current sequence data
  final currentSequences = <NumberSequence>[].obs;
  final completedLevels = <int>[].obs;

  // Non-reactive variables
  final FlutterTts flutterTts = FlutterTts();
  final int maxLevel = NumberPuzzleData.totalLevels;

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
      // Get sequences for current level
      currentSequences.value = NumberPuzzleData.getSequencesForLevel(currentLevel.value);
      currentSequenceIndex.value = 0;
      
      // Get all available numbers for this level (shuffled)
      availableNumbers.value = NumberPuzzleData.getAllMissingNumbersForLevel(currentLevel.value);
      
      // Reset dropped numbers
      droppedNumbers.clear();
      
      // Initialize drop positions for current sequence
      _initializeCurrentSequence();
      
    } catch (e) {
      print('Error initializing level: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Initialize current sequence positions
  void _initializeCurrentSequence() {
    final sequence = getCurrentSequence();
    if (sequence == null) return;
    
    // Clear previous drops for this sequence
    droppedNumbers.clear();
    
    // Initialize empty drop positions
    for (int i = 0; i < sequence.sequence.length; i++) {
      if (sequence.sequence[i] == null) {
        droppedNumbers[i] = null;
      }
    }
  }

  // Get current sequence
  NumberSequence? getCurrentSequence() {
    if (currentSequenceIndex.value >= currentSequences.length) return null;
    return currentSequences[currentSequenceIndex.value];
  }

  // Handle number drag start
  void onDragStart(int number) {
    draggedNumber.value = number;
  }

  // Handle number drop
  Future<void> onNumberDrop(int position, int number) async {
    final sequence = getCurrentSequence();
    if (sequence == null) return;

    try {
      // Check if this is the correct number for this position
      final correctNumber = sequence.getCorrectNumberAt(position);
      
      if (correctNumber == number) {
        // Correct drop
        droppedNumbers[position] = number;
        availableNumbers.remove(number);
        
        // Speak the number
        await speakNumber(number);
        
        // Check if sequence is complete
        if (_isCurrentSequenceComplete()) {
          await _handleSequenceComplete();
        }
        
      } else {
        // Incorrect drop - provide feedback
        await _handleIncorrectDrop(number);
      }
      
    } catch (e) {
      print('Error handling drop: $e');
    } finally {
      draggedNumber.value = null;
    }
  }

  // Check if current sequence is complete
  bool _isCurrentSequenceComplete() {
    final sequence = getCurrentSequence();
    if (sequence == null) return false;
    
    for (int i = 0; i < sequence.sequence.length; i++) {
      if (sequence.sequence[i] == null && droppedNumbers[i] == null) {
        return false;
      }
    }
    return true;
  }

  // Handle sequence completion
  Future<void> _handleSequenceComplete() async {
    await flutterTts.speak('Parfait!');
    
    // Move to next sequence
    if (currentSequenceIndex.value < currentSequences.length - 1) {
      // More sequences in this level
      currentSequenceIndex.value++;
      _initializeCurrentSequence();
    } else {
      // Level complete
      await _handleLevelComplete();
    }
  }

  // Handle level completion
  Future<void> _handleLevelComplete() async {
    completedLevels.add(currentLevel.value);
    showLevelComplete.value = true;
    
    await flutterTts.speak('Niveau terminé! Bravo!');
    
    // Hide level complete after 2 seconds
    await Future.delayed(const Duration(seconds: 2));
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
    await flutterTts.speak('Félicitations! Tu as terminé tous les niveaux!');
    
    // Hide celebration after 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    showCelebration.value = false;
  }

  // Handle incorrect drop
  Future<void> _handleIncorrectDrop(int number) async {
    // Speak encouraging message
    final messages = [
      'Essaie encore!',
      'Pas tout à fait!', 
      'Continue d\'essayer!'
    ];
    final message = messages[DateTime.now().millisecond % messages.length];
    await flutterTts.speak(message);
  }

  // Speak number in French
  Future<void> speakNumber(int number) async {
    try {
      final frenchNumbers = {
        1: 'un', 2: 'deux', 3: 'trois', 4: 'quatre', 5: 'cinq',
        6: 'six', 7: 'sept', 8: 'huit', 9: 'neuf', 10: 'dix',
        11: 'onze', 12: 'douze', 13: 'treize', 14: 'quatorze', 15: 'quinze',
        16: 'seize', 17: 'dix-sept', 18: 'dix-huit', 19: 'dix-neuf', 20: 'vingt',
        25: 'vingt-cinq',
      };
      
      final frenchNumber = frenchNumbers[number] ?? number.toString();
      await flutterTts.speak(frenchNumber);
    } catch (e) {
      print('TTS speak error: $e');
    }
  }

  // Check if position can accept drop
  bool canDrop(int position) {
    final sequence = getCurrentSequence();
    if (sequence == null) return false;
    
    // Can only drop on null positions
    return position < sequence.sequence.length && 
           sequence.sequence[position] == null &&
           droppedNumbers[position] == null;
  }

  // Get number at position (either from sequence or dropped)
  int? getNumberAtPosition(int position) {
    final sequence = getCurrentSequence();
    if (sequence == null) return null;
    
    // Return dropped number if exists, otherwise original sequence number
    return droppedNumbers[position] ?? sequence.sequence[position];
  }

  // Reset current level
  void resetCurrentLevel() {
    currentSequenceIndex.value = 0;
    _initializeLevel();
  }

  // Reset entire game
  void resetGame() {
    currentLevel.value = 1;
    currentSequenceIndex.value = 0;
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
    switch (currentLevel.value) {
      case 1:
        return 'Séquences simples';
      case 2:
        return 'Compter par bonds de 2';
      case 3:
        return 'Compter à l\'envers';
      default:
        return 'Niveau ${currentLevel.value}';
    }
  }

  // Get progress percentage for current level
  double getCurrentLevelProgress() {
    if (currentSequences.isEmpty) return 0.0;
    return (currentSequenceIndex.value + 1) / currentSequences.length;
  }

  // Get overall game progress
  double getOverallProgress() {
    return currentLevel.value / maxLevel;
  }

  // Check if number is available for dragging
  bool isNumberAvailable(int number) {
    return availableNumbers.contains(number);
  }

  // Get hint for current sequence
  String getCurrentSequenceHint() {
    final sequence = getCurrentSequence();
    if (sequence == null) return '';
    return sequence.description;
  }

  // Provide hint by highlighting next position
  int? getNextEmptyPosition() {
    final sequence = getCurrentSequence();
    if (sequence == null) return null;
    
    for (int i = 0; i < sequence.sequence.length; i++) {
      if (sequence.sequence[i] == null && droppedNumbers[i] == null) {
        return i;
      }
    }
    return null;
  }
}