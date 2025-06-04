import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons.dart';
import 'package:le_petit_davinci/core/widgets/mascot_widget.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

/// Écran d'introduction aux questions avec la mascotte DaVinci
class QuestionsIntroScreen extends StatelessWidget {
  const QuestionsIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Fond d'écran
            Positioned.fill(
              child: Image.asset(
                ImageAssets.masscotbg,
                fit: BoxFit.cover,
                semanticLabel: 'Fond avec mascotte',
              ),
            ),
            
            // Logo en haut
            Positioned(
              top: 40.h,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 24.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Le Petit Davinci',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DynaPuff_SemiCondensed',
                    ),
                  ),
                ],
              ),
            ),

            // Contenu principal
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    
                    // Zone blanche avec mascotte
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
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
                        children: [
                          // Mascotte avec bulle
                          MascotWidget(
                            speechText: "Avant de commencer ton aventure, j'ai 5 petites questions pour mieux te "
                                "connaître\n\nEt pendant que tu réponds, je vais bouger et te faire coucou !",
                            bubbleColor: AppColors.bluePrimary,
                            mascotSize: 180.h,
                            maxBubbleWidth: 350.w,
                            textSize: 18.sp,
                          ),
                          
                          Gap(30.h),
                          
                          // Bouton "Je suis prêt!"
                          PillButton(
                            label: 'Je suis prêt !',
                            icon: Icon(Icons.arrow_forward, color: Colors.white),
                            iconPosition: IconPosition.right,
                            variant: ButtonVariant.secondary,
                            size: ButtonSize.lg,
                            width: 280.w,
                            onPressed: () => Get.toNamed(AppRoutes.userSelection),
                          ),
                        ],
                      ),
                    ),
                    
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
