import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';

class LessonBadge extends StatelessWidget {
  const LessonBadge({
    super.key,
    required this.badgeType,
    required this.badgeVariant,
  });

  final LessonBadgeType badgeType;
  final BadgeVariant badgeVariant;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      height: 40,
      margin: const EdgeInsets.only(
        left: 40, //? Added this line to compensate for overflow
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: _getBadgeColor(badgeVariant),
        boxShadow: [
          BoxShadow(
            color: _getBadgeColor(badgeVariant).withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -55,
            top: -10,
            bottom: -10,
            child: _getBadgeIcon(badgeType),
          ),
          Center(
            child: Text(switch (badgeType) {
              LessonBadgeType.soundMaster => 'Maître des sons',
              LessonBadgeType.phrasesBuilder => 'Architecte de phrases',
              LessonBadgeType.mistakesFinder => 'Chasseur de fautes',
              LessonBadgeType.additionMaster => 'Maître des additions',
              LessonBadgeType.substractionMaster => 'Maître des soustractions',
              LessonBadgeType.formesMaster => 'Maître des formes',
            }, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Color _getBadgeColor(BadgeVariant badgeVariant) {
    switch (badgeVariant) {
      case BadgeVariant.french:
        return AppColors.primary;
      case BadgeVariant.math:
        return AppColors.secondary;
      case BadgeVariant.english:
        return AppColors.accent;
      case BadgeVariant.dailyLife:
        return AppColors.accent3;
      case BadgeVariant.games:
        return AppColors.secondary;
    }
  }

  Widget _getBadgeIcon(LessonBadgeType badgeType) {
    switch (badgeType) {
      case LessonBadgeType.soundMaster:
        return ResponsiveSvgAsset(assetPath: SvgAssets.headsetBlue, width: 80);
      case LessonBadgeType.phrasesBuilder:
        return ResponsiveSvgAsset(assetPath: SvgAssets.chatPink, width: 80);
      case LessonBadgeType.mistakesFinder:
        return ResponsiveSvgAsset(
          assetPath: SvgAssets.magnifierPurple,
          width: 80,
        );
      case LessonBadgeType.additionMaster:
        return ResponsiveSvgAsset(assetPath: SvgAssets.micYellow, width: 80);
      case LessonBadgeType.substractionMaster:
        return ResponsiveSvgAsset(assetPath: SvgAssets.micYellow, width: 80);
      case LessonBadgeType.formesMaster:
        return ResponsiveSvgAsset(assetPath: SvgAssets.micYellow, width: 80);
    }
  }
}
