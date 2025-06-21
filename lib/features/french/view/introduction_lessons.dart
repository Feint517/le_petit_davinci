import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button_main.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/core/widgets/subheader.dart';
import 'package:le_petit_davinci/features/french/view/lessons.dart';

class IntroductionFrenchLessons extends StatefulWidget {
  const IntroductionFrenchLessons({super.key});

  @override
  State<IntroductionFrenchLessons> createState() =>
      _IntroductionFrenchLessonsState();
}

class _IntroductionFrenchLessonsState extends State<IntroductionFrenchLessons> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bluePrimary,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SizedBox(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: SvgPicture.asset(
                      SvgAssets.games_background,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomNavBar(
                        variant: BadgeVariant.french,
                      ),
                      SubHeader(paragraph: "", color: AppColors.secondary),
                      Center(
                        child: SvgPicture.asset(
                          SvgAssets.beargames,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Text(
                          "🌼 Bienvenue dans le coin des leçons! Ici, on apprendra ensemble le français.",
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CustomButtonNew(
                        buttonColor: AppColors.bluePrimary,
                        shadowColor: AppColors.bluePrimaryDark,
                        label: 'Commencer',
                        labelColor: AppColors.background,
                        onPressed: () {
                          Get.to(
                            () => const FrenchLessons(),
                            duration: const Duration(milliseconds: 500),
                            transition: Transition.rightToLeft,
                          );
                        },
                        icon: Icons.arrow_outward_rounded,
                        iconColor: AppColors.backgroundLight,
                        width: 200,
                      ),
                      Gap(10),
                    ],
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
