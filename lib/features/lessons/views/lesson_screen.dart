import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/exercises/widgets/progress_bar.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_model.dart';
import 'package:le_petit_davinci/features/lessons/widgets/lesson_intro_widget.dart';
import 'package:le_petit_davinci/features/lessons/widgets/lesson_video_widget.dart';
import 'package:le_petit_davinci/features/lessons/widgets/lesson_activities_widget.dart';
import 'package:le_petit_davinci/features/lessons/widgets/lesson_completion_widget.dart';

class LessonScreen extends GetView<LessonController> {
  final LessonModel lesson;

  const LessonScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    Get.put(LessonController(lesson: lesson));
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        controller.handleBackButton();
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundLight,
        appBar: ProfileHeader(
          type: ProfileHeaderType.compact,
          onBackButtonPressed: () => controller.handleBackButton(),
        ),
        body: SafeArea(
          top: false,
          right: false,
          left: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                //* Progress bar
                const ProgressBar(progress: 0.52),

                //* Main content area
                Expanded(
                  child: Obx(
                    () => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: switch (controller.currentPhase.value) {
                        LessonPhase.introduction => LessonIntroWidget(
                          lesson: lesson,
                        ),
                        LessonPhase.video => LessonVideoWidget(lesson: lesson),
                        LessonPhase.activities =>
                          const LessonActivitiesWidget(),
                        LessonPhase.completion => LessonCompletionWidget(
                          lesson: lesson,
                        ),
                      },
                    ),
                  ),
                ),

                //* Navigation controls
                Obx(
                  () => Row(
                    children: [
                      //* Previous button (if applicable)
                      if (_canGoPrevious())
                        Expanded(
                          child: CustomButton(
                            onPressed: controller.goToPrevious,
                            label:
                                lesson.language == LessonLanguage.french
                                    ? 'Précédent'
                                    : 'Previous',
                            variant: ButtonVariant.ghost,
                          ),
                        ),

                      if (_canGoPrevious()) Gap(16.w),

                      //* Next/Complete button
                      Expanded(
                        flex: _canGoPrevious() ? 1 : 2,
                        child: CustomButton(
                          onPressed:
                              _canProceed() ? controller.moveToNextPhase : null,
                          label: switch (controller.currentPhase.value) {
                            LessonPhase.introduction =>
                              lesson.language == LessonLanguage.french
                                  ? 'Commencer'
                                  : 'Start',
                            LessonPhase.video =>
                              controller.isVideoCompleted.value
                                  ? lesson.language == LessonLanguage.french
                                      ? 'Activités'
                                      : 'Activities'
                                  : lesson.language == LessonLanguage.french
                                  ? 'Terminer la vidéo'
                                  : 'Complete Video',
                            LessonPhase.activities =>
                              controller.isActivityCompleted.value
                                  ? (controller.currentActivityIndex.value <
                                          (controller
                                                      .currentLesson
                                                      .value
                                                      ?.activities
                                                      .length ??
                                                  0) -
                                              1)
                                      ? lesson.language == LessonLanguage.french
                                          ? 'Activité suivante'
                                          : 'Next Activity'
                                      : lesson.language == LessonLanguage.french
                                      ? 'Terminer la leçon'
                                      : 'Complete Lesson'
                                  : lesson.language == LessonLanguage.french
                                  ? 'Terminer l\'activité'
                                  : 'Complete Activity',
                            LessonPhase.completion =>
                              lesson.language == LessonLanguage.french
                                  ? 'Terminer'
                                  : 'Finish',
                          },
                          variant: ButtonVariant.primary,
                          isLoading: controller.isLoading.value,
                          disabled: !_canProceed(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _canGoPrevious() {
    switch (controller.currentPhase.value) {
      case LessonPhase.introduction:
        return false;
      case LessonPhase.video:
        return true;
      case LessonPhase.activities:
        return controller.currentActivityIndex.value > 0 ||
            controller.isVideoCompleted.value;
      case LessonPhase.completion:
        return true;
    }
  }

  bool _canProceed() {
    return controller.canProceedToNext;
  }
}
