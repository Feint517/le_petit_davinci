import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/container/curved_header_container.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/features/lessons/english/widget/practice_header.dart';
import 'package:le_petit_davinci/features/lessons/french/controllers/construction_introduction_lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/french/widgets/day_option_list_tile.dart';

class ConstructionIntroductionLesson extends StatelessWidget {
  ConstructionIntroductionLesson({super.key});

  final controller = Get.put(ConstructionIntroductionLessonController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.primary,
      appBar: CustomNavBar(activeChip: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCurvedHeaderContainer(
              child: const PracticeHeader(
                lessonName: 'Construction De Phrases Simples',
                badgeVariant: BadgeVariant.french,
                badgeType: LessonBadgeType.phrasesBuilder,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                spacing: AppSizes.spaceBtwSections,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 300,
                      width: DeviceUtils.getScreenWidth() * 0.8,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(ImageAssets.iamSorry, fit: BoxFit.cover),
                          const Gap(50),
                          Image.asset(ImageAssets.desole, fit: BoxFit.cover),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Phrases Simples : Je suis désolé.",
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.apply(color: AppColors.white),
                  ),
                  //* Lesson description
                  Text(
                    "L'expression « Je suis désolé » sert à présenter ses excuses ou exprimer son regret après avoir fait ou dit quelque chose qui a pu blesser, déranger ou décevoir quelqu'un. On l'emploie dans des contextes formels et informels pour montrer que l'on reconnaît une erreur ou une maladresse.",
                    style: Theme.of(context).textTheme.titleLarge!.apply(
                      color: AppColors.white,
                      fontWeightDelta: -100,
                    ),
                  ),

                  //* Start button
                  CustomButton(
                    label: 'Commencer',
                    onPressed: () => _showDaySelectionModal(context),
                  ),
                  const Gap(100),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDaySelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled:
          true, //? Allows the modal to take more space if needed
      builder:
          (context) => Container(
            height: DeviceUtils.getScreenHeight() * 0.8,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Text(
                  "Sélectionnez votre leçon",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Gap(5),

                //* Close button
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const Gap(15),

                //* List of lessons
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.lessonOptions.length,
                    itemBuilder: (context, index) {
                      final day = index + 1;
                      return DayOption(controller.lessonOptions[index], day);
                    },
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
