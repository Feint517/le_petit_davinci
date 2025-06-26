import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';

class HeaderMessageBox extends StatelessWidget {
  const HeaderMessageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.bluePrimaryDark,
            spreadRadius: 2,
            blurRadius: 0,
            offset: const Offset(3, 5),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          //* Text content
          Padding(
            padding: EdgeInsets.only(right: 80.w),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 18.sp,
                  fontFamily: 'DynaPuff_SemiCondensed',
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(text: 'Bravo ', style: TextStyle(fontSize: 22.sp)),
                  TextSpan(
                    text: "Alex", //! Fetch the child name from controller
                    style: TextStyle(fontSize: 24.sp, color: AppColors.accent),
                  ),
                  TextSpan(text: ' ! ', style: TextStyle(fontSize: 22.sp)),
                  const TextSpan(
                    text: 'Merci d\'avoir répondu à mes questions. 🎉',
                  ),
                ],
              ),
            ),
          ),

          //* Mascot on the right
          Positioned(
            right: -30.w,
            top: 20.h,
            child: SvgPicture.asset(SvgAssets.bunny, height: 100.h),
          ),
        ],
      ),
    );
  }
}
