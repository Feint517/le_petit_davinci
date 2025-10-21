import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/authentication/controllers/create_profile_controller.dart';

class CreateProfileScreen extends GetView<CreateProfileController> {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use lazyPut with fenix to prevent multiple instances
    Get.lazyPut(() => CreateProfileController(), fenix: true);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Get.back(),
        ),
        actions: [
          // Create Profile Button - Top Right
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ElevatedButton(
              onPressed: controller.createProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check, size: 20.sp),
                  Gap(8.w),
                  Text(
                    'Créer',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                SvgPicture.asset(SvgAssets.logoBlue, height: 60.h),

                Gap(24.h),

                // Title
                Text(
                  'Créer votre profil',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                  textAlign: TextAlign.center,
                ),

                Gap(8.h),

                // Subtitle
                Text(
                  'Choisissez un avatar et un code PIN pour sécuriser votre profil',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                Gap(32.h),

                // Profile Name Input
                TextFormField(
                  controller: controller.profileName,
                  decoration: InputDecoration(
                    labelText: 'Nom du profil',
                    hintText: 'Ex: Mon Profil, Enfant, etc.',
                    prefixIcon: const Icon(Icons.person_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                  ),
                  validator: controller.validateProfileName,
                ),

                Gap(24.h),

                // Avatar Selection
                Text(
                  'Choisissez votre avatar',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                Gap(16.h),

                Obx(
                  () => Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    alignment: WrapAlignment.center,
                    children:
                        controller.avatars.asMap().entries.map((entry) {
                          final index = entry.key;
                          final avatar = entry.value;
                          final isSelected =
                              controller.selectedAvatarIndex.value == index;

                          return GestureDetector(
                            onTap: () => controller.selectAvatar(index),
                            child: Container(
                              width: 80.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: avatar.backgroundColor.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color:
                                      isSelected
                                          ? avatar.backgroundColor
                                          : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  avatar.image,
                                  width: 50.w,
                                  height: 50.h,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                ),

                Gap(24.h),

                // PIN Input
                Text(
                  'Code PIN (4 chiffres)',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                Gap(12.h),

                TextFormField(
                  controller: controller.pinController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  obscureText: true,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: '••••',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    filled: true,
                    fillColor: AppColors.white,
                    counterText: '',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 8.w,
                  ),
                  validator: controller.validatePin,
                ),

                Gap(16.h),

                // PIN Info
                Container(
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                      Gap(8.w),
                      Expanded(
                        child: Text(
                          'Vous utiliserez ce code PIN pour accéder à votre profil',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
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
}

// Avatar Data Model
class AvatarData {
  final String image;
  final Color backgroundColor;

  AvatarData({required this.image, required this.backgroundColor});
}
