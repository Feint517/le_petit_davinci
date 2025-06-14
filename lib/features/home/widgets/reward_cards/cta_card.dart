import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

class CTACard extends StatelessWidget {
  final String promptText;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const CTACard({
    super.key,
    required this.promptText,
    this.buttonText = 'Continuer',
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.bluePrimary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          //* Prompt text section
          Expanded(
            flex: 3,
            child: Text(
              promptText,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
          ),

          Gap(16.w),

          // Continue button
          Expanded(flex: 2, child: _buildContinueButton()),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return InkWell(
      onTap: onButtonPressed ?? () {},
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColors.bluePrimary,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* Book icon
            ResponsiveSvgAsset(assetPath: SvgAssets.book, width: 22.w),

            Gap(6.w),

            //* Button text
            Flexible(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
