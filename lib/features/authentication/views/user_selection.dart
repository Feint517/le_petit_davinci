// ignore_for_file: avoid_print

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
import 'package:le_petit_davinci/features/onboarding/views/questions_intro.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class UserSelectionScreen extends GetView<UserSelectionController> {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserSelectionController());

    print('🔍 Controller initialized: ${controller.showQuestionsIntro}');
    print('🔍 Intro message: ${controller.introMessage}');

    //? Si nous devons afficher l'intro, montrer l'écran d'intro
    if (controller.showQuestionsIntro && controller.introMessage != null) {
      print('📱 Showing questions intro screen');
      return const QuestionsIntroScreen();
    }

    print('📱 Showing normal user selection screen');
    //? Sinon, afficher l'écran de sélection utilisateur normal
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Gap(20.h),
              // Logo with entrance animation
              SvgPicture.asset(SvgAssets.logoBlue, height: 60.h)
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 600))
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.elasticOut,
                  ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Floating character illustration
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
                    // Question text with entrance animation
                    Text(
                          StringsManager.whoUsesApp,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.primary,
                            fontFamily: 'DynaPuff_SemiCondensed',
                          ),
                          textAlign: TextAlign.center,
                        )
                        .animate()
                        .fadeIn(
                          duration: const Duration(milliseconds: 600),
                          delay: const Duration(milliseconds: 400),
                        )
                        .slideY(
                          begin: 0.5,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutBack,
                        ),
                  ],
                ),
              ),
              //* Enhanced animated buttons for user selection
              Column(
                children: [
                  // Parent button with staggered entrance
                  CustomButton(
                        label: StringsManager.iAmParent,
                        variant: ButtonVariant.primary,
                        size: ButtonSize.lg,
                        width: double.infinity,
                        onPressed: () {
                          print('🚀 Parent button pressed');
                          Get.toNamed(AppRoutes.login);
                        },
                      )
                      .animate()
                      .fadeIn(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 600),
                      )
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticOut,
                      ),
                  Gap(16.h),
                  // Child button with staggered entrance
                  CustomButton(
                        label: StringsManager.itsMyChild,
                        variant: ButtonVariant.secondary,
                        size: ButtonSize.lg,
                        width: double.infinity,
                        onPressed: () {
                          print('🚀 Child button pressed');
                          Get.toNamed(AppRoutes.home);
                        },
                      )
                      .animate()
                      .fadeIn(
                        duration: const Duration(milliseconds: 600),
                        delay: const Duration(milliseconds: 800),
                      )
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.elasticOut,
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
