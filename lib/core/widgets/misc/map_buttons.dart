import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';

class MapButton extends StatelessWidget {
  const MapButton({
    super.key,
    required this.title,
    required this.iconPath,
    required this.backgroundColor,
    this.levelStatus = LevelStatus.inProgress,
    this.width = 70,
    this.height = 70,
    this.onTap,
  });

  final String title;
  final String iconPath;
  final Color backgroundColor;
  final double width;
  final double height;
  final VoidCallback? onTap;
  final LevelStatus levelStatus;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        spacing: 6,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: CustomShadowStyle.customCircleShadows(
                    color: backgroundColor,
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    height: height * 0.6,
                    width: width * 0.6,
                  ),
                ),
              ),
              //*  Status icon (top right, slightly outside)
              Positioned(
                top: 0,
                right: -5,
                child: switch (levelStatus) {
                  LevelStatus.completed => SvgPicture.asset(
                    SvgAssets.check,
                    height: 20,
                    width: 20,
                  ),
                  LevelStatus.inProgress => SvgPicture.asset(
                    SvgAssets.play,
                    height: 20,
                    width: 20,
                  ),
                  LevelStatus.notStarted => const SizedBox(),
                },
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
