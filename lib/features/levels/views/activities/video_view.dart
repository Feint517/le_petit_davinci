import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activities/activities.dart';

class VideoActivityView extends StatelessWidget {
  const VideoActivityView({super.key, required this.activity});

  final VideoActivity activity;

  @override
  Widget build(BuildContext context) {
    // Initialize mascot when the view is built (only if not already initialized)
    if (!activity.isInitialized.value) {
      final messages = ['Super! Prêt à voir la vidéo?', 'Regardons ensemble!'];

      // Use a post-frame callback to ensure proper timing
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          activity.initializeMascot(messages);
        } catch (e) {
          debugPrint('Error initializing mascot in VideoView: $e');
        }
      });
    }

    // Start the video immediately when the view is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      activity.startVideo();
    });

    return const Center(child: CircularProgressIndicator());
  }
}
