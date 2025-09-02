import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/features/exercises/models/story/story_element_model.dart';
import 'package:le_petit_davinci/features/exercises/models/story_exercise_model.dart';

class StoryExerciseView extends StatelessWidget {
  const StoryExerciseView({super.key, required this.exercise});

  final StoryExercise exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => ListView.builder(
              controller: exercise.scrollController,
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: exercise.visibleElements.length,
              itemBuilder: (context, index) {
                // The last item might be interactive, others are static.
                final isLastItem = index == exercise.visibleElements.length - 1;
                final element = exercise.visibleElements[index];

                // For questions, we only want the *current* one to be interactive.
                if (element is StoryQuestion && !isLastItem) {
                  // This could be a static "summary" view of a completed question.
                  // For now, we just build the standard view, which will be non-interactive
                  // because its state is already set.
                  return element.build(context);
                }
                return element.build(context);
              },
            ),
          ),
        ),
        // This is the story's OWN bottom button.
        Obx(() {
          final isQuestion = exercise.currentElement is StoryQuestion;
          return CustomButton(
            label: isQuestion ? 'Check' : 'Continue',
            disabled: !exercise.isInternalStepReady.value,
            onPressed: () {
              if (isQuestion) {
                final result =
                    (exercise.currentElement as StoryQuestion).exercise
                        .checkAnswer();
                // TODO: Implement feedback sheet logic.
                if (result.isCorrect) {
                  exercise.advanceToNextElement();
                }
              } else {
                exercise.advanceToNextElement();
              }
            },
          );
        }),
        Gap(DeviceUtils.getBottomNavigationBarHeight()),
      ],
    );
  }
}
