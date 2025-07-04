import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/dashboard/views/dashboard.dart';
import 'package:le_petit_davinci/features/rewards/views/rewards.dart';
import '../../constants/assets_manager.dart';
import '../../constants/colors.dart';

enum ProfileHeaderType { normal, compact }

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  const ProfileHeader({
    super.key,
    this.userName,
    this.userClass,
    this.avatarPath,
    this.trailingIconOnTap,
    this.bottomLineColor = AppColors.grey,
    this.showTrailingIcon = false,
    this.avatarOnTap,
    this.type = ProfileHeaderType.normal,
  });

  final String? userName;
  final String? userClass;
  final String? avatarPath;
  final bool showTrailingIcon;
  final Color bottomLineColor;
  final VoidCallback? trailingIconOnTap;
  final VoidCallback? avatarOnTap;
  final ProfileHeaderType type;

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
        child:
            type == ProfileHeaderType.normal
                ? Row(
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
                        (userName != null && userClass != null)
                            ? Text(
                              '$userName | $userClass',
                              style: Theme.of(context).textTheme.headlineSmall,
                            )
                            : SizedBox.shrink(),
                      ],
                    ),

                    //* Right Section - Change Avatar Action
                    showTrailingIcon
                        ? IconButton(
                          onPressed:
                              trailingIconOnTap ??
                              () => Get.to(() => const DashboardScreen()),
                          icon: Icon(Iconsax.setting),
                        )
                        : const SizedBox.shrink(),
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
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
                  ],
                ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
