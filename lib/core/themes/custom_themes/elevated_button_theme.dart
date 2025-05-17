import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class CustomElevatedButtonTheme {
  CustomElevatedButtonTheme._();

  //*light theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.black,
      backgroundColor: AppColors.buttonPrimary,
      disabledForegroundColor: AppColors.grey,
      disabledBackgroundColor: AppColors.grey,
      minimumSize: Size(130, 40),
      padding: EdgeInsets.symmetric(horizontal: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(width: 0, color: Colors.transparent),
      ),
    ),
  );

  //*dark theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.black,
      backgroundColor: AppColors.buttonPrimary,
      disabledForegroundColor: AppColors.grey,
      disabledBackgroundColor: AppColors.grey,
      minimumSize: Size(130, 40),
      padding: EdgeInsets.symmetric(horizontal: 16),
      textStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(width: 0, color: Colors.transparent),
      ),
    ),
  );
}
