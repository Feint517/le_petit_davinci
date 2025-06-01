import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/text_strings.dart';
import 'package:le_petit_davinci/core/widgets/buttons.dart';
import 'package:le_petit_davinci/core/widgets/mascot_widget.dart';
import 'package:le_petit_davinci/features/authentication/controllers/user_selection_controller.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class UserSelectionPage extends GetView<UserSelectionController> {
  const UserSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupérer les arguments pour vérifier si nous devons afficher l'intro
    final args = Get.arguments as Map<String, dynamic>?;
    final showQuestionsIntro = args != null && args['showQuestionsIntro'] == true;
    final introMessage = args != null ? args['introMessage'] as String? : null;
    
    // Si nous devons afficher l'intro, montrer l'écran d'intro
    if (showQuestionsIntro && introMessage != null) {
      return _buildQuestionsIntroScreen(context, introMessage);
    }
    
    // Sinon, afficher l'écran de sélection utilisateur normal
    return _buildUserSelectionScreen(context);
  }
  
  // Écran d'introduction aux questions
  Widget _buildQuestionsIntroScreen(BuildContext context, String message) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Stack(
          children: [
            // Arrière-plan
            Positioned.fill(
              child: Image.asset(
                ImageAssets.masscotbg,
                fit: BoxFit.cover,
              ),
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
                      color: AppColors.bluePrimary,
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
                        // Mascotte seule (sans bulle)
                        SvgPicture.asset(
                          SvgAssets.bearMasscot,
                          height: 180.h,
                        ),
                        
                        Gap(24.h),
                        
                        // Bouton "Je suis prêt!"
                        PillButton(
                          label: 'Je suis prêt !',
                          icon: const Icon(Icons.arrow_forward, color: Colors.white),
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
  
  // Écran de sélection utilisateur original
  Widget _buildUserSelectionScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              Gap(20.h),
              SvgPicture.asset(SvgAssets.logoBlue, height: 60.h),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SvgAssets.choose, height: 300.h)
                        .animate(
                          onPlay:
                              (controller) => controller.repeat(reverse: true),
                        )
                        .moveY(
                          begin: 0,
                          end: -10,
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                        ),
                    Gap(40.h),
                    // Question text
                    Text(
                      StringsManager.whoUsesApp,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontFamily: 'DynaPuff_SemiCondensed',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Buttons at the bottom
              Column(
                children: [
                  CustomButton(
                    label: StringsManager.iAmParent,
                    onPressed: controller.onParentSelected,
                    variant: ButtonVariant.primary,
                    size: ButtonSize.lg,
                    width: double.infinity,
                  ),
                  Gap(16.h),
                  CustomButton(
                    label: StringsManager.itsMyChild,
                    onPressed: controller.onChildSelected,
                    variant: ButtonVariant.secondary,
                    size: ButtonSize.lg,
                    width: double.infinity,
                  ),
                  Gap(20.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
