import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/lessons/models/activity_model.dart';
import 'package:le_petit_davinci/features/lessons/models/audio_pair_model.dart';
import 'package:le_petit_davinci/features/lessons/views/audio_matching_activity_view.dart';



//* The model for the audio-word matching activity.
class AudioMatchingActivity extends Activity {
  AudioMatchingActivity({required this.prompt, required this.pairs});

  final String prompt;
  final List<AudioWordPair> pairs;

  @override
  Widget build(BuildContext context) {
    return AudioMatchingActivityView(activity: this);
  }
}