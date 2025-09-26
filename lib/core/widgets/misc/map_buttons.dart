// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/styles/loaders.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/data/models/lessons&exercises/level_model.dart';

class MapButton extends StatelessWidget {
  const MapButton({
    super.key,
    this.title,
    required this.iconPath,
    required this.backgroundColor,
    required this.level,
    this.dimension = 70.0,
    this.onTap,
  });

  final String? title;
  final String iconPath;
  final Color backgroundColor;
  final double dimension;
  final VoidCallback? onTap;
  final Level level;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            if (level.levelStatus != LevelStatus.locked) {
              level.onTap?.call();
            } else {
              CustomLoaders.showSnackBar(
                type: SnackBarType.warning,
                title: 'Level locked',
                message: 'Complete the previous level to unlock it',
              );
            }
          },
      child: Column(
        spacing: 6,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: dimension,
                height: dimension,
                decoration: BoxDecoration(
                  color:
                      level.levelStatus == LevelStatus.locked
                          ? Colors.grey
                          : level.levelStatus == LevelStatus.completed
                          ? AppColors.accent2
                          : backgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: CustomShadowStyle.customCircleShadows(
                    color:
                        level.levelStatus == LevelStatus.locked
                            ? Colors.grey
                            : level.levelStatus == LevelStatus.completed
                            ? AppColors.accent2
                            : backgroundColor,
                  ),
                ),
                child:
                    (level.levelStatus == LevelStatus.locked ||
                            level.levelStatus == LevelStatus.completed)
                        ? Stack(
                          children: [
                            Center(
                              child: ResponsiveImageAsset(
                                assetPath: iconPath,
                                width: dimension * 0.7,
                                filtered: true,
                                filterColor:
                                    (level.levelStatus == LevelStatus.locked)
                                        ? Colors.grey
                                        : AppColors.accent2,
                              ),
                            ),
                            if (level.levelStatus == LevelStatus.locked)
                              Center(
                                child: ResponsiveImageAsset(
                                  assetPath: IconAssets.lock,
                                  width: dimension * 0.3,
                                ),
                              ),
                          ],
                        )
                        : Center(
                          child: SvgPicture.asset(
                            iconPath,
                            height: dimension * 0.6,
                            width: dimension * 0.6,
                          ),
                        ),
              ),
              //*  Status icon (top right, slightly outside)
              Positioned(
                top: 0,
                right: -5,
                child: switch (level.levelStatus) {
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
                  LevelStatus.locked => const SizedBox(),
                },
              ),
            ],
          ),
          if (title != null)
            Text(
              title!,
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
