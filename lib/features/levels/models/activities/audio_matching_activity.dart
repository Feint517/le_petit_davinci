import 'package:flutter/material.dart';
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
    // Initialize mascot with activity-specific introduction messages
    initializeMascot([
      'Let\'s match audio with words!',
      'Listen carefully and find the matching word.',
      'Use your ears to help you!',
    ]);
  }

  final String prompt;
  final List<AudioWordPair> pairs;

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
