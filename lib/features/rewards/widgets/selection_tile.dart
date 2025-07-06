import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/features/rewards/controllers/rewards_controller.dart';

class SelectionTile extends GetView<RewardsController> {
  const SelectionTile({
    super.key,
    required this.backgroundColor,
    this.isSelected = false,
    required this.text,
    required this.onTap,
  });

  final Color backgroundColor;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(17.r),
        ),
        child: Center(
          child:
              isSelected
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        text,
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      ResponsiveImageAsset(
                        assetPath: IconAssets.check,
                        width: 15.w,
                      ),
                    ],
                  )
                  : Text(
                    text,
                    style: TextStyle(color: AppColors.white, fontSize: 14.sp),
                  ),
        ),
      ),
    );
  }
}
