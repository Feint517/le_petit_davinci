import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors.dart';
import '../models/reward_data.dart';
import 'reward_cards/stars_card.dart';
import 'reward_cards/badges_card.dart';
import 'reward_cards/titles_card.dart';
import 'reward_cards/cta_card.dart';

class RewardsSection extends StatelessWidget {
  const RewardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main title
          Text(
            'Mes récompenses',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'DynaPuff_SemiCondensed',
            ),
          ),
          
          Gap(20.h),
          
          // Stars card
          StarsCard(
            totalStars: 247,
            starsThisWeek: 15,
          ),
          
          Gap(16.h),
          
          // Badges card
          BadgesCard(
            earnedBadges: _getMockBadges(),
          ),
          
          Gap(16.h),
          
          // Titles card
          TitlesCard(
            subjectTitles: _getMockTitles(),
            progressValue: 0.65,
          ),
          
          Gap(16.h),
          
          // CTA card
          CTACard(
            promptText: 'Encore 2 exercices pour devenir Génie du calcul !',
            onButtonPressed: () {
              // TODO: Navigate to specific exercise/mission
              print('Continue to next mission pressed');
            },
          ),
        ],
      ),
    );
  }

  List<BadgeData> _getMockBadges() {
    return [
      const BadgeData(
        assetPath: SvgAssets.badge,
        name: 'Premier pas',
        isEarned: true,
      ),
      const BadgeData(
        assetPath: SvgAssets.badge,
        name: 'Explorateur',
        isEarned: true,
      ),
      const BadgeData(
        assetPath: SvgAssets.badge,
        name: 'Maître des mots',
        isEarned: true,
      ),
      const BadgeData(
        assetPath: SvgAssets.badge,
        name: 'Génie mathématique',
        isEarned: false,
      ),
    ];
  }

  List<SubjectTitleData> _getMockTitles() {
    return [
      const SubjectTitleData(
        titleName: 'Explorateur des mots',
        isAchieved: true,
      ),
      const SubjectTitleData(
        titleName: 'Petit génie',
        isAchieved: true,
      ),
      const SubjectTitleData(
        titleName: 'Champion de lecture',
        isAchieved: true,
      ),
      const SubjectTitleData(
        titleName: 'Maître des calculs',
        isAchieved: false,
      ),
      const SubjectTitleData(
        titleName: 'Expert en anglais',
        isAchieved: false,
      ),
    ];
  }
}