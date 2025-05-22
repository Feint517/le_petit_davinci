import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons.dart';
import 'package:le_petit_davinci/core/widgets/pill_button.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Home',
              style: TextStyle(
                fontFamily: 'DynaPuff_SemiCondensed',
                fontSize: 42,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 32),
            PillButton(
              label: 'Go to Login',
              variant: ButtonVariant.secondary,
              onPressed: () => Get.toNamed(AppRoutes.login),
            ),
          ],
        ),
      ),
    );
  }
}