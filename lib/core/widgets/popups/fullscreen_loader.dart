import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/loaders/animation_loader.dart';

class CustomFullscreenLoader {
  static void openLoadingDialog(String text, String animation) {
    showGeneralDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder:
          (_, __, ___) => PopScope(
            canPop: false,
            child: Container(
              color:
                  DeviceUtils.isDarkMode(Get.context!)
                      ? AppColors.darkerGrey
                      : AppColors.white,
              width: DeviceUtils.getScreenWidth(),
              height: DeviceUtils.getScreenHeight(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomAnimationLoader(text: text, animation: animation),
                ],
              ),
            ),
          ),
    );
  }

  static stopLoading() {
    Navigator.of(
      Get.overlayContext!,
    ).pop(); //? close the dialog using the navigator
  }
}
