import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/levels/views/activities/reorder_words_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class ReorderWordsActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  ReorderWordsActivity({required this.words, required this.correctOrder}) {
    // Initialize mascot with standardized approach
    initializeMascot([
      'Let\'s reorder the words!',
      'Put the words in the correct order.',
    ], completionDelay: const Duration(seconds: 2));
  }

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  final List<String> words;
  final List<int> correctOrder;

  // State for this exercise
  final RxList<int> selectedOrder = <int>[].obs;

  @override
  Widget build(BuildContext context) {
    return ReorderWordsView(activity: this);
  }

  @override
  AnswerResult checkAnswer() {
    final bool isCorrect = ListEquality().equals(
      selectedOrder.toList(),
      correctOrder,
    );
    return AnswerResult(
      isCorrect: isCorrect,
      // correctAnswerText: correctOrder.join(' '),
      correctAnswerText: correctOrder.map((i) => words[i]).join(' '),
    );
  }

  @override
  bool get isAnswerReady => selectedOrder.length == words.length;

  @override
  Stream<bool> get isAnswerReadyStream =>
      selectedOrder.stream.map((list) => list.length == words.length);

  @override
  void reset() {
    selectedOrder.clear();
    resetMascotIntroduction(); // Reset mascot state
  }

  // --- ActivityNavigationInterface Implementation ---

  @override
  bool get useCustomNavigation => false; // Use standard navigation

  @override
  Widget? get customNavigationWidget => null; // Use standard navigation

  @override
  ActivityButtonConfig? get buttonConfig => null; // Use default button config

  @override
  void onNavigationTriggered() {
    // Handle custom navigation logic if needed
  }

  @override
  void dispose() {
    disposeMascot(); // Use mixin method
    super.dispose();
  }
}
