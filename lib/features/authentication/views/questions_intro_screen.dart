import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class QuestionsIntroScreen extends StatelessWidget {
  const QuestionsIntroScreen({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            // Arrière-plan
            Positioned.fill(
              child: Image.asset(ImageAssets.masscotbg, fit: BoxFit.cover),
            ),

            // Contenu principal
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Message bulle en haut (à l'extérieur de la carte blanche)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 24.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontFamily: 'DynaPuff_SemiCondensed',
                        height: 1.3,
                      ),
                    ),
                  ),

                  Gap(20.h),

                  // Carte blanche contenant la mascotte et le bouton
                  Container(
                    width: 350.w,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 6),
                          blurRadius: 10,
                          color: Colors.black.withAlpha(20),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(SvgAssets.bearMasscot, height: 180.h),

                        Gap(24.h),

                        // Bouton "Je suis prêt!"
                        PillButton(
                          label: 'Je suis prêt !',
                          icon: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          iconPosition: IconPosition.right,
                          variant: ButtonVariant.secondary,
                          size: ButtonSize.lg,
                          width: double.infinity,
                          onPressed: () {
                            Get.offAndToNamed(AppRoutes.userSelection);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
