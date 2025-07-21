import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/profile_header.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/views/drawing_canvas_screen.dart';
import 'package:le_petit_davinci/features/studio/views/gallery_screen.dart';
import 'package:le_petit_davinci/features/studio/views/template_selection_screen.dart';

class StudioMainScreen extends GetView<StudioController> {
  const StudioMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: const ProfileHeader(type: ProfileHeaderType.compact),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(20.h),

                // Welcome section
                _buildWelcomeSection(),

                Gap(30.h),

                // Main action cards
                _buildActionCards(),

                Gap(30.h),

                // Recent artworks section
                _buildRecentArtworks(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Studio Créatif',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DynaPuff_SemiCondensed',
                      ),
                    ),
                    Gap(8.h),
                    Text(
                      'Crée des dessins magiques et partage-les avec tes parents!',
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.9),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              ResponsiveImageAsset(
                assetPath: SvgAssets.studioCard,
                width: 80.w,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionCards() {
    return Column(
      children: [
        // Drawing actions row
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Dessin Libre',
                subtitle: 'Crée ton propre dessin',
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
              child: _buildActionCard(
                title: 'Modèles',
                subtitle: 'Utilise un modèle',
                icon: Icons.auto_awesome,
                color: AppColors.secondary,
                onTap: () {
                  Get.to(() => const TemplateSelectionScreen());
                },
              ),
            ),
          ],
        ),

        Gap(16.h),

        // Gallery row
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Ma Galerie',
                subtitle: 'Vois tous tes dessins',
                icon: Icons.photo_library,
                color: AppColors.accent,
                onTap: () {
                  Get.to(() => const GalleryScreen());
                },
              ),
            ),
            Gap(16.w),
            Expanded(
              child: Obx(
                () => _buildActionCard(
                  title: 'Partagés',
                  subtitle:
                      '${controller.artworks.where((a) => a.isSharedWithParent).length} dessins',
                  icon: Icons.family_restroom,
                  color: AppColors.greenPrimary,
                  onTap: () {
                    Get.to(() => const GalleryScreen(showOnlyShared: true));
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: AppColors.white, size: 20.sp),
            ),

            Gap(12.h),

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

  Widget _buildRecentArtworks() {
    return Obx(() {
      final recentArtworks = controller.artworks.take(4).toList();

      if (recentArtworks.isEmpty) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderPrimary, width: 1),
          ),
          child: Column(
            children: [
              Icon(Icons.palette, size: 48.sp, color: AppColors.textSecondary),
              Gap(12.h),
              Text(
                'Aucun dessin pour le moment',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(8.h),
              Text(
                'Commence ton premier dessin!',
                style: TextStyle(
                  color: AppColors.textTertiary,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        );
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
                child: Text(
                  'Voir tout',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          Gap(12.h),

          SizedBox(
            height: 120.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recentArtworks.length,
              itemBuilder: (context, index) {
                final artwork = recentArtworks[index];
                return Padding(
                  padding: EdgeInsets.only(right: 12.w),
                  child: _buildArtworkThumbnail(artwork),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildArtworkThumbnail(artwork) {
    return InkWell(
      onTap: () {
        // Load artwork for editing
        controller.loadArtworkForEditing(artwork.id);
        Get.to(() => const DrawingCanvasScreen());
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 120.w,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.borderPrimary, width: 1),
        ),
        child: Column(
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
                  child: Image.file(
                    File(artwork.imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.image_not_supported,
                        color: AppColors.textSecondary,
                        size: 32.sp,
                      );
                    },
                  ),
                ),
              ),
            ),

            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artwork.title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Row(
                    children: [
                      if (artwork.isSharedWithParent)
                        Container(
                          margin: EdgeInsets.only(right: 4.w),
                          child: Icon(
                            Icons.family_restroom,
                            color: AppColors.greenPrimary,
                            size: 10.sp,
                          ),
                        ),
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
