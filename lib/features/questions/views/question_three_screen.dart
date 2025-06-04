import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/checkbox_widget.dart';
import 'package:le_petit_davinci/core/widgets/question_panel_widget.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';
import 'package:get/get.dart';

/// Troisième écran de questions - Ce qui est facile à l'école
class QuestionThreeScreen extends StatelessWidget {
  const QuestionThreeScreen({super.key});

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
                  questionText: "Qu'est-ce que tu trouves facile à l'école ?",
                  questionNumber: 3,
                  options: [
                    CheckboxOption(
                      value: 'calculations',
                      title: 'Calculs',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.calculate_outlined,
                        color: AppColors.orangeAccent,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: 'reading',
                      title: 'Lire une histoire',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.auto_stories,
                        color: AppColors.bluePrimary,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: 'speaking_english',
                      title: 'Parler anglais',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.chat_bubble_outline,
                        color: AppColors.greenPrimary,
                        size: 24.sp,
                      ),
                    ),
                    CheckboxOption(
                      value: 'learning_by_playing',
                      title: 'Apprendre en jouant',
                      subtitle: null,
                      iconWidget: Icon(
                        Icons.sports_esports,
                        color: AppColors.purpleAccent,
                        size: 24.sp,
                      ),
                    ),
                  ],
                  buttonText: "Continuer",
                  multipleSelection: true, // Allow selecting multiple options
                  onButtonPressed: () {
                    // Navigate to fourth question
                    Get.toNamed(AppRoutes.questionFour);
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