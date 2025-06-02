import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/features/french/view/french_map_screen.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors.dart';
import '../models/subject_data.dart';
import 'subject_card.dart';

class SubjectSelection extends StatelessWidget {
  const SubjectSelection({super.key});

  @override
  Widget build(BuildContext context) {
    // Subject data list
    final List<SubjectData> subjects = [
      SubjectData(
        label: 'Français',
        imageAssetPath: SvgAssets.frenchCard,
        cardColor: AppColors.bluePrimary,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FrenchMapScreen()),
        ),
      ),
      SubjectData(
        label: 'English',
        imageAssetPath: SvgAssets.englishCard,
        cardColor: AppColors.greenPrimary,
        onTap: () => print('English selected'),
      ),
      SubjectData(
        label: 'Mathématiques',
        imageAssetPath: SvgAssets.mathCard,
        cardColor: AppColors.orangeAccent,
        onTap: () => print('Mathématiques selected'),
      ),
      SubjectData(
        label: 'Vie quotidienne',
        imageAssetPath: SvgAssets.lifeCard,
        cardColor: AppColors.purpleAccent,
        onTap: () => print('Vie quotidienne selected'),
      ),
      SubjectData(
        label: 'Jeux',
        imageAssetPath: SvgAssets.gameCard,
        cardColor: AppColors.pinkAccent,
        onTap: () => print('Jeux selected'),
      ),
      SubjectData(
        label: 'Studio',
        imageAssetPath: SvgAssets.studioCard,
        cardColor: AppColors.secondary,
        onTap: () => print('Studio selected'),
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            'Sélection des matières',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'DynaPuff_SemiCondensed',
            ),
          ),
          
          Gap(16.h),
          
          // Grid of subject cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            children: subjects.map((subject) => SubjectCard(
              label: subject.label,
              imageAssetPath: subject.imageAssetPath,
              cardColor: subject.cardColor,
              onTap: subject.onTap,
            )).toList(),
          ),
        ],
      ),
    );
  }
}