import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/widgets/buttons.dart';
import 'package:le_petit_davinci/features/authentication/controllers/pin_entry_controller.dart';
import 'package:le_petit_davinci/features/authentication/views/login_page.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

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
            Column(
              children: [
                SvgPicture.asset(SvgAssets.logo, height: 60.h),
                Gap(40),
                Center(
                  child: Container(
                    width: 320.w,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: AppColors.pinkAccent,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 8,
                          color: Colors.black.withAlpha(26),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Instruction text
                        Text(
                          StringsManager.enterPinCode,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'DynaPuff_SemiCondensed',
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gap(24.h),

                        //* PIN Input Boxes
                        // Obx(
                        //   () => Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: List.generate(
                        //       4,
                        //       (index) => Padding(
                        //         padding: EdgeInsets.symmetric(horizontal: 8.w),
                        //         child: PinInputBox(
                        //           value: controller.pin[index],
                        //           isFocused:
                        //               controller.currentIndex.value == index,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        PinCodeTextField(
                          appContext: context,
                          length: 4,
                          onChanged: (value) {},
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(8),
                            fieldHeight: 55,
                            fieldWidth: 55,
                            activeFillColor: Colors.grey[100]!,
                            inactiveFillColor: Colors.grey[100]!,
                            selectedFillColor: Colors.white,
                            activeColor: Colors.deepPurple,
                            selectedColor: Colors.deepPurple,
                            inactiveColor: Color(0XffF9FAFB),
                          ),
                          enableActiveFill: true,
                        ),
                        Gap(24.h),

                        //* Submit button
                        CustomButton(
                          label: StringsManager.connectWithPin,
                          //onPressed: () => Get.toNamed(Routes.HOME),
                          onPressed: () => Get.to(() => const LoginPage()),
                          variant: ButtonVariant.primary,
                          size: ButtonSize.lg,
                          width: double.infinity,
                        ),
                        Gap(16.h),

                        //* Forgot password link
                        GestureDetector(
                          onTap: () => Get.toNamed(Routes.HOME),
                          child: Text(
                            StringsManager.forgotPassword,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.white,
                              decoration: TextDecoration.underline,
                              fontFamily: 'DynaPuff_SemiCondensed',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: SvgPicture.asset(
                SvgAssets.pinBackground,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PinInputBox extends StatelessWidget {
  final String value;
  final bool isFocused;

  const PinInputBox({super.key, required this.value, required this.isFocused});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isFocused ? AppColors.bluePrimary : Colors.transparent,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          value.isEmpty ? '' : '•', // Show dot for entered digit
          style: TextStyle(fontSize: 24.sp, color: AppColors.black),
        ),
      ),
    );
  }
}
