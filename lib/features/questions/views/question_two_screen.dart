import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/square_selection_widget.dart';
import 'package:le_petit_davinci/core/widgets/question_grid_panel_widget.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';
import 'package:get/get.dart';

/// Deuxième écran de questions - Sélection des matières préférées
class QuestionTwoScreen extends StatelessWidget {
  const QuestionTwoScreen({super.key});

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
                
                // Question panel widget with grid layout
                QuestionGridPanelWidget(
                  questionText: "Tu préfères apprendre quoi ?",
                  questionNumber: 2,
                  gridOptions: [
                    SquareSelectionOption(
                      value: 'french',
                      title: 'Français',
                      icon: Icons.menu_book,
                      iconColor: AppColors.bluePrimary,
                    ),
                    SquareSelectionOption(
                      value: 'english',
                      title: 'English',
                      icon: Icons.language,
                      iconColor: AppColors.greenPrimary,
                    ),
                    SquareSelectionOption(
                      value: 'math',
                      title: 'Maths',
                      icon: Icons.calculate,
                      iconColor: AppColors.orangeAccent,
                    ),
                    SquareSelectionOption(
                      value: 'educational_games',
                      title: 'Jeux éducatifs',
                      icon: Icons.videogame_asset,
                      iconColor: AppColors.purpleAccent,
                    ),
                  ],
                  buttonText: "Continuer",
                  multipleSelection: true, // Allow selecting multiple subjects
                  onButtonPressed: () {
                    // Navigate to third question
                    Get.toNamed(AppRoutes.questionThree);
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