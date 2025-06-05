import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/authentication/widgets/header_message_box.dart';
import 'package:le_petit_davinci/features/authentication/widgets/informational_text_section.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class WelcomeStatusScreen extends StatelessWidget {
  const WelcomeStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //* Background image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SvgPicture.asset(
              SvgAssets.questionsFinishedBackground,
              width: 1.sw,
              height: 0.3.sh,
              fit: BoxFit.fill,
            ),
          ),

          //* Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.lg),
              child: Column(
                children: [
                  Gap(30.h),

                  const HeaderMessageBox(),

                  Gap(40.h),

                  const InformationalTextSection(),

                  Gap(60.h),

                  CustomButton(
                    variant: ButtonVariant.secondary,
                    label: StringsManager.discoverMySpace,
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16.sp,
                      color: AppColors.white,
                    ),
                    iconPosition: IconPosition.right,
                    onPressed: () {
                      Get.offAllNamed(AppRoutes.home);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
