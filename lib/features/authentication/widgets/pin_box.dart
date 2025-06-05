import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/authentication/views/error_page.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinBox extends StatelessWidget {
  const PinBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: DeviceUtils.getScreenHeight() * 0.85,
      constraints: BoxConstraints(
        maxWidth: 400.w,
        minWidth: 280.w,
      ),
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
          SizedBox(
            width: 240.w,
            child: PinCodeTextField(
              appContext: context,
              length: 4,
              onChanged: (value) {},
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8.r),
                fieldHeight: 50.h,
                fieldWidth: 50.w,
                activeFillColor: Colors.grey[100]!,
                inactiveFillColor: Colors.grey[100]!,
                selectedFillColor: Colors.white,
                activeColor: Colors.deepPurple,
                selectedColor: Colors.deepPurple,
                inactiveColor: Color(0XffF9FAFB),
              ),
              enableActiveFill: true,
            ),
          ),
          Gap(24.h),
    
          //* Submit button
          CustomButton(
            label: StringsManager.connectWithPin,
            onPressed:
                () => Get.to(() => const ErrorPage()),
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
    );
  }
}