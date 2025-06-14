import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';
import '../../../core/constants/assets_manager.dart';
import '../models/reward_data.dart';
import 'reward_cards/stars_card.dart';
import 'reward_cards/badges_card.dart';
import 'reward_cards/titles_card.dart';
import 'reward_cards/cta_card.dart';

class RewardsSection extends StatelessWidget {
  const RewardsSection({super.key});

  static const List<BadgeData> mockBadges = [
    BadgeData(assetPath: SvgAssets.badge, name: 'Premier pas', isEarned: true),
    BadgeData(assetPath: SvgAssets.badge, name: 'Explorateur', isEarned: true),
    BadgeData(
      assetPath: SvgAssets.badge,
      name: 'Maître des mots',
      isEarned: true,
    ),
    BadgeData(
      assetPath: SvgAssets.badge,
      name: 'Génie mathématique',
      isEarned: false,
    ),
  ];

  static const List<SubjectTitleData> mockTitles = [
    SubjectTitleData(titleName: 'Explorateur des mots', isAchieved: true),
    SubjectTitleData(titleName: 'Petit génie', isAchieved: true),
    SubjectTitleData(titleName: 'Champion de lecture', isAchieved: true),
    SubjectTitleData(titleName: 'Maître des calculs', isAchieved: false),
    SubjectTitleData(titleName: 'Expert en anglais', isAchieved: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeading(sectionName: 'Mes récompenses'),
          Gap(20.h),

          //* Stars card
          StarsCard(totalStars: 247, starsThisWeek: 15),
          Gap(16.h),

          //* Badges card
          BadgesCard(earnedBadges: mockBadges),
          Gap(16.h),

          //* Titles card
          TitlesCard(subjectTitles: mockTitles, progressValue: 0.65),
          Gap(16.h),

          //* CTA card
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
}
