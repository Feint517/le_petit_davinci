import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/checkbox_widget.dart';
import 'package:le_petit_davinci/core/widgets/question_panel_widget.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';
import 'package:get/get.dart';

/// Quatrième écran de questions - Ce qui est difficile à l'école
class QuestionFourScreen extends StatelessWidget {
  const QuestionFourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImageAssets.masscotbg),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Gap(20.h),
                
                // Question panel widget with checkbox layout
                QuestionPanelWidget(
                  questionText: "Qu'est-ce qui est un peu plus difficile ?",
                  questionNumber: 4,
                  options: [
                    CheckboxOption(
                      value: 'math_problems',
                      title: 'Problèmes de maths',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.functions,
                        color: AppColors.orangeAccent,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: 'spelling',
                      title: 'Orthographe',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.spellcheck,
                        color: AppColors.bluePrimary,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: 'concentration',
                      title: 'Concentration',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.psychology,
                        color: AppColors.purpleAccent,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: 'understanding_english',
                      title: 'Comprendre l\'anglais',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.translate,
                        color: AppColors.greenPrimary,
                        size: 24.sp,
                      ),
                    ),
                  ],
                  buttonText: "Continuer",
                  multipleSelection: true, // Allow selecting multiple options
                  onButtonPressed: () {
                    // Navigate to fifth question
                    Get.toNamed(AppRoutes.questionFive);
                  },
                ),
                
                const Spacer(),
                Gap(40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}