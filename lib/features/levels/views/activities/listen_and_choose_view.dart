import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/features/levels/models/activities/listen_and_choose_activity.dart';
import 'package:le_petit_davinci/features/levels/controllers/level_controller.dart';
import 'package:le_petit_davinci/features/levels/widgets/play_audio_button.dart';
import 'package:le_petit_davinci/features/levels/widgets/activity_intro_wrapper.dart';

class ListenAndChooseView extends StatelessWidget {
  const ListenAndChooseView({super.key, required this.activity});

  final ListenAndChooseActivity activity;

  @override
  Widget build(BuildContext context) {
    return ActivityIntroWrapper(
      activity: _buildMainContent(),
      mascotMixin: activity,
      // startButtonText: 'Start Exercise',
      // onStartPressed: () {
      //   activity.isIntroCompleted.value = true;
      // },
    );
  }

  Widget _buildMainContent() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CustomGridLayout(
              itemCount: activity.imageAssets.length,
              spacing: AppSizes.gridViewSpacing * 2,
              itemBuilder: (context, index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () => activity.selectOption(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.all(AppSizes.sm),
                      decoration: BoxDecoration(
                        color:
                            activity.selectedIndex.value == index
                                ? Color(0xFFe1f4ff)
                                : AppColors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: CustomShadowStyle.customCircleShadows(
                          color:
                              activity.selectedIndex.value == index
                                  ? AppColors.primary
                                  : AppColors.grey,
                        ),
                        border: Border.all(
                          color:
                              activity.selectedIndex.value == index
                                  ? AppColors.primary
                                  : AppColors.grey,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 120,
                        height: 120,
                        child: ResponsiveImageAsset(
                          assetPath: activity.imageAssets[index],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
            PlayAudioButton(
              buttonSize: PlayAudioButtonSize.big,
              onPressed: () => Get.find<LevelController>().playCurrentAudio(),
            ),
          ],
        ),
        const Gap(AppSizes.spaceBtwSections),
        Obx(() {
          // Cast the activity to access its specific properties
          final listenActivity = activity;
          return AnimatedOpacity(
            // Read the state directly from the activity model
            opacity: listenActivity.showHint.value ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 400),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  activity.label,
                  style: Get.textTheme.headlineSmall?.copyWith(
                    color: AppColors.accent,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
