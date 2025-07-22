import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';
import 'package:le_petit_davinci/features/french/controller/french_lessons_controller.dart';
import 'package:le_petit_davinci/features/video_player/views/video_player.dart';

class FrenchLessons extends StatelessWidget {
  const FrenchLessons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FrenchLessonsController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4DC8FF), Color(0xFF6B9EFF), Color(0xFF8A7FFF)],
            stops: [0.0, 0.6, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                top: 100.h,
                right: -10.w,
                child: Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              Positioned(
                bottom: 200.h,
                left: -20.w,
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: Colors.yellow.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Main content with improved layout
              Column(
                children: [
                  // Navigation bar
                  const CustomNavBar(variant: BadgeVariant.french),

                  Gap(15.h),

                  // Enhanced title with better alignment
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              SvgAssets.bearMasscot,
                              width: 20.w,
                              height: 20.w,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          Gap(12.w),
                          Text(
                            "Matériel d'apprentissage",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'DynaPuff_SemiCondensed',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Gap(20.h),

                  // Optimized lessons list
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Obx(
                        () =>
                            controller.isLoading.value
                                ? _buildOptimizedLoadingState()
                                : controller.fetchedVideos.isEmpty
                                ? _buildEmptyState()
                                : _buildOptimizedLessonsList(controller),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Optimized loading state with less animations
  Widget _buildOptimizedLoadingState() {
    return Column(
      children: [
        // Simplified skeleton items
        ...List.generate(
          5,
          (index) => Container(
            margin: EdgeInsets.only(bottom: 12.h),
            height: 70.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  // Icon placeholder
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Gap(16.w),
                  // Text placeholder
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 14.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(7.r),
                          ),
                        ),
                        Gap(6.h),
                        Container(
                          height: 10.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Gap(20.h),

        // Simple loading indicator
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 16.w,
                height: 16.w,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              ),
              Gap(12.w),
              Text(
                "Chargement des leçons...",
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
                  fontSize: 14.sp,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Empty state (unchanged)
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.video_library_outlined,
              color: Colors.white.withValues(alpha: 0.7),
              size: 48.sp,
            ),
          ),
          Gap(20.h),
          Text(
            "Aucune leçon disponible",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.9),
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'DynaPuff_SemiCondensed',
            ),
          ),
          Gap(10.h),
          Text(
            "Veuillez réessayer plus tard",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 14.sp,
              fontFamily: 'DynaPuff_SemiCondensed',
            ),
          ),
        ],
      ),
    );
  }

  // Optimized lessons list with minimal animations
  Widget _buildOptimizedLessonsList(controller) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 30.h),
      itemCount: controller.fetchedVideos.length,
      separatorBuilder: (context, index) => Gap(12.h),
      physics: const BouncingScrollPhysics(), // Better scroll feel
      itemBuilder: (context, index) {
        final video = controller.fetchedVideos[index];
        final isVisited = controller.isVideoVisited(video.id);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12.r),
              onTap: () {
                controller.markVideoAsVisited(video.id);
                Get.to(
                  () => VideoPlayerScreen(
                    videoId: video.id,
                    videoTitle: video.title,
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: isVisited ? AppColors.blueSecondary : Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    // Play icon
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color:
                            isVisited
                                ? Colors.white.withValues(alpha: 0.2)
                                : AppColors.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.play_circle_fill_rounded,
                        color: isVisited ? Colors.white : AppColors.primary,
                        size: 24.sp,
                      ),
                    ),
                    Gap(16.w),
                    // Lesson text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${index + 1}. ${video.title}',
                            style: TextStyle(
                              color:
                                  isVisited
                                      ? Colors.white
                                      : AppColors.textPrimary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'DynaPuff_SemiCondensed',
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (isVisited) ...[
                            Gap(4.h),
                            Text(
                              'Terminé',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 12.sp,
                                fontFamily: 'DynaPuff_SemiCondensed',
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    // Arrow icon
                    Icon(
                      Icons.arrow_forward_ios,
                      color:
                          isVisited
                              ? Colors.white.withValues(alpha: 0.7)
                              : AppColors.textSecondary,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
