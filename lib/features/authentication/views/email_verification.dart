import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/authentication/controllers/email_verification_controller.dart';
import 'package:le_petit_davinci/features/authentication/widgets/verification_code_input.dart';

class EmailVerificationScreen extends GetView<EmailVerificationController> {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    Get.put(EmailVerificationController());

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(40.h),

              // Back button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.textPrimary,
                    size: 20.sp,
                  ),
                  onPressed: controller.goBack,
                ),
              ),

              Gap(20.h),

              // Logo with animation
              SvgPicture.asset(SvgAssets.logoBlue, height: 100.h)
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(
                    begin: const Offset(0.8, 0.8),
                    duration: 500.ms,
                    curve: Curves.elasticOut,
                  ),

              Gap(40.h),

              // Title
              Text(
                'Vérifiez votre email',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms),

              Gap(16.h),

              // Description
              Text(
                'Nous avons envoyé un code de vérification à\n${controller.email}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms),

              Gap(40.h),

              // Verification code input
              Obx(
                    () => VerificationCodeInput(
                      length: 6,
                      hasError: controller.hasError.value,
                      onChanged: controller.onCodeChanged,
                      onCompleted: controller.verifyEmail,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 400.ms)
                  .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),

              Gap(40.h),

              // Resend code section
              Obx(
                () =>
                    controller.canResend.value
                        ? TextButton(
                          onPressed: controller.resendCode,
                          child: Text(
                            'Renvoyer le code',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                        : Text(
                          'Renvoyer le code dans ${controller.resendCountdown.value}s',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
              ).animate().fadeIn(delay: 500.ms, duration: 400.ms),

              Gap(60.h),

              // Info card
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.primary,
                      size: 24.sp,
                    ),
                    Gap(12.w),
                    Expanded(
                      child: Text(
                        'Le code expire dans 10 minutes. Vérifiez également vos spams.',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: 600.ms, duration: 400.ms),

              Gap(40.h),

              // Email icon decoration
              Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.email_outlined,
                      size: 48.sp,
                      color: AppColors.primary,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: 700.ms, duration: 400.ms)
                  .scale(delay: 700.ms, duration: 500.ms),

              Gap(20.h),

              // Help text
              Text(
                'Besoin d\'aide?',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),

              Gap(8.h),

              TextButton(
                onPressed: () {
                  // TODO: Open help/support
                },
                child: Text(
                  'Contactez le support',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              Gap(40.h),
            ],
          ),
        ),
      ),
    );
  }
}
