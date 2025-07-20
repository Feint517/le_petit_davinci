import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';

class HeaderMessageBox extends StatelessWidget {
  const HeaderMessageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        boxShadow: CustomShadowStyle.customCircleShadows(
          color: AppColors.primary,
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          //* Text content
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.apply(color: AppColors.white),
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

          //* Mascot on the right
          Positioned(
            right: -30.w,
            top: 20.h,
            child: const ResponsiveImageAsset(
              assetPath: SvgAssets.bunny,
              width: 60,
            ),
          ),
        ],
      ),
    );
  }
}
