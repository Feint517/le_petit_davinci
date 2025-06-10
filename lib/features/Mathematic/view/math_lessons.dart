import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/Mathematic/view/lesson_video_screen.dart';

class MathLessons extends StatelessWidget {
  const MathLessons({super.key});

  // List of math lesson titles
  static const List<String> lessons = [
    'Les nombres de 0 à 10',
    'Compter jusqu\'à 20',
    'Les dizaines et unités',
    'Addition simple',
    'Soustraction simple',
    'Les formes géométriques',
    'Le carré et le rectangle',
    'Le cercle et le triangle',
    'Comparer les nombres',
    'Plus grand ou plus petit',
    'Les doubles',
    'La moitié',
    'Compter par bonds de 2',
    'Compter par bonds de 5',
    'Les nombres pairs et impairs',
    'Résoudre des problèmes simples',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary, // Math orange background
      body: SafeArea(
        child: Column(
          children: [
            // Top bar with back button and Math label
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back button
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.chevron_left,
                            color: AppColors.darkGrey,
                            size: 16,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            'Back',
                            style: TextStyle(
                              color: AppColors.darkGrey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Math label button
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Mathématiques',
                      style: TextStyle(
                        color: AppColors.darkGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(16),
            // Page title
            Text(
              'Matériel d\'apprentissage',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(24),
            // Scrollable list of lesson buttons
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: lessons.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: index == 0 ? () {
                          // Only first lesson is clickable - navigate to video screen
                          Get.to(
                            () => LessonVideoScreen(
                              lessonTitle: lessons[index],
                              videoUrl: 'https://example.com/video/math-lesson-1',
                              description: 'Apprenez à reconnaître et compter les nombres de 0 à 10. Découvrez comment les nombres nous entourent dans la vie quotidienne.',
                            ),
                            duration: const Duration(milliseconds: 500),
                            transition: Transition.rightToLeft,
                          );
                        } : null, // Other lessons are not clickable
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: index == 0 ? AppColors.white : AppColors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                            border: index == 0 ? Border.all(
                              color: AppColors.secondary,
                              width: 2,
                            ) : null,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  lessons[index],
                                  style: TextStyle(
                                    color: index == 0 ? AppColors.darkGrey : AppColors.grey,
                                    fontSize: 16,
                                    fontWeight: index == 0 ? FontWeight.w600 : FontWeight.w500,
                                  ),
                                ),
                              ),
                              if (index == 0)
                                Icon(
                                  Icons.play_circle_filled,
                                  color: AppColors.secondary,
                                  size: 24,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Gap(20),
          ],
        ),
      ),
    );
  }
}