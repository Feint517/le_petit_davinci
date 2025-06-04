import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/checkbox_widget.dart';
import 'package:le_petit_davinci/core/widgets/question_panel_widget.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';
import 'package:get/get.dart';

/// Écran de questions avec la même structure que l'écran d'accueil
class QuestionScreen extends StatelessWidget {
  const QuestionScreen({super.key});

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
                
                // Question panel widget
                QuestionPanelWidget(
                  questionText: "Combien de temps veux-tu apprendre chaque jour ?",
                  questionNumber: 1,
                  options: [
                    CheckboxOption(
                      value: '5',
                      title: '5 minutes',
                      subtitle: 'Juste pour m\'amuser',
                      iconWidget: Icon(
                        Icons.access_time,
                        color: AppColors.orangeAccent,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: '10',
                      title: '10 minutes',
                      subtitle: 'Un petit défi',
                      iconWidget: Icon(
                        Icons.timer,
                        color: AppColors.orangeAccent,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: '15',
                      title: '15 minutes ou +',
                      subtitle: 'Je veux apprendre beaucoup',
                      iconWidget: Icon(
                        Icons.all_inclusive,
                        color: AppColors.orangeAccent,
                        size: 24.sp,
                      ),
                    ),
                  ],
                  buttonText: "Continuer",
                  onButtonPressed: () {
                    // Navigate to second question
                    Get.toNamed(AppRoutes.questionTwo);
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