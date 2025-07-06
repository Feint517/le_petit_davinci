import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';

enum SnackBarType { succes, warning, error }

class CustomLoaders {
  static hideSnackBar() =>
      ScaffoldMessenger.of(Get.context!).hideCurrentMaterialBanner();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color:
                DeviceUtils.isDarkMode(Get.context!)
                    ? AppColors.primary.withValues(alpha: 0.9)
                    : AppColors.accent.withValues(alpha: 0.9),
          ),
          child: Center(
            child: Text(
              message,
              style: Theme.of(
                Get.context!,
              ).textTheme.bodyMedium!.apply(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }

  static showSnackBar({
    required SnackBarType type,
    required String title,
    String message = '',
    Color? backgroundColor,
    Widget? icon,
    Color? iconColor,
    duration = 3,
  }) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.white,
      backgroundColor: switch (type) {
        SnackBarType.succes => backgroundColor ?? AppColors.primary,
        SnackBarType.warning => backgroundColor ?? Colors.orange,
        SnackBarType.error => backgroundColor ?? Colors.red.shade600,
      },
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: switch (type) {
        SnackBarType.succes =>
          icon ?? Icon(Iconsax.check, color: iconColor ?? AppColors.white),
        SnackBarType.warning =>
          icon ?? Icon(Iconsax.warning_2, color: iconColor ?? AppColors.white),
        SnackBarType.error =>
          icon ?? Icon(Iconsax.warning_2, color: iconColor ?? AppColors.white),
      },
    );
  }
}
