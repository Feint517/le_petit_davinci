import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';

/// A demonstration screen showcasing animated buttons for kids' educational apps
class ButtonDemoScreen extends StatelessWidget {
  const ButtonDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Animated Buttons Demo',
          style: TextStyle(
            fontFamily: 'DynaPuff_SemiCondensed',
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20.h),

                // Section: Primary Animated Buttons
                _buildSectionTitle('Primary Animated Buttons'),
                Gap(16.h),
                PrimaryAnimatedButton(
                  label: 'Continue Adventure',
                  icon: const Icon(Icons.arrow_forward, color: Colors.white),
                  entranceDelay: const Duration(milliseconds: 200),
                  width: double.infinity,
                  onPressed: () => _showSnackbar('Primary button pressed!'),
                ),
                Gap(12.h),
                PrimaryAnimatedButton(
                  label: 'Start Learning',
                  icon: const Icon(Icons.school, color: Colors.white),
                  entranceDelay: const Duration(milliseconds: 400),
                  width: double.infinity,
                  onPressed: () => _showSnackbar('Learning started!'),
                ),

                Gap(32.h),

                // Section: Secondary Animated Buttons
                _buildSectionTitle('Secondary Animated Buttons'),
                Gap(16.h),
                SecondaryAnimatedButton(
                  label: 'Play Games',
                  icon: const Icon(Icons.games, color: Colors.white),
                  entranceDelay: const Duration(milliseconds: 600),
                  width: double.infinity,
                  onPressed: () => _showSnackbar('Games selected!'),
                ),
                Gap(12.h),
                SecondaryAnimatedButton(
                  label: 'View Rewards',
                  icon: const Icon(Icons.star, color: Colors.white),
                  entranceDelay: const Duration(milliseconds: 800),
                  width: double.infinity,
                  onPressed: () => _showSnackbar('Rewards opened!'),
                ),

                Gap(32.h),

                // Section: Custom Animated Buttons
                _buildSectionTitle('Custom Animation Settings'),
                Gap(16.h),

                // Button with pulse effect
                AnimatedButton(
                  label: 'Special Offer!',
                  icon: const Icon(Icons.local_offer, color: Colors.white),
                  variant: ButtonVariant.primary,
                  size: ButtonSize.lg,
                  width: double.infinity,
                  entranceDelay: const Duration(milliseconds: 1000),
                  enablePulseEffect: true,
                  enableFloatingAnimation: false,
                  onPressed: () => _showSnackbar('Special offer clicked!'),
                ),

                Gap(12.h),

                // Button without floating animation
                AnimatedButton(
                  label: 'Settings',
                  icon: const Icon(Icons.settings, color: Colors.white),
                  variant: ButtonVariant.secondary,
                  size: ButtonSize.lg,
                  width: double.infinity,
                  entranceDelay: const Duration(milliseconds: 1200),
                  enableFloatingAnimation: false,
                  enableBounceOnTap: true,
                  onPressed: () => _showSnackbar('Settings opened!'),
                ),

                Gap(32.h),

                // Section: Button Grid
                _buildSectionTitle('Button Grid Layout'),
                Gap(16.h),
                Row(
                  children: [
                    Expanded(
                      child: AnimatedButton(
                        label: 'Math',
                        icon: const Icon(Icons.calculate, color: Colors.white),
                        variant: ButtonVariant.primary,
                        size: ButtonSize.md,
                        entranceDelay: const Duration(milliseconds: 1400),
                        onPressed: () => _showSnackbar('Math selected!'),
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: AnimatedButton(
                        label: 'French',
                        icon: const Icon(Icons.language, color: Colors.white),
                        variant: ButtonVariant.secondary,
                        size: ButtonSize.md,
                        entranceDelay: const Duration(milliseconds: 1600),
                        onPressed: () => _showSnackbar('French selected!'),
                      ),
                    ),
                  ],
                ),

                Gap(12.h),

                Row(
                  children: [
                    Expanded(
                      child: AnimatedButton(
                        label: 'English',
                        icon: const Icon(Icons.translate, color: Colors.white),
                        variant: ButtonVariant.primary,
                        size: ButtonSize.md,
                        entranceDelay: const Duration(milliseconds: 1800),
                        onPressed: () => _showSnackbar('English selected!'),
                      ),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: AnimatedButton(
                        label: 'Games',
                        icon: const Icon(
                          Icons.videogame_asset,
                          color: Colors.white,
                        ),
                        variant: ButtonVariant.secondary,
                        size: ButtonSize.md,
                        entranceDelay: const Duration(milliseconds: 2000),
                        onPressed: () => _showSnackbar('Games selected!'),
                      ),
                    ),
                  ],
                ),

                Gap(40.h),

                // Reset demonstration button
                Center(
                  child: AnimatedButton(
                    label: 'Reset Demo',
                    icon: const Icon(Icons.refresh, color: AppColors.primary),
                    variant: ButtonVariant.ghost,
                    size: ButtonSize.md,
                    entranceDelay: const Duration(milliseconds: 2200),
                    onPressed: () {
                      Get.off(() => const ButtonDemoScreen());
                    },
                  ),
                ),

                Gap(40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primary,
        fontFamily: 'DynaPuff_SemiCondensed',
      ),
    );
  }

  void _showSnackbar(String message) {
    Get.snackbar(
      'Button Pressed',
      message,
      backgroundColor: AppColors.primary.withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: EdgeInsets.all(16.w),
      borderRadius: 12,
    );
  }
}
