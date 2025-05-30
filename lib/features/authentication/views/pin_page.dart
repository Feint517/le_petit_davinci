import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/authentication/controllers/pin_entry_controller.dart';
import 'package:le_petit_davinci/features/authentication/widgets/pin_box.dart';

class PinEntryPage extends GetView<PinEntryController> {
  const PinEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        bottom: false,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SvgPicture.asset(
                SvgAssets.pinBackground,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Gap(20.h),
                    SvgPicture.asset(SvgAssets.logoBlue, height: 60.h),
                    Gap(40.h),
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [PinBox()],
                      ),
                    ),
                    Gap(40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
