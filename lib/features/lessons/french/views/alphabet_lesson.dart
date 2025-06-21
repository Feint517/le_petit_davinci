import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/container/curved_header_container.dart';
import 'package:le_petit_davinci/features/lessons/english/widget/practice_header.dart';
import 'package:le_petit_davinci/features/lessons/french/controllers/alphabet_lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/french/widgets/alphabet_card.dart';
import 'package:le_petit_davinci/features/lessons/french/widgets/navigation_row.dart';

class AlphabetLessonScreen extends StatelessWidget {
  const AlphabetLessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AlphabetLessonController());
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomCurvedHeaderContainer(
              child: const PracticeHeader(
                lessonName: 'Alphabet & Prononciation',
                lessonDescription:
                    "Apprenez les lettres de l'alphabet francais et leur prononciation",
                badgeVariant: BadgeVariant.french,
                badgeType: LessonBadgeType.soundMaster,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(
                () =>
                    controller.isLetterExpanded.value
                        ? Column(
                          children: [
                            AlphabetCard(
                              letter: controller.currentLetter,
                              index: controller.currentLetterIndex.value,
                              isExpanded: true,
                              isSelected: true,
                              isPlaying: controller.isPlaying.value,
                              onTap: () {
                                if (!controller.isPlaying.value) {
                                  controller.playLetterSound(
                                    controller.currentLetter,
                                  );
                                }
                              },
                              animation: controller.letterScaleAnimation,
                            ),

                            //* Navigation des lettres
                            const NavigationRow(),
                          ],
                        )
                        : GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                childAspectRatio: 1.0,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                          itemCount: controller.currentSection.letters.length,
                          itemBuilder: (context, index) {
                            final letter =
                                controller.currentSection.letters[index];
                            final isSelected =
                                controller.currentLetterIndex.value == index;

                            return AlphabetCard(
                              letter: letter,
                              index: index,
                              isSelected: isSelected,
                              isPlaying:
                                  isSelected && controller.isPlaying.value,
                              onTap: () {
                                controller.currentLetterIndex.value = index;
                                controller.toggleLetterExpanded();
                              },
                              animation:
                                  isSelected
                                      ? controller.letterScaleAnimation
                                      : null,
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
