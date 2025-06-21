import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/buttons/custom_button_main.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/features/french/controller/french_lessons_controller.dart';
import 'package:le_petit_davinci/features/french/view/video_player_screen.dart';

class FrenchLessons extends StatelessWidget {
  const FrenchLessons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FrenchLessonsController());
    return Scaffold(
      backgroundColor: AppColors.bluePrimary,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            spacing: 15,
            children: [
              const CustomNavBar(variant: BadgeVariant.french),
              Text(
                "Matériel d'apprentissage",
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              Obx(
                () =>
                    controller.isLoading.value
                        ? Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        )
                        : Column(
                          spacing: AppSizes.spaceBtwItems,
                          children:
                              controller.fetchedVideos.asMap().entries.map((
                                entry,
                              ) {
                                final index = entry.key;
                                final video = entry.value;
                                final isVisited = controller.isVideoVisited(
                                  video.id,
                                );
                                return CustomButtonNew(
                                  buttonColor:
                                      isVisited
                                          ? AppColors.blueSecondary
                                          : AppColors.white,
                                  shadowColor:
                                      isVisited
                                          ? AppColors.blueSecondary
                                          : AppColors.white,
                                  label: '${index + 1}- ${video.title}',
                                  labelColor:
                                      isVisited
                                          ? AppColors.white
                                          : AppColors.textPrimary,
                                  icon: Icons.play_circle_fill_rounded,
                                  iconColor:
                                      isVisited
                                          ? AppColors.white
                                          : AppColors.bluePrimary,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  onPressed: () {
                                    controller.markVideoAsVisited(video.id);
                                    Get.to(
                                      () => VideoPlayerScreen(
                                        videoId: video.id,
                                        videoTitle: video.title,
                                      ),
                                    );
                                  },
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                );
                              }).toList(),
                        ),
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
