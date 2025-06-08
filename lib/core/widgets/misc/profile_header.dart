import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import '../../constants/assets_manager.dart';
import '../../constants/colors.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String userClass;
  final String? avatarPath;
  final bool? changeAvatar;
  final VoidCallback? onChangeAvatar;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.userClass,
    this.avatarPath,
    this.onChangeAvatar, required this.changeAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      child: Column(spacing: 10,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Section - User Info
              Row(
                children: [
                  // Avatar
                  Container(
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
                  
                  Gap(12.w),
                  
                  // User Name and Class
                  Text(
                    '$userName | $userClass',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'DynaPuff_SemiCondensed',
                    ),
                  ),
                ],
              ),
              
              // Right Section - Change Avatar Action
              if (changeAvatar == true)
              InkWell(
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
              ) else
              const SizedBox(), // Empty widget if changeAvatar is false
            ],
          ),
          Divider(
            color: AppColors.white,
            height:1,
            thickness: 1.5,
          ),
        ],
      ),
    );
  }
}