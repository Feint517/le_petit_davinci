import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_svg_asset.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/features/rewards/controllers/rewards_controller.dart';
import 'package:le_petit_davinci/features/rewards/widgets/badges_section.dart';
import 'package:le_petit_davinci/features/rewards/widgets/category_row.dart';
import 'package:le_petit_davinci/features/rewards/widgets/stars_section.dart';
import 'package:le_petit_davinci/features/rewards/widgets/titles_section.dart';

class RewardsScreen extends GetView<RewardsController> {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(RewardsController());
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: ProfileHeader(
        userName: 'Alex',
        userClass: 'Classe 2',
        showTrailingIcon: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.defaultSpace,
          ),
          child: Column(
            children: [
              const Divider(color: AppColors.grey, thickness: 1.5),
              const CustomNavBar(applyPadding: false),
              AnimatedBuilder(
                animation: controller.animationController,
                builder: (_, __) {
                  return Opacity(
                    opacity: controller.fadeAnimations[0].value,
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        30 * (1 - controller.fadeAnimations[0].value),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Mes Récompenses',
                            style: Theme.of(context).textTheme.headlineMedium!
                                .copyWith(fontWeight: FontWeight.w500),
                          ),
                          const ResponsiveImageAsset(
                            assetPath: SvgAssets.happyGift,
                            width: 60,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const Gap(AppSizes.spaceBtwSections),

              AnimatedBuilder(
                animation: controller.animationController,
                builder: (_, __) {
                  return Opacity(
                    opacity: controller.fadeAnimations[1].value,
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        30 * (1 - controller.fadeAnimations[1].value),
                      ),
                      child: const CategoryRow(),
                    ),
                  );
                },
              ),
              const Gap(AppSizes.spaceBtwSections),

              AnimatedBuilder(
                animation: controller.animationController,
                builder: (_, __) {
                  return Opacity(
                    opacity: controller.fadeAnimations[2].value,
                    child: Transform.translate(
                      offset: Offset(
                        0,
                        30 * (1 - controller.fadeAnimations[2].value),
                      ),
                      child: Obx(() {
                        Widget section;
                        switch (controller.selectedSection.value) {
                          case SectionType.stars:
                            section = const StarsSection();
                            break;
                          case SectionType.badges:
                            section = const BadgesSection(
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
                            break;
                          case SectionType.titles:
                            section = const TitlesSection();
                            break;
                        }

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          transitionBuilder: (
                            Widget child,
                            Animation<double> animation,
                          ) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0.0, 0.05),
                                  end: Offset(0, 0),
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          child: KeyedSubtree(
                            key: ValueKey(controller.selectedSection.value),
                            child: section,
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
              const Gap(AppSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
