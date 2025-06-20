// ignore_for_file: avoid_print

import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/data/sentence_translation.dart';
import 'package:le_petit_davinci/features/lessons/french/models/english_to_french.dart';

class ConstructionLessonController extends GetxController {
  // Observable variables
  final day = 1.obs; // Default to day 1
  final currentIndex = 0.obs;
  final showFrench = true.obs;
  
  // Non-reactive variables
  late List<EnglishToFrench> sentences;
  final FlutterTts flutterTts = FlutterTts();
  
  @override
  void onInit() {
    super.onInit(); 
    loadSentences();
    initTts();
  }
  
  @override
  void onClose() {
    flutterTts.stop();
    super.onClose();
  }
  
  void loadSentences() {
    sentences = SentencesData.getSentencesByDay(day.value);
  }
  
  Future<void> initTts() async {
    try {
      await flutterTts.setLanguage('fr-FR');  // Set language to French
      await flutterTts.setSpeechRate(0.5);    // Slightly slower speed for learning
      await flutterTts.setVolume(1.0);        // Full volume
      await flutterTts.setPitch(1.0);         // Normal pitch
    } catch (e) {
      print('TTS initialization error: $e');
    }
  }

  void nextSentence() {
    if (currentIndex.value < sentences.length - 1) {
      currentIndex.value++;
    }
  }
  
  void previousSentence() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }
  
  void toggleFrench() {
    showFrench.value = !showFrench.value;
  }
  
  Future<void> speakFrenchSentence() async {
    try {
      final frenchText = sentences[currentIndex.value].frenchSentence;
      await flutterTts.speak(frenchText);
    } catch (e) {
      print('TTS speak error: $e');
    }
  }
  
  String getCurrentEnglishSentence() {
    return sentences[currentIndex.value].englishSentence;
  }
  
  String getCurrentFrenchSentence() {
    return sentences[currentIndex.value].frenchSentence;
  }
  
  int getTotalSentences() {
    return sentences.length;
  }
  
  bool isLastSentence() {
    return currentIndex.value >= sentences.length - 1;
  }
}