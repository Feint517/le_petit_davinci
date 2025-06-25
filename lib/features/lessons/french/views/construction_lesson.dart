// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/container/curved_header_container.dart';
import 'package:le_petit_davinci/features/lessons/english/widget/practice_header.dart';
import 'package:le_petit_davinci/features/lessons/french/controllers/construction_lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/french/views/construction_exercice.dart';

class ConstructionLesson extends StatelessWidget {
  const ConstructionLesson({super.key, required this.day});

  final int day;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConstructionLessonController());
    controller.day.value = day;
    controller.loadSentences();
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            CustomCurvedHeaderContainer(
              height: 300,
              child: PracticeHeader(
                showBadge: false,
                lessonName:
                    'Jour ${controller.day.value} - Apprendre les phrases',
                badgeVariant: BadgeVariant.french,
                badgeType: LessonBadgeType.phrasesBuilder,
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        controller.getCurrentEnglishSentence(),
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(30),
                    Obx(
                      () => AnimatedOpacity(
                        opacity: controller.showFrench.value ? 1.0 : 0.0,
                        duration: Duration(milliseconds: 300),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                controller.getCurrentFrenchSentence(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .apply(color: AppColors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.volume_up,
                                color: AppColors.black,
                              ),
                              onPressed: controller.speakFrenchSentence,
                              tooltip: 'Listen to pronunciation',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(20),
                    Obx(
                      () => Text(
                        '${controller.currentIndex.value + 1}/${controller.getTotalSentences()}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      width: 140,
                      variant: ButtonVariant.secondary,
                      size: ButtonSize.lg,
                      label: 'Retour',
                      icon: Icon(Icons.arrow_back, color: AppColors.white),
                      onPressed:
                          controller.currentIndex.value > 0
                              ? controller.previousSentence
                              : null,
                    ),
                    Obx(
                      () => IconButton(
                        icon: Icon(
                          controller.showFrench.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.white,
                        ),
                        onPressed: controller.toggleFrench,
                        tooltip: 'Show/Hide French',
                      ),
                    ),
                    controller.isLastSentence()
                        ? CustomButton(
                          width: 140,
                          variant: ButtonVariant.secondary,
                          size: ButtonSize.lg,
                          label: 'Exercise',
                          icon: Icon(
                            Icons.arrow_forward,
                            color: AppColors.white,
                          ),
                          onPressed: () {
                            Get.to(
                              () => ConstructionExercice(
                                day: controller.day.value,
                              ),
                              transition: Transition.rightToLeft,
                              duration: Duration(milliseconds: 500),
                            );
                          },
                        )
                        : CustomButton(
                          width: 140,
                          variant: ButtonVariant.secondary,
                          size: ButtonSize.lg,
                          label: 'Suivant',
                          icon: Icon(
                            Icons.arrow_forward,
                            color: AppColors.white,
                          ),
                          onPressed:
                              !controller.isLastSentence()
                                  ? controller.nextSentence
                                  : null,
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
