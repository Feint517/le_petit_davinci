import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/date_utils.dart';
import 'package:le_petit_davinci/core/widgets/badges/circular_badge.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/core/widgets/misc/profile_header.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/features/rewards/controllers/rewards_controller.dart';
import 'package:le_petit_davinci/features/rewards/widgets/day_tile.dart';
import 'package:le_petit_davinci/features/rewards/widgets/info_display_section.dart';
import 'package:le_petit_davinci/features/rewards/widgets/message_section.dart';
import 'package:le_petit_davinci/features/rewards/widgets/popup_dialog.dart';
import 'package:le_petit_davinci/features/rewards/widgets/selection_tile.dart';
import 'package:le_petit_davinci/features/rewards/widgets/title_display.dart';

class RewardsScreen extends GetView<RewardsController> {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: ProfileHeader(
        userName: 'Alex',
        userClass: 'Classe 2',
        changeAvatar: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultSpace,
          ),
          child: Column(
            children: [
              const Divider(color: AppColors.grey, thickness: 1.5),
              const CustomNavBar(activeChip: false),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mes Récompenses',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const ResponsiveSvgAsset(
                    assetPath: SvgAssets.happyGift,
                    width: 60,
                  ),
                ],
              ),
              const Gap(AppSizes.spaceBtwSections),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(
                      () => SelectionTile(
                        text: 'Mes Étoiles',
                        backgroundColor: AppColors.primary,
                        isSelected:
                            controller.selectedSection.value ==
                            SectionType.stars,
                        onTap:
                            () =>
                                controller.selectedSection.value =
                                    SectionType.stars,
                      ),
                    ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: Obx(
                      () => SelectionTile(
                        text: 'Mes Badges',
                        backgroundColor: AppColors.accent,
                        isSelected:
                            controller.selectedSection.value ==
                            SectionType.badges,
                        onTap:
                            () =>
                                controller.selectedSection.value =
                                    SectionType.badges,
                      ),
                    ),
                  ),
                  Gap(12.w),
                  Expanded(
                    child: Obx(
                      () => SelectionTile(
                        text: 'Mes Titres',
                        backgroundColor: AppColors.accent2,
                        isSelected:
                            controller.selectedSection.value ==
                            SectionType.titles,
                        onTap:
                            () =>
                                controller.selectedSection.value =
                                    SectionType.titles,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(AppSizes.spaceBtwSections),

              Obx(() {
                switch (controller.selectedSection.value) {
                  case SectionType.stars:
                    return StarsSection();
                  case SectionType.badges:
                    return BadgesSection(
                      columns: 4,
                      rows: 7,
                      badgeVariants: [
                        BadgeVariant.french,
                        BadgeVariant.math,
                        BadgeVariant.english,
                        BadgeVariant.dailyLife,
                      ],
                      unlockedRowsPerColumn: [5, 5, 4, 4],
                    );
                  case SectionType.titles:
                    return TitlesSection();
                }
              }),
              const Gap(AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}

class StarsSection extends GetView<RewardsController> {
  const StarsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const InfoDisplaySection(stars: 16),
        const Gap(AppSizes.spaceBtwItems),

        const MessageSection(
          message:
              "Si tu gagnes 5 étoiles d'ici vendredi, tu débloques un badge surprise !",
        ),
        const Gap(AppSizes.spaceBtwSections),

        CustomGridLayout(
          mainAxisExtent: 90,
          itemCount: 7,
          itemBuilder: (_, index) {
            final starsPerDay = [3, 4, 1, 3, 2, 2, 2];
            final colorsPerDay = [
              AppColors.accent2,
              AppColors.accent3,
              AppColors.accent,
              AppColors.secondary,
              AppColors.primary,
              AppColors.accent2,
              AppColors.accent3,
            ];
            final activePerDay = [true, true, true, false, false, false, false];
            return DayTile(
              label: DateUtilsHelper.getWeekDayNames()[index],
              starsCount: starsPerDay[index],
              backgroundColor: colorsPerDay[index],
              isActive: activePerDay[index],
            );
          },
        ),
      ],
    );
  }
}

class BadgesSection extends GetView<RewardsController> {
  const BadgesSection({
    super.key,
    required this.columns,
    required this.rows,
    required this.badgeVariants,
    required this.unlockedRowsPerColumn,
  });

  final int columns;
  final int rows;
  final List<BadgeVariant> badgeVariants;
  final List<int> unlockedRowsPerColumn;

  @override
  Widget build(BuildContext context) {
    assert(badgeVariants.length == columns);
    assert(unlockedRowsPerColumn.length == columns);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(columns, (colIndex) {
        return Expanded(
          child: SizedBox(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: rows,
              separatorBuilder: (_, _) => const Gap(AppSizes.spaceBtwItems),
              itemBuilder: (context, rowIndex) {
                final unlocked = rowIndex < unlockedRowsPerColumn[colIndex];
                return CircularBadge(
                  variant: badgeVariants[colIndex],
                  unlocked: unlocked,
                  onTap:
                      () => showDialog(
                        context: context,
                        builder:
                            (context) => Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const PopupDialog(
                                title: 'Maître des additions',
                                description:
                                    'Tu as réussi 10 exercices de calcul mental !',
                                variant: BadgeVariant.dailyLife,
                              ),
                            ),
                      ),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

class TitlesSection extends GetView<RewardsController> {
  const TitlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppSizes.spaceBtwSections,
      children: [
        const TitleDisplay(
          variant: BadgeVariant.french,
          title: 'Explorateur des mots',
          message: 'Encore 2 activités pour atteindre : Maître du langage !',
          currentLevel: 2,
          totalLevels: 5,
        ),
        const TitleDisplay(
          variant: BadgeVariant.math,
          title: 'Génie du calcul',
          message: 'Encore 2 activités pour atteindre : Maître du langage !',
          currentLevel: 2,
          totalLevels: 5,
        ),
        const TitleDisplay(
          variant: BadgeVariant.english,
          title: 'Maître du langage',
          message: 'Encore 2 activités pour atteindre : Maître du langage !',
          currentLevel: 2,
          totalLevels: 5,
        ),
        const TitleDisplay(
          variant: BadgeVariant.dailyLife,
          title: 'Aventurier du quotidien',
          message: 'Encore 2 activités pour atteindre : Maître du langage !',
          currentLevel: 2,
          totalLevels: 5,
        ),
      ],
    );
  }
}
