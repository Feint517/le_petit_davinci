import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/features/authentication/widgets/header_vector.dart';

class GoodMorningScreen extends StatelessWidget {
  const GoodMorningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        top: false,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                SvgAssets.goodmorningBackground,
                width: DeviceUtils.getScreenWidth(),
                fit: BoxFit.fitWidth,
              ),
            ),
            HeaderVector(color: HeaderVectorColor.blue),
            Positioned(
              top: 200.h,
              left: 24.w,
              child: SizedBox(
                width: DeviceUtils.getScreenWidth() - 48.w,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontSize: 32.sp,
                      fontFamily: 'DynaPuff_SemiCondensed',
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(text: StringsManager.goodMorning),
                      TextSpan(
                        text: " Alex ", //! Fetch the child name from controller
                        style: TextStyle(color: AppColors.accent),
                      ),
                      TextSpan(text: '! '),
                      const TextSpan(text: StringsManager.nextAdventure),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
