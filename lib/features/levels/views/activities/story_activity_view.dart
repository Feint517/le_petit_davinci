import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/features/levels/models/activities/story_activity.dart';
import 'package:le_petit_davinci/features/levels/models/story_element_model.dart';

class StoryActivityView extends StatelessWidget {
  const StoryActivityView({super.key, required this.activity});

  final StoryActivity activity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(
            () => ListView.builder(
              controller: activity.scrollController,
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: activity.visibleElements.length,
              itemBuilder: (context, index) {
                // The last item might be interactive, others are static.
                final isLastItem = index == activity.visibleElements.length - 1;
                final element = activity.visibleElements[index];

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
          final isQuestion = activity.currentElement is StoryQuestion;
          return CustomButton(
            label: isQuestion ? 'Check' : 'Continue',
            disabled: !activity.isInternalStepReady.value,
            onPressed: () {
              if (isQuestion) {
                final result =
                    (activity.currentElement as StoryQuestion).activity
                        .checkAnswer();
                // TODO: Implement feedback sheet logic.
                if (result.isCorrect) {
                  activity.advanceToNextElement();
                }
              } else {
                activity.advanceToNextElement();
              }
            },
          );
        }),
        Gap(DeviceUtils.getBottomNavigationBarHeight()),
      ],
    );
  }
}
