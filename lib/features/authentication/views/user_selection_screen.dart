import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/authentication/controllers/user_selection_controller.dart';
import 'package:le_petit_davinci/features/authentication/views/questions_intro_screen.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class UserSelectionPage extends GetView<UserSelectionController> {
  const UserSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    //? Si nous devons afficher l'intro, montrer l'écran d'intro
    if (controller.showQuestionsIntro && controller.introMessage != null) {
      // return _buildQuestionsIntroScreen(context, controller.introMessage!);
      return QuestionsIntroScreen(message: "i'm just testing");
    }

    //? Sinon, afficher l'écran de sélection utilisateur normal
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Gap(20.h),
              SvgPicture.asset(SvgAssets.logoBlue, height: 60.h),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SvgAssets.choose, height: 300.h)
                        .animate(
                          onPlay:
                              (controller) => controller.repeat(reverse: true),
                        )
                        .moveY(
                          begin: 0,
                          end: -10,
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                        ),
                    Gap(40.h),
                    Text(
                      StringsManager.whoUsesApp,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary,
                        fontFamily: 'DynaPuff_SemiCondensed',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              //* Buttons for user selection
              Column(
                children: [
                  CustomButton(
                    label: StringsManager.iAmParent,
                    onPressed: () {
                      Get.toNamed(Routes.LOGIN);
                    },
                    variant: ButtonVariant.primary,
                    size: ButtonSize.lg,
                    width: double.infinity,
                  ),
                  Gap(16.h),
                  CustomButton(
                    label: StringsManager.itsMyChild,
                    onPressed: () {
                      // Get.toNamed(Routes.ERROR);
                      //Get.toNamed(Routes.QUESTION);
                      Get.to(
                        const QuestionsIntroScreen(
                          message: 'Je suis juste un test',
                        ),
                      );
                    },
                    variant: ButtonVariant.secondary,
                    size: ButtonSize.lg,
                    width: double.infinity,
                  ),
                  Gap(20.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
