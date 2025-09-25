import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/activities/activities.dart';
import 'package:le_petit_davinci/features/levels/widgets/activity_intro_wrapper.dart';

class VideoActivityView extends StatelessWidget {
  const VideoActivityView({super.key, required this.activity});

  final VideoActivity activity;

  @override
  Widget build(BuildContext context) {
    return ActivityIntroWrapper(
      activity: const Center(child: CircularProgressIndicator()),
      mascotMixin: activity,
      startButtonText: 'Watch Video',
      onStartPressed: () {
        activity.isIntroCompleted.value = true;
      },
    );
  }
}
