import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';

class FinishChercheLerreur extends StatefulWidget {
  const FinishChercheLerreur({super.key});

  @override
  State<FinishChercheLerreur> createState() => _FinishChercheLerreurState();
}

class _FinishChercheLerreurState extends State<FinishChercheLerreur> {
  // Inject the controller
  // Get.put() initializes the controller if it hasn't been already.
  // Using Get.find() if you know it's already been initialized elsewhere (e.g., GetX bi

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
                    spacing: 20,
                    children: [
                      const CustomNavBar(
                        variant: BadgeVariant.french,
                      ),
                      Gap(20),
                      Text(
                        '🎉 Hourra, votre réponse est correcte !',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColors.backgroundLight,
                        ),
                      ),
                      Center(
                        child: SvgPicture.asset(
                          SvgAssets.bear1,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Gap(20),
                      Column(
                        spacing: 10,
                        children: [
                          Center(
                            child: SvgPicture.asset(
                              SvgAssets.stars,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SvgPicture.asset(
                            SvgAssets.chasseursDesFautes,
                            fit: BoxFit.cover,
                            width: context.width / 2,
                          ),
                        ],
                      ),
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
