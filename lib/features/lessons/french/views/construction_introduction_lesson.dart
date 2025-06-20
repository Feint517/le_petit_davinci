// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/features/lessons/french/controllers/construction_introduction_lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/french/views/construction_lesson.dart';
import 'package:le_petit_davinci/features/lessons/french/widgets/start_button.dart';

class ConstructionIntroductionLesson extends StatelessWidget {
  ConstructionIntroductionLesson({super.key});

  // Get reference to our controller
  final controller = Get.put(ConstructionIntroductionLessonController());
  final TextStyle textStyle = TextStyle(fontSize: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDEFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar
                // CommonHeader(
                //   pageTitle: "Construction de Phrases",
                //   trailing: CircleAvatar(
                //     backgroundImage: AssetImage(IconAssets.avatar),
                //     radius: 24,
                //   ),
                // ),
                const Gap(AppSizes.defaultSpace),

                // Main content container
                Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/illustrations/sorry.png',
                          fit: BoxFit.cover,
                        ),
                        Gap(50),
                        Image.asset(
                          'assets/images/illustrations/dsl.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),

                // Points indicator
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color(0xffFDCFFE),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    "Obtenez 4 points",
                    style: TextStyle(
                      color: Color(0xffFC715A),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                Gap(15),

                // Lesson title
                Text(
                  "Construction De Phrases Simples",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),

                // Lesson subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Phrases Simples : Je suis désolé.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontFamily: 'BricolageGrotesque',
                      letterSpacing: 0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                // Lesson description
                Text(
                  "L'expression « Je suis désolé » sert à présenter ses excuses ou exprimer son regret après avoir fait ou dit quelque chose qui a pu blesser, déranger ou décevoir quelqu'un. On l'emploie dans des contextes formels et informels pour montrer que l'on reconnaît une erreur ou une maladresse.",
                  style: textStyle,
                ),

                Gap(40),

                // Start button
                StartButton(onPressed: () => _showDaySelectionModal(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDaySelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // Allows the modal to take more space if needed
      builder:
          (context) => Container(
            height:
                MediaQuery.of(context).size.height *
                0.7, // Take 70% of screen height
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                // Modal title
                Text(
                  "Sélectionnez votre leçon",
                  style: TextStyle(
                    fontFamily: 'BricolageGrotesque',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        AppColors
                            .black, // Replace with your AppColors.primaryDeep
                  ),
                ),
                const Gap(15),

                // Close button
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // List of lessons
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.lessonOptions.length,
                    itemBuilder: (context, index) {
                      final day = index + 1;
                      return _buildDayOption(
                        controller.lessonOptions[index],
                        day,
                        context,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildDayOption(String option, int day, BuildContext context) {
    return InkWell(
      onTap: () {
        // First update the controller state
        controller.changeSelectedDay(day);

        // Log to console for debugging
        print('Selected day: $day');

        Navigator.pop(context);

        // Pass the day directly from controller to ensure consistency
        Get.to(
          () => ConstructionLesson(day: controller.selectedDay.value),

          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 500),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Color(0xFFF0E6FF), // Light purple border
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Day number circle
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Color(0xFF663399), // Replace with your primary color
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  day.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'BricolageGrotesque',
                  ),
                ),
              ),
            ),
            Gap(12),
            // Lesson label
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontFamily: 'BricolageGrotesque',
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            // Arrow icon
            Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[600]),
          ],
        ),
      ),
    );
  }
}
