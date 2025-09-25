import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/widgets/full_screen_video_player.dart';
import 'package:le_petit_davinci/features/levels/views/activities/video_view.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

class VideoActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  VideoActivity({required this.videoId}) {
    // Initialize mascot with standardized approach
    initializeMascot([
      'Super! Prêt à voir la vidéo?',
    ], completionDelay: const Duration(seconds: 2));

    // When the intro is complete, launch the full-screen player.
    ever(isIntroCompleted, (bool isReady) {
      if (isReady) {
        Get.to(
          () => FullScreenVideoPlayer(
            videoId: videoId,
            onVideoCompleted: () {
              // When the video finishes, navigate back and mark the activity as complete.
              Get.back();
              markVideoAsCompleted();
            },
          ),
        );
      }
    });
  }

  final String videoId;

  /// The video player will call this when the video ends.
  /// This triggers the main `isCompleted` flag, advancing the lesson.
  void markVideoAsCompleted() {
    markCompleted(); // Use the new unified helper method
  }

  @override
  Widget build(BuildContext context) {
    //? The state change is now handled by the view.
    return VideoActivityView(activity: this);
  }

  // --- ActivityNavigationInterface Implementation ---

  @override
  bool get useCustomNavigation => false; // Use standard navigation

  @override
  Widget? get customNavigationWidget => null; // Use standard navigation

  @override
  ActivityButtonConfig? get buttonConfig =>
      ActivityButtonConfig(continueButtonText: 'Watch Video');

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
