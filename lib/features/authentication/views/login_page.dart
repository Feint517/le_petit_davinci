import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/widgets/buttons.dart';
import 'package:le_petit_davinci/core/widgets/text_fields/custom_text_field.dart';
import 'package:le_petit_davinci/features/authentication/views/kids_selection.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                SvgAssets.loginBackground,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
            ),
            Column(
              children: [
                SvgPicture.asset(SvgAssets.logoBlue, height: 60.h),
                Gap(40),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //* Instruction text
                      Text(
                        StringsManager.loginText,
                        style: TextStyle(
                          fontSize: 30.sp,
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'DynaPuff_SemiCondensed',
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            StringsManager.newHere,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DynaPuff_SemiCondensed',
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              StringsManager.createParentAccount,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.accent,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'DynaPuff_SemiCondensed',
                              ),
                            ),
                          ),
                        ],
                      ),

                      Gap(24.h),

                      CustomTextField(
                        type: TextFieldType.email,
                        controller: TextEditingController(),
                      ),
                      Gap(24.h),
                      CustomTextField(
                        type: TextFieldType.password,
                        controller: TextEditingController(),
                      ),
                      Gap(24.h),

                      //* Login button
                      CustomButton(
                        onPressed: () {
                          Get.to(
                            () => KidsSelection(),
                            transition: Transition.rightToLeft,
                            duration: const Duration(milliseconds: 500),
                          );
                        },
                        label: StringsManager.connect,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
