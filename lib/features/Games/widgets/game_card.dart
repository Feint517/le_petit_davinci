import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
    required this.cardColor,
    required this.label,
    required this.title,
    this.onTap,
    required this.assetPath,
  });

  final Color cardColor;
  final int label;
  final String title;
  final String assetPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.alphaBlend(
              Colors.black.withValues(alpha: 0.3),
              cardColor,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
            child: Text(
              '$label victroires',
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
            color: cardColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
            boxShadow: CustomShadowStyle.customCircleShadows(color: cardColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              SizedBox(
                width: 70,
                height: 70,
                child: ResponsiveImageAsset(assetPath: assetPath, width: 70),
              ),
              Text(
                title,
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
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
