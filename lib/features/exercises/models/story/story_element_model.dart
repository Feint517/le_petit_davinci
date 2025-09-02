import 'package:flutter/material.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/views/story/dialogue_line_view.dart';

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

/// An interactive question that reuses your existing Exercise models.
class StoryQuestion extends StoryElement {
  final Exercise exercise;

  StoryQuestion({required this.exercise});

  @override
  Widget build(BuildContext context) {
    // Your existing exercise models already know how to build their views.
    return exercise.build(context);
  }
}
