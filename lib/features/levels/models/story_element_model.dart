import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/views/activities/dialogue_line_view.dart';

/// Base class for a step in a story.
abstract class StoryElement {
  Widget build(BuildContext context);
}

/// A passive line of dialogue.
class DialogueLine extends StoryElement {
  final String characterName;
  final String avatarAsset;
  final String text;

  DialogueLine({
    required this.characterName,
    required this.avatarAsset,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return DialogueLineView(dialogue: this);
  }
}

/// An interactive question that reuses your existing Activity models.
class StoryQuestion extends StoryElement {
  final Activity activity;

  StoryQuestion({required this.activity});

  @override
  Widget build(BuildContext context) {
    // Your existing activity models already know how to build their views.
    return activity.build(context);
  }
}
