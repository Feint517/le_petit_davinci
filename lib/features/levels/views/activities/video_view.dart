import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activities/activities.dart';

class VideoActivityView extends StatelessWidget {
  const VideoActivityView({super.key, required this.activity});

  final VideoActivity activity;

  @override
  Widget build(BuildContext context) {
    // Start the video immediately when the view is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      activity.startVideo();
    });

    return const Center(child: CircularProgressIndicator());
  }
}
