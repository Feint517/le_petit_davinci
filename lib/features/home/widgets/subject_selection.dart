// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';
import '../../../core/constants/assets_manager.dart';
import '../../../core/constants/colors.dart';
import '../models/subject_data.dart';
import 'subject_card.dart';

class SubjectSelection extends StatelessWidget {
  const SubjectSelection({super.key});

  @override
  Widget build(BuildContext context) {
    //* Subject data list
    final List<SubjectData> subjects = [
      SubjectData(
        label: 'Français',
        imageAssetPath: SvgAssets.frenchCard,
        cardColor: AppColors.bluePrimary,
        onTap: () => Get.toNamed(AppRoutes.home + AppRoutes.frenchMap),
      ),
      SubjectData(
        label: 'English',
        imageAssetPath: SvgAssets.englishCard,
        cardColor: AppColors.greenPrimary,
        onTap: () => Get.toNamed(AppRoutes.home + AppRoutes.englishMap),
      ),
      SubjectData(
        label: 'Mathématiques',
        imageAssetPath: SvgAssets.mathCard,
        cardColor: AppColors.orangeAccent,
        onTap: () => Get.toNamed(AppRoutes.home + AppRoutes.mathMap),
      ),
      SubjectData(
        label: 'Vie quotidienne',
        imageAssetPath: SvgAssets.gameCard,
        cardColor: AppColors.pinkAccent,
        onTap: () => Get.toNamed(AppRoutes.home + AppRoutes.dailyLifeMap),
      ),
      SubjectData(
        label: 'Jeux',
        imageAssetPath: SvgAssets.lifeCard,
        cardColor: AppColors.greenPrimary,
        onTap: () => Get.toNamed(AppRoutes.home + AppRoutes.games),
      ),

      SubjectData(
        label: 'Studio',
        imageAssetPath: SvgAssets.studioCard,
        cardColor: AppColors.bluePrimary,
        onTap: () => Get.toNamed(AppRoutes.home + AppRoutes.studio),
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Title
          const SectionHeading(sectionName: 'Sélection des matières'),
          Gap(16.h),

          //* Grid of subject cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            children:
                subjects
                    .map(
                      (subject) => SubjectCard(
                        label: subject.label,
                        imageAssetPath: subject.imageAssetPath,
                        cardColor: subject.cardColor,
                        onTap: subject.onTap,
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
