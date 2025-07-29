import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/lessons2/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons2/models/lesson_model.dart';
import 'package:le_petit_davinci/features/lessons2/widgets/lesson_activities.dart';
import 'package:le_petit_davinci/features/lessons2/widgets/lesson_completion.dart';
import 'package:le_petit_davinci/features/lessons2/widgets/lesson_video.dart';
import 'package:le_petit_davinci/features/lessons2/widgets/lessson_intro.dart';

class LessonScreen extends GetView<LessonController2> {
  const LessonScreen({super.key, required this.lesson});

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    Get.put(LessonController2());
    controller.setLesson(lesson);
    return Scaffold(
      appBar: ProfileHeader(type: ProfileHeaderType.compact),
      body: SafeArea(
        top: false,
        right: false,
        left: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => switch (controller.currentPhase.value) {
                      LessonPhase.introduction => LessonIntroWidget(
                        lesson: lesson,
                      ),
                      LessonPhase.video => LessonVideoWidget(lesson: lesson),
                      LessonPhase.activities => LessonActivitiesWidget(
                        activities: lesson.activities,
                      ),
                      LessonPhase.completion => LessonCompletionWidget(
                        lesson: lesson,
                      ),
                    },
                  ),
                ),
              ),

              Obx(() {
                bool showButton = controller.shouldShowButton.value;
                if (!showButton) return const SizedBox.shrink();
                return SafeArea(
                  top: false,
                  child: CustomButton(
                    label: switch (controller.currentPhase.value) {
                      LessonPhase.introduction => "Next",
                      LessonPhase.video => "Finished Video",
                      LessonPhase.activities => "Complete Activity",
                      LessonPhase.completion => "Exit",
                    },
                    onPressed:
                        controller.currentPhase.value ==
                                LessonPhase.introduction
                            ? controller.moveToNextPhase
                            : controller.canProceedToNext
                            ? controller.moveToNextPhase
                            : null,
                    disabled:
                        controller.currentPhase.value !=
                            LessonPhase.introduction &&
                        !controller.canProceedToNext,
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
