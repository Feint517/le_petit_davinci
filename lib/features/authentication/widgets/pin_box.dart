import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/features/authentication/views/login.dart';
import 'package:le_petit_davinci/features/home/views/home.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinBox extends StatelessWidget {
  const PinBox({super.key, this.isExpanded = false});

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width:
          isExpanded
              ? DeviceUtils.getScreenWidth()
              : DeviceUtils.getScreenWidth() * 0.85,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.pinkAccent,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: CustomShadowStyle.customCircleShadows(
          color: AppColors.pinkAccent,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            StringsManager.enterPinCode,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall!.apply(color: AppColors.white),
            textAlign: TextAlign.center,
          ),
          Gap(AppSizes.spaceBtwSections),
          PinCodeTextField(
            appContext: context,
            length: 4,
            onChanged: (value) {},
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(8),
              fieldHeight: 55,
              fieldWidth: 55,
              activeFillColor: AppColors.white,
              inactiveFillColor: AppColors.white,
              selectedFillColor: AppColors.white,
              activeColor: AppColors.primary,
              selectedColor: AppColors.primary,
              inactiveColor: AppColors.white,
            ),
            enableActiveFill: true,
          ),
          Gap(24.h),
          CustomButton(
            label: StringsManager.connectWithPin,
            onPressed: () => Get.to(() => const LoginScreen()),
            size: ButtonSize.lg,
          ),

          const Gap(AppSizes.spaceBtwItems),

          GestureDetector(
            onTap: () => Get.to(() => const HomeScreen()),
            child: Text(
              StringsManager.forgotPassword,
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: AppColors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
