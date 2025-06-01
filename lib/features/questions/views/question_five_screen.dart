import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/checkbox_widget.dart';
import 'package:le_petit_davinci/core/widgets/question_panel_widget.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';
import 'package:get/get.dart';

/// Cinquième écran de questions - Quelle mission t'amuse le plus
class QuestionFiveScreen extends StatelessWidget {
  const QuestionFiveScreen({super.key});

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
                  questionText: "Quelle mission t'amuse le plus ?",
                  questionNumber: 5,
                  options: [
                    CheckboxOption(
                      value: 'quick_challenges',
                      title: 'Défis rapides',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.flash_on,
                        color: AppColors.secondary,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: 'building_things',
                      title: 'Construire des choses',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.construction,
                        color: AppColors.orangeAccent,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: 'creating',
                      title: 'Créer (dessiner, raconter)',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.palette,
                        color: AppColors.pinkAccent,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: 'stories',
                      title: 'Parler ou écouter des histoires',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.record_voice_over,
                        color: AppColors.bluePrimary,
                        size: 24.sp,
                      ),
                    ),
                  ],
                  buttonText: "Terminer",
                  multipleSelection: false, // Single selection for favorite mission
                  onButtonPressed: () {
                    // Navigate to welcome status screen after completing questions
                    Get.toNamed(AppRoutes.welcomeStatus);
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