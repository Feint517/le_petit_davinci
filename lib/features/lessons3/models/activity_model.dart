import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons3/views/drawing_activity_view.dart';
import 'package:le_petit_davinci/features/lessons3/views/video_activity_view.dart';

//* Base class for any lesson activity.
abstract class Activity {
  //? A reactive boolean to track if the activity has been completed.
  //? It starts as false.
  final RxBool isCompleted = false.obs;

  Widget build(BuildContext context);
}

class VideoActivity extends Activity {
  final String videoId;
  VideoActivity({required this.videoId});

  @override
  Widget build(BuildContext context) {
    //? The state change is now handled by the view.
    return VideoActivityView(activity: this);
  }
}

class DrawingActivity extends Activity {
  final String prompt;
  final String? backgroundImage;
  DrawingActivity({required this.prompt, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return DrawingActivityView(activity: this);
  }
}

class Lesson {
  final String lessonId;
  final String title;
  final String introduction;
  final List<Activity> activities;

  Lesson({
    required this.lessonId,
    required this.title,
    required this.introduction,
    required this.activities,
  });
}
