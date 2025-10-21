// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/authentication/controllers/user_selection_controller.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

/// Loading screen that automatically redirects to login
/// This screen is shown briefly during app initialization
class UserSelectionScreen extends GetView<UserSelectionController> {
  const UserSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UserSelectionController());

    // Automatically navigate to login after a brief delay
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (Get.context != null) {
        Get.offAllNamed(AppRoutes.login);
      }
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo with entrance animation
              SvgPicture.asset(SvgAssets.logoBlue, height: 100.h)
                  .animate()
                  .fadeIn(duration: const Duration(milliseconds: 600))
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.elasticOut,
                  ),

              Gap(40.h),

              // Loading indicator
              SizedBox(
                    width: 40.w,
                    height: 40.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  )
                  .animate(onPlay: (controller) => controller.repeat())
                  .fadeIn(
                    duration: const Duration(milliseconds: 400),
                    delay: const Duration(milliseconds: 600),
                  ),

              Gap(24.h),

              // Loading text
              Text(
                'Chargement...',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
              ).animate().fadeIn(
                duration: const Duration(milliseconds: 400),
                delay: const Duration(milliseconds: 800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
