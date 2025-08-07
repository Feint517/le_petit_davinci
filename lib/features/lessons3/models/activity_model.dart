import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/lessons3/views/audio_matching_activity_view.dart';
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
  final String? templateImagePath;
  final List<String>? suggestedColors;
  DrawingActivity({
    required this.prompt,
    this.templateImagePath,
    this.suggestedColors,
  });

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

//* A helper class to hold a single audio-word pair.
class AudioWordPair {
  final String audioAssetPath;
  final String word;

  AudioWordPair({required this.audioAssetPath, required this.word});
}

//* The model for the audio-word matching activity.
class AudioMatchingActivity extends Activity {
  final String prompt;
  final List<AudioWordPair> pairs;

  AudioMatchingActivity({required this.prompt, required this.pairs});

  @override
  Widget build(BuildContext context) {
    return AudioMatchingActivityView(activity: this);
  }
}
