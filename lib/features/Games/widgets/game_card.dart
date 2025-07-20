import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/features/Games/models/game_model.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    // required this.cardColor,
    // required this.label,
    // required this.title,
    // this.onTap,
    // required this.assetPath,
    required this.gameModel,
  });

  // final Color cardColor;
  // final int label;
  // final String title;
  // final String assetPath;
  // final VoidCallback? onTap;
  final GameModel gameModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.alphaBlend(
              Colors.black.withValues(alpha: 0.3),
              gameModel.color,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text(
              '${gameModel.numOfVictories} victoires',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: gameModel.color,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            boxShadow: CustomShadowStyle.customCircleShadows(
              color: gameModel.color,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: ResponsiveImageAsset(
                  assetPath: gameModel.icon,
                  width: 70,
                ),
              ),
              Text(
                gameModel.name,
                style: TextStyle(
                  color: AppColors.background,
                  fontSize: 16,
                  fontWeight: FontWeight.w100,
                ),
              ),
              // CustomButtonNew(
              //   buttonColor: AppColors.secondary,
              //   shadowColor: AppColors.orangeAccentDark,
              //   label: 'Jouer',
              //   labelColor: AppColors.background,
              // ),
              CustomButton(
                label: 'Jouer',
                variant: ButtonVariant.secondary,
                onPressed: () {
                  Get.to(() => gameModel.gameScreen);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
