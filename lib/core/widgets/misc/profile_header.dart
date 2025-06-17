import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import '../../constants/assets_manager.dart';
import '../../constants/colors.dart';

class ProfileHeader extends StatelessWidget implements PreferredSizeWidget {
  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userClass,
    this.avatarPath,
    this.onChangeAvatar,
    this.bottomLineColor = AppColors.grey,
    this.changeAvatar = true,
    this.onAvatarTap,
  });

  final String userName;
  final String userClass;
  final String? avatarPath;
  final bool changeAvatar;
  final Color bottomLineColor;
  final VoidCallback? onChangeAvatar;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      bottom: false,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: DeviceUtils.getAppBarHeight(),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //* Left Section - User Info
                Row(
                  children: [
                    //* Avatar
                    GestureDetector(
                      onTap: onAvatarTap,
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        padding: EdgeInsets.all(2.w),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.bluePrimary,
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
                    Text(
                      '$userName | $userClass',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),

                //* Right Section - Change Avatar Action
                changeAvatar
                    ? InkWell(
                      onTap: onChangeAvatar ?? () {},
                      borderRadius: BorderRadius.circular(8.r),
                      child: Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: Colors.grey,
                              size: 12.sp,
                            ),

                            Gap(4.w),

                            Text(
                              'Changer mon avatar',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DynaPuff_SemiCondensed',
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(DeviceUtils.getAppBarHeight());
}
