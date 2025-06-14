// You can place this in the same file or extract it if you want
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/badges/lesson_badge.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/app_bar.dart';
import 'package:le_petit_davinci/features/lessons/widget/lesson_info.dart';

class PracticeHeader extends StatelessWidget {
  final PracticeType type;
  const PracticeHeader({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    final String lessonName;
    final String lessonDescription;
    switch (type) {
      case PracticeType.listenAndMatch:
        {
          lessonName = 'Listen & Match';
          lessonDescription =
              'Associer un mot entendu à son image correspondante.';
        }
      case PracticeType.wordBuilder:
        {
          lessonName = 'Word Builder';
          lessonDescription =
              'Associer un mot entendu à son image correspondante.';
        }
      case PracticeType.findTheWord:
        {
          lessonName = 'Find the Word';
          lessonDescription =
              'Identifier un objet dans une scène visuelle après écoute.';
        }
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(DeviceUtils.getAppBarHeight()),
        const CustomNavBar(chipText: 'Anglais', chipColor: AppColors.accent),
        const Gap(AppSizes.spaceBtwSections),
        LessonInfo(
          lessonName: lessonName,
          lessonDescription: lessonDescription,
        ),
        const Gap(AppSizes.spaceBtwSections),
        const LessonBadge(
          label: 'Maître des sons',
          color: AppColors.accent,
          svgIconPath: SvgAssets.micPurple,
        ),
      ],
    );

    // switch (type) {
    //   case PracticeType.listenAndMatch:
    //     return Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Gap(DeviceUtils.getAppBarHeight()),
    //         const CustomAppBar(
    //           chipText: 'Anglais',
    //           chipColor: AppColors.accent,
    //         ),
    //         const Gap(AppSizes.spaceBtwSections),
    //         const LessonInfo(
    //           lessonName: 'Listen & Match',
    //           lessonDescription:
    //               'Associer un mot entendu à son image correspondante.',
    //         ),
    //         const Gap(AppSizes.spaceBtwSections),
    //         const LessonBadge(
    //           label: 'Maître des sons',
    //           color: AppColors.accent,
    //           svgIconPath: SvgAssets.micPurple,
    //         ),
    //       ],
    //     );
    //   case PracticeType.wordBuilder:
    //     return Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Gap(DeviceUtils.getAppBarHeight()),
    //         const CustomAppBar(
    //           chipText: 'Anglais',
    //           chipColor: AppColors.accent,
    //         ),
    //         const Gap(AppSizes.spaceBtwSections),
    //         const LessonInfo(
    //           lessonName: 'Word Builder',
    //           lessonDescription: 'Construis le mot entendu.',
    //         ),
    //         const Gap(AppSizes.spaceBtwSections),
    //         const LessonBadge(
    //           label: 'Bâtisseur de mots',
    //           color: AppColors.accent,
    //           svgIconPath: SvgAssets.micPurple,
    //         ),
    //       ],
    //     );
    //   case PracticeType.findTheWord:
    //     return Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Gap(DeviceUtils.getAppBarHeight()),
    //         const CustomAppBar(
    //           chipText: 'Français',
    //           chipColor: AppColors.accent,
    //         ),
    //         const Gap(AppSizes.spaceBtwSections),
    //         const LessonInfo(
    //           lessonName: 'Find The Word',
    //           lessonDescription: 'Trouve le mot caché.',
    //         ),
    //         const Gap(AppSizes.spaceBtwSections),
    //         const LessonBadge(
    //           label: 'Chercheur de mots',
    //           color: AppColors.accent,
    //           svgIconPath: SvgAssets.micPurple,
    //         ),
    //       ],
    //     );
    // }
  }
}
