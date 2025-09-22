import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/utils/string_utils.dart';
import 'package:le_petit_davinci/core/widgets/loaders/shimmer.dart';
import 'package:le_petit_davinci/features/authentication/controllers/user_controller.dart';
import 'package:le_petit_davinci/features/dashboard/views/dashboard.dart';
import 'package:le_petit_davinci/features/levels/widgets/progress_bar.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/rewards/views/rewards.dart';
import '../../constants/assets_manager.dart';
import '../../constants/colors.dart';

enum ProfileHeaderType { normal, compact, activity }

class ProfileHeader extends GetView<UserController>
    implements PreferredSizeWidget {
  const ProfileHeader({
    super.key,
    this.avatarPath,
    this.trailingIconOnTap,
    this.bottomLineColor = AppColors.grey,
    this.showTrailingIcon = false,
    this.avatarOnTap,
    this.onBackButtonPressed,
    this.type = ProfileHeaderType.normal,
  });

  final String? avatarPath;
  final bool showTrailingIcon;
  final Color bottomLineColor;
  final VoidCallback? trailingIconOnTap;
  final VoidCallback? avatarOnTap;
  final VoidCallback? onBackButtonPressed;
  final ProfileHeaderType type;

  // @override
  // Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
  @override
  Size get preferredSize => Size.fromHeight(
    type == ProfileHeaderType.activity ? 100.h : DeviceUtils.getAppBarHeight(),
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Container(
        width: double.infinity,
        height: DeviceUtils.getAppBarHeight(),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: switch (type) {
          ProfileHeaderType.normal => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //* Left Section - User Info
              Row(
                children: [
                  //* Avatar
                  GestureDetector(
                    onTap:
                        avatarOnTap ??
                        () => Get.to(() => const RewardsScreen()),
                    child: Container(
                      width: 48.w,
                      height: 48.w,
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.primary,
                          width: 2.5,
                        ),
                      ),
                      child: ClipOval(
                        child: SvgPicture.asset(
                          avatarPath ?? SvgAssets.avatar1,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),

                  Gap(12.w),

                  //* User Name and Class
                  Obx(
                    () =>
                        ((controller.isLoading.value)
                            ? const CustomShimmerEffect(width: 160, height: 25)
                            : Text(
                              '${StringUtils.capitalize(controller.user.value!.name)} | ${StringUtils.capitalize(controller.user.value!.userClass)}',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )),
                  ),
                ],
              ),

              //* Right Section - Change Avatar Action
              if (showTrailingIcon)
                IconButton(
                  onPressed:
                      trailingIconOnTap ??
                      () => Get.to(() => const DashboardScreen()),
                  icon: Icon(Iconsax.setting),
                ),
            ],
          ),
          ProfileHeaderType.compact => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onBackButtonPressed ?? () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 10,
                      ),
                      Text('Back', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: avatarOnTap ?? () => Get.to(() => const RewardsScreen()),
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.primary, width: 2.5),
                  ),
                  child: ClipOval(
                    child: SvgPicture.asset(
                      avatarPath ?? SvgAssets.avatar1,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // ProfileHeaderType.activity => Obx(() {
          //   // int totalSteps = 0;
          //   // int currentStep = 0;

          //   // Check which controller is active and get the progress data.
          //   // if (Get.isRegistered<LevelController>()) {
          //   //   final controller = Get.find<LevelController>();
          //   //   totalSteps = controller.levelSet.activities.length;
          //   //   currentStep = controller.currentIndex.value;
          //   // }

          //   return LevelProgressBar(
          //     // totalSteps: totalSteps,
          //     // currentStep: currentStep,
          //   );
          // }),
          ProfileHeaderType.activity => const LevelProgressBar(),
        },
      ),
    );
  }
}
