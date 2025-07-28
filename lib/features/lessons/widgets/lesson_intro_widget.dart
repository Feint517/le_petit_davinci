import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/loaders/shimmer.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';
import 'package:le_petit_davinci/features/lessons/models/lesson_model.dart';
import 'package:le_petit_davinci/features/lessons/widgets/info_card.dart';
import 'package:le_petit_davinci/features/video_player/views/video_player.dart';

class LessonIntroWidget extends GetView<LessonController> {
  final LessonModel lesson;

  const LessonIntroWidget({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to today\'s lesson!',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(color: AppColors.black),
          ),
          const Gap(AppSizes.md),
          const VideoIntro(),
          const Gap(AppSizes.md),
          Row(
            children: [
              Expanded(
                child: InfoCard(
                  icon: Icons.play_circle_outline,
                  title:
                      lesson.language == LessonLanguage.french
                          ? 'Vidéo'
                          : 'Video',
                  subtitle: '6 min',
                ),
              ),
              Gap(16.w),
              Expanded(
                child: InfoCard(
                  icon: Icons.extension_outlined,
                  title:
                      lesson.language == LessonLanguage.french
                          ? 'Activités'
                          : 'Activities',
                  subtitle: '${lesson.totalActivities}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



class VideoIntro extends GetView<LessonController> {
  const VideoIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                            ? const CustomShimmerEffect(width: 161, height: 25)
                            : Expanded(
                              child: Text(
                                controller.videoTitle.value,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                  ),
                  GestureDetector(
                    onTap:
                        () => Get.to(
                          () => VideoPlayerScreen(
                            videoId: controller.lesson.videoId,
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
            ],
          ),
        ),
      ],
    );
  }
}
