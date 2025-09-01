import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/exercises/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/exercises/models/exercise_model.dart';
import 'package:le_petit_davinci/features/exercises/models/story/story_element_model.dart';
import 'package:le_petit_davinci/features/exercises/views/story_exercise_view.dart';

/// Represents a complete, multi-step story as a single Exercise.
class StoryExercise extends Exercise {
  final String title;
  final List<StoryElement> elements;

  // Internal state management for the story's progress.
  late final ScrollController scrollController;
  final RxList<StoryElement> visibleElements = <StoryElement>[].obs;
  final RxInt currentElementIndex = 0.obs;
  final RxBool isInternalStepReady = false.obs;
  StreamSubscription? _readinessSubscription;

  // This will signal to the main ExercisesController when the whole story is done.
  final RxBool _isStoryCompleted = false.obs;

  StoryExercise({required this.title, required this.elements}) {
    scrollController = ScrollController();
    // Start by showing the first element.
    visibleElements.add(elements.first);
    _setupListenerForCurrentElement();
  }

  StoryElement get currentElement => elements[currentElementIndex.value];

  void _setupListenerForCurrentElement() {
    _readinessSubscription?.cancel();
    final element = currentElement;

    if (element is DialogueLine) {
      isInternalStepReady.value = true;
      // TODO: Add TTS logic here to speak the line.
    } else if (element is StoryQuestion) {
      final exercise = element.exercise;
      isInternalStepReady.value = exercise.isAnswerReady;
      _readinessSubscription = exercise.isAnswerReadyStream.listen((isReady) {
        isInternalStepReady.value = isReady;
      });
    }
  }

  void advanceToNextElement() {
    if (currentElementIndex.value < elements.length - 1) {
      currentElementIndex.value++;
      // Add the next element to the visible list.
      visibleElements.add(currentElement);
      _setupListenerForCurrentElement();

      // Animate scroll to the bottom.
      Timer(const Duration(milliseconds: 100), () {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    } else {
      _isStoryCompleted.value = true;
    }
  }

  // --- Implementation of the Exercise abstract class ---

  @override
  Widget build(BuildContext context) {
    // This exercise builds its own special view.
    return StoryExerciseView(exercise: this);
  }

  /// For a story, the main "Check" button is irrelevant.
  /// The story's view will have its own button.
  @override
  bool get isAnswerReady => false;

  /// The story's completion is handled internally. We use the `_isStoryCompleted`
  /// flag to signal completion to the main controller.
  @override
  Stream<bool> get isAnswerReadyStream => _isStoryCompleted.stream;

  /// This method will be called by the main controller when it detects
  /// `isAnswerReadyStream` has emitted `true`.
  @override
  AnswerResult checkAnswer() {
    // The story is already complete, so we just return a success result.
    return AnswerResult(isCorrect: true, correctAnswerText: 'Story Complete!');
  }

  @override
  void reset() {
    currentElementIndex.value = 0;
    visibleElements.assignAll([elements.first]);
    scrollController.jumpTo(0);
    for (var element in elements) {
      if (element is StoryQuestion) {
        element.exercise.reset();
      }
    }
    _setupListenerForCurrentElement();
  }
}