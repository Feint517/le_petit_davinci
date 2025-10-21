import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/views/activities/audio_matching_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/models/audio_pair_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

//* The model for the audio-word matching activity.
class AudioMatchingActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  AudioMatchingActivity({required this.prompt, required this.pairs}) {
    // Mascot initialization is handled in the view's build method
  }

  final String prompt;
  final List<AudioWordPair> pairs;

  /// Track matched pairs for completion detection
  final RxList<String> matchedWords = <String>[].obs;

  /// Whether all pairs have been matched
  bool get isAllPairsMatched => matchedWords.length == pairs.length;

  /// Add a matched word to the list
  void addMatchedWord(String word) {
    if (!matchedWords.contains(word)) {
      matchedWords.add(word);

      // Check if all pairs are matched
      if (isAllPairsMatched) {
        // Mark activity as completed
        isCompleted.value = true;
      }
    }
  }

  /// Reset the activity state
  @override
  void reset() {
    super.reset();
    matchedWords.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AudioMatchingActivityView(activity: this);
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
    disposeMascotWithFeedback(); // Use enhanced dispose method
    super.dispose();
  }
}
