import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/sizes.dart';
import '../../../core/widgets/buttons/buttons.dart';
import '../controllers/welcome_status_controller.dart';

class WelcomeStatusScreen extends GetView<WelcomeStatusController> {
  const WelcomeStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              ImageAssets.finalMasscotIntro,
              fit: BoxFit.cover,
            ),
          ),
          // Content overlay
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Column(
                children: [
                  Gap(30.h),

                  // Header message box with mascot
                  _buildHeaderMessageBox(),

                  Gap(40.h),

                  // Informational text section
                  _buildInformationalTextSection(),

                  Gap(60.h),

                  // Action button
                  _buildActionButton(),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderMessageBox() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.bluePrimary,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Text content
          Padding(
            padding: EdgeInsets.only(right: 80.w),
            child: Obx(
              () => RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 18.sp,
                    fontFamily: 'DynaPuff',
                  ),
                  children: [
                    TextSpan(
                      text: 'Bravo ',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: controller.childName.value,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' ! ',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const TextSpan(
                      text: 'Merci d\'avoir répondu à mes questions. 🎉',
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Mascot on the right - using bear mascot as placeholder
          Positioned(
            right: -30.w,
            top: -20.h,
            child: SvgPicture.asset(SvgAssets.bearMasscot, height: 100.h),
          ),
        ],
      ),
    );
  }

  Widget _buildInformationalTextSection() {
    return Column(
      children: [
        Text(
          'Je suis super content de te retrouver chaque jour pour apprendre et t\'amuser.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textPrimary,
            fontFamily: 'DynaPuff',
            fontWeight: FontWeight.w400,
          ),
        ),
        Gap(12.h),
        Text(
          'Aujourd\'hui, on commencera doucement avec les maths et un petit défi de lecture.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textPrimary,
            fontFamily: 'DynaPuff',
            fontWeight: FontWeight.w400,
          ),
        ),
        Gap(20.h),
        Text(
          'Tu es prêt ?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.orangeAccent,
            fontFamily: 'DynaPuff',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return PillButton(
      label: 'Découvrir mon espace',
      onPressed: controller.navigateToChildSpace,
      variant: ButtonVariant.secondary, // Orange variant
      size: ButtonSize.lg,
      icon: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 16.sp,
          color: AppColors.white,
        ),
      ),
      iconPosition: IconPosition.right,
    );
  }
}
