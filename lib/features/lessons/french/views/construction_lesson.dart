// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/french/controllers/construction_lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/french/views/construction_exercice.dart';

class ConstructionLesson extends StatelessWidget {
  final int day;

  ConstructionLesson({super.key, required this.day}) {
    print('ConstructionLesson initialized with day: $day');
  }
  @override
  Widget build(BuildContext context) {
    // Initialize controller with dependency injection
    final controller = Get.put(ConstructionLessonController());
    controller.day.value = day;
    controller.loadSentences();

    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            'Jour ${controller.day.value} - Apprendre les phrases',
            style: TextStyle(fontFamily: 'BricolageGrotesque'),
          ),
        ),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                controller.showFrench.value
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: controller.toggleFrench,
              tooltip: 'Show/Hide French',
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Text(
                        controller.getCurrentEnglishSentence(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'BricolageGrotesque',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gap(30),
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
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'BricolageGrotesque',
                                  color: AppColors.primaryDeep,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.volume_up),
                              onPressed: controller.speakFrenchSentence,
                              tooltip: 'Listen to pronunciation',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(20),
                    Obx(
                      () => Text(
                        '${controller.currentIndex.value + 1}/${controller.getTotalSentences()}',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'BricolageGrotesque',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed:
                        controller.currentIndex.value > 0
                            ? controller.previousSentence
                            : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                    ),
                    child: Icon(Icons.arrow_back),
                  ),
                  if (controller.isLastSentence())
                    ElevatedButton(
                      onPressed: () {
                        Get.to(
                          () => ConstructionExercice(day: controller.day.value),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 500),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                      child: Text(
                        'Exercise',
                        style: TextStyle(fontFamily: 'BricolageGrotesque'),
                      ),
                    )
                  else
                    ElevatedButton(
                      onPressed:
                          !controller.isLastSentence()
                              ? controller.nextSentence
                              : null,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                      child: Icon(Icons.arrow_forward),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
