import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/levels/models/answer_result_model.dart';
import 'package:le_petit_davinci/features/levels/models/activity_model.dart';
import 'package:le_petit_davinci/features/levels/models/story_element_model.dart';
import 'package:le_petit_davinci/features/levels/views/activities/story_activity_view.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';
import 'package:le_petit_davinci/features/levels/models/activity_navigation_interface.dart';

/// Represents a complete, multi-step story as a single Activity.
class StoryActivity extends Activity
    with MascotIntroductionMixin
    implements ActivityNavigationInterface {
  final String title;
  final List<StoryElement> elements;

  // Override to indicate this activity requires validation
  @override
  bool get requiresValidation => true;

  // Internal state management for the story's progress.
  late final ScrollController scrollController;
  final RxList<StoryElement> visibleElements = <StoryElement>[].obs;
  final RxInt currentElementIndex = 0.obs;
  final RxBool isInternalStepReady = false.obs;
  StreamSubscription? _readinessSubscription;

  // This will signal to the main LevelController when the whole story is done.
  final RxBool _isStoryCompleted = false.obs;

  StoryActivity({required this.title, required this.elements}) {
    scrollController = ScrollController();
    // Start by showing the first element.
    visibleElements.add(elements.first);
    _setupListenerForCurrentElement();

    // Mascot initialization is handled in the view's build method
  }

  StoryElement get currentElement => elements[currentElementIndex.value];

  void _setupListenerForCurrentElement() {
    _readinessSubscription?.cancel();
    final element = currentElement;

    if (element is DialogueLine) {
      isInternalStepReady.value = true;
      // TODO: Add TTS logic here to speak the line.
    } else if (element is StoryQuestion) {
      final activity = element.activity;
      isInternalStepReady.value = activity.isAnswerReady;
      _readinessSubscription = activity.isAnswerReadyStream.listen((isReady) {
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

      // Animate scroll to the bottom only if the controller is attached.
      Timer(const Duration(milliseconds: 100), () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } else {
      _isStoryCompleted.value = true;
    }
  }

  // --- Implementation of the Activity abstract class ---

  @override
  Widget build(BuildContext context) {
    // This activity builds its own special view.
    return StoryActivityView(activity: this);
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
    if (scrollController.hasClients) {
      scrollController.jumpTo(0);
    }
    for (var element in elements) {
      if (element is StoryQuestion) {
        element.activity.reset();
      }
    }
    _setupListenerForCurrentElement();
  }

  // --- ActivityNavigationInterface Implementation ---

  @override
  bool get useCustomNavigation => true; // Story activity has its own navigation

  @override
  Widget? get customNavigationWidget => null; // Navigation is handled in the view

  @override
  ActivityButtonConfig? get buttonConfig => null; // Use default button config

  @override
  void onNavigationTriggered() {
    // Handle custom navigation logic if needed
  }

  @override
  void dispose() {
    _readinessSubscription?.cancel();
    scrollController.dispose();
    disposeMascot(); // Use mixin method
    super.dispose();
  }
}
