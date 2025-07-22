import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/views/drawing_canvas_screen.dart';
import 'package:le_petit_davinci/features/studio/views/gallery_screen.dart';
import 'package:le_petit_davinci/features/studio/views/template_selection_screen.dart';

class StudioMainScreen extends StatelessWidget {
  const StudioMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudioController>(
      init: StudioController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: const ProfileHeader(type: ProfileHeaderType.compact),
          body: SafeArea(
            child: AnimationLimiter(
              child: RefreshIndicator(
                onRefresh: () async {
                  await controller.loadArtworks();
                },
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 375),
                        childAnimationBuilder:
                            (widget) => SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(child: widget),
                            ),
                        children: [
                          Gap(20.h),

                          // Welcome section
                          _buildWelcomeSection(),

                          Gap(30.h),

                          // Quick start actions
                          _buildQuickStartSection(controller),

                          Gap(30.h),

                          // Statistics section
                          _buildStatisticsSection(controller),

                          Gap(30.h),

                          // Recent artworks section
                          _buildRecentArtworks(controller),

                          Gap(30.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🎨 Studio Créatif',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                ),
                Gap(8.h),
                Text(
                  'Libère ta créativité et crée des dessins magiques!',
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: 0.9),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                  ),
                ),
                Gap(12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    'Partage tes œuvres avec tes parents!',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Gap(16.w),
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Icon(Icons.palette, color: AppColors.white, size: 40.sp),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStartSection(StudioController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Commencer à dessiner',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),

        Gap(16.h),

        Row(
          children: [
            Expanded(
              child: _buildQuickActionCard(
                title: 'Dessin Libre',
                subtitle: 'Crée librement',
                icon: Icons.brush,
                color: AppColors.primary,
                onTap: () {
                  controller.startNewArtwork();
                  Get.to(() => const DrawingCanvasScreen());
                },
              ),
            ),
            Gap(16.w),
            Expanded(
              child: _buildQuickActionCard(
                title: 'Avec Modèle',
                subtitle: 'Utilise un guide',
                icon: Icons.auto_awesome,
                color: AppColors.secondary,
                onTap: () {
                  Get.to(() => const TemplateSelectionScreen());
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatisticsSection(StudioController controller) {
    return Obx(() {
      final totalArtworks = controller.artworks.length;
      final sharedArtworks =
          controller.artworks
              .where((artwork) => artwork.isSharedWithParent)
              .length;
      final weeklyArtworks =
          controller.artworks.where((artwork) {
            final now = DateTime.now();
            final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
            return artwork.createdAt.isAfter(startOfWeek);
          }).length;

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mes Statistiques',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                ),
                Icon(
                  Icons.analytics_outlined,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
              ],
            ),

            Gap(16.h),

            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    icon: Icons.palette,
                    count: totalArtworks.toString(),
                    label: 'Dessins totaux',
                    color: AppColors.primary,
                  ),
                ),

                Container(
                  width: 1,
                  height: 40.h,
                  color: AppColors.borderPrimary,
                ),

                Expanded(
                  child: _buildStatItem(
                    icon: Icons.family_restroom,
                    count: sharedArtworks.toString(),
                    label: 'Partagés',
                    color: AppColors.greenPrimary,
                  ),
                ),

                Container(
                  width: 1,
                  height: 40.h,
                  color: AppColors.borderPrimary,
                ),

                Expanded(
                  child: _buildStatItem(
                    icon: Icons.calendar_today,
                    count: weeklyArtworks.toString(),
                    label: 'Cette semaine',
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildRecentArtworks(StudioController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return SizedBox(
          height: 200.h,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      final recentArtworks = controller.artworks.take(6).toList();

      if (recentArtworks.isEmpty) {
        return _buildEmptyArtworksState(controller);
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Mes Derniers Dessins',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const GalleryScreen());
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Voir tout',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(4.w),
                    Icon(
                      Icons.arrow_forward,
                      color: AppColors.primary,
                      size: 16.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),

          Gap(12.h),

          SizedBox(
            height: 140.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentArtworks.length,
              itemBuilder: (context, index) {
                final artwork = recentArtworks[index];
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: _buildArtworkThumbnail(artwork, controller),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildEmptyArtworksState(StudioController controller) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(32.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderPrimary, width: 1),
      ),
      child: Column(
        children: [
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(Icons.palette, size: 40.sp, color: AppColors.primary),
          ),

          Gap(16.h),

          Text(
            'Aucun dessin pour le moment',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'DynaPuff_SemiCondensed',
            ),
          ),

          Gap(8.h),

          Text(
            'Commence ton premier dessin et laisse libre cours à ta créativité!',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14.sp,
              height: 1.3,
            ),
            textAlign: TextAlign.center,
          ),

          Gap(24.h),

          ElevatedButton(
            onPressed: () {
              controller.startNewArtwork();
              Get.to(() => const DrawingCanvasScreen());
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
              elevation: 2,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.brush, color: AppColors.white, size: 16.sp),
                Gap(8.w),
                Text(
                  'Créer mon premier dessin',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: AppColors.white, size: 24.sp),
            ),

            Gap(16.h),

            Text(
              title,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),

            Gap(4.h),

            Text(
              subtitle,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String count,
    required String label,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24.sp),

        Gap(8.h),

        Text(
          count,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          label,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildArtworkThumbnail(artwork, StudioController controller) {
    return GestureDetector(
      onTap: () {
        controller.loadArtworkForEditing(artwork.id);
        Get.to(() => const DrawingCanvasScreen());
      },
      child: Container(
        width: 120.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  child: _buildImageWidget(artwork.imagePath),
                ),
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artwork.title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Gap(2.h),

                  Row(
                    children: [
                      if (artwork.isSharedWithParent) ...[
                        Icon(
                          Icons.family_restroom,
                          color: AppColors.greenPrimary,
                          size: 10.sp,
                        ),
                        Gap(4.w),
                      ],
                      Expanded(
                        child: Text(
                          _formatDate(artwork.createdAt),
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 10.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget(String imagePath) {
    if (imagePath.isEmpty) {
      return Center(
        child: Icon(
          Icons.image_not_supported,
          color: AppColors.textSecondary,
          size: 32.sp,
        ),
      );
    }

    try {
      final file = File(imagePath);
      return Image.file(
        file,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.image_not_supported,
              color: AppColors.textSecondary,
              size: 32.sp,
            ),
          );
        },
      );
    } catch (e) {
      return Center(
        child: Icon(
          Icons.image_not_supported,
          color: AppColors.textSecondary,
          size: 32.sp,
        ),
      );
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Aujourd\'hui';
    } else if (difference.inDays == 1) {
      return 'Hier';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}j';
    } else {
      return '${date.day}/${date.month}';
    }
  }
}
