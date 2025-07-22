import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/loaders/shimmer.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/french/controller/video_lesson_controller.dart';
import 'package:le_petit_davinci/features/french/view/video_player_screen.dart';

class VideoLessonScreen extends GetView<VideoLessonController> {
  const VideoLessonScreen({super.key, required this.videoId});

  final String videoId;

  @override
  Widget build(BuildContext context) {
    Get.put(VideoLessonController(videoId: videoId));
    return Scaffold(
      appBar: ProfileHeader(type: ProfileHeaderType.compact),
      backgroundColor: AppColors.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(AppSizes.md),
            Text(
              'Welcome to today\'s video lesson!',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
            const Gap(AppSizes.md),
            Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    ResponsiveImageAsset(
                      assetPath: SvgAssets.peakingMascot,
                      width: DeviceUtils.getScreenWidth() * 0.4,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(AppSizes.md),
                  width: DeviceUtils.getScreenWidth(),
                  height: 200,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSizes.sm),
                    boxShadow: CustomShadowStyle.customCircleShadows(
                      color: AppColors.white,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () =>
                                (controller.isLoading.value)
                                    ? const CustomShimmerEffect(
                                      width: 161,
                                      height: 25,
                                    )
                                    : Expanded(
                                      child: Text(
                                        controller.videoTitle.value,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                    ),
                          ),
                          GestureDetector(
                            onTap:
                                () => Get.to(
                                  () => VideoPlayerScreen(
                                    videoId: controller.videoId,
                                    videoTitle: controller.videoTitle.value,
                                  ),
                                ),
                            child: Icon(
                              Icons.play_circle_fill,
                              color: AppColors.primary,
                              size: 60,
                            ),
                          ),
                        ],
                      ),
                      const Gap(AppSizes.sm),
                      Text(
                        'Instructors will guide you through the lesson.',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.darkGrey,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'November 1, 2023',
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(color: AppColors.darkGrey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            'Duration: 10 mins',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(color: AppColors.darkGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
