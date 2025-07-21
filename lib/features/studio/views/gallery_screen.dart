import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/views/drawing_canvas_screen.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';

class GalleryScreen extends GetView<StudioController> {
  final bool showOnlyShared;

  const GalleryScreen({super.key, this.showOnlyShared = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        title: Text(
          showOnlyShared ? 'Dessins Partagés' : 'Ma Galerie',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: AppColors.textPrimary),
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'sort_date',
                    child: Row(
                      children: [
                        Icon(Icons.date_range, size: 16.sp),
                        Gap(8.w),
                        Text('Trier par date'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'sort_name',
                    child: Row(
                      children: [
                        Icon(Icons.sort_by_alpha, size: 16.sp),
                        Gap(8.w),
                        Text('Trier par nom'),
                      ],
                    ),
                  ),
                ],
            onSelected: (value) {
              // TODO: Implement sorting
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          final artworks =
              showOnlyShared
                  ? controller.artworks
                      .where((a) => a.isSharedWithParent)
                      .toList()
                  : controller.artworks.toList();

          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (artworks.isEmpty) {
            return _buildEmptyState();
          }

          return Column(
            children: [
              // Stats header
              _buildStatsHeader(artworks),

              // Gallery grid
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.h,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: artworks.length,
                    itemBuilder: (context, index) {
                      final artwork = artworks[index];
                      return _buildArtworkCard(artwork);
                    },
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              showOnlyShared ? Icons.family_restroom : Icons.palette,
              size: 80.sp,
              color: AppColors.textSecondary,
            ),

            Gap(16.h),

            Text(
              showOnlyShared
                  ? 'Aucun dessin partagé'
                  : 'Aucun dessin pour le moment',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
              textAlign: TextAlign.center,
            ),

            Gap(8.h),

            Text(
              showOnlyShared
                  ? 'Partage tes dessins avec tes parents pour les voir ici!'
                  : 'Commence à dessiner pour créer ta première œuvre d\'art!',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
              textAlign: TextAlign.center,
            ),

            if (!showOnlyShared) ...[
              Gap(24.h),

              ElevatedButton(
                onPressed: () {
                  controller.startNewArtwork();
                  Get.to(() => const DrawingCanvasScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.r),
                  ),
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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatsHeader(List<ArtworkModel> artworks) {
    final totalArtworks = artworks.length;
    final sharedArtworks = artworks.where((a) => a.isSharedWithParent).length;
    final todayArtworks =
        artworks.where((a) {
          final today = DateTime.now();
          final artworkDate = a.createdAt;
          return artworkDate.year == today.year &&
              artworkDate.month == today.month &&
              artworkDate.day == today.day;
        }).length;

    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              icon: Icons.palette,
              count: totalArtworks.toString(),
              label: 'Dessins totaux',
              color: AppColors.primary,
            ),
          ),

          Container(width: 1, height: 40.h, color: AppColors.borderPrimary),

          Expanded(
            child: _buildStatItem(
              icon: Icons.family_restroom,
              count: sharedArtworks.toString(),
              label: 'Partagés',
              color: AppColors.greenPrimary,
            ),
          ),

          Container(width: 1, height: 40.h, color: AppColors.borderPrimary),

          Expanded(
            child: _buildStatItem(
              icon: Icons.today,
              count: todayArtworks.toString(),
              label: 'Aujourd\'hui',
              color: AppColors.secondary,
            ),
          ),
        ],
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
        Icon(icon, color: color, size: 20.sp),

        Gap(4.h),

        Text(
          count,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          label,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 10.sp),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildArtworkCard(ArtworkModel artwork) {
    return GestureDetector(
      onTap: () {
        _showArtworkDetails(artwork);
      },
      onLongPress: () {
        _showArtworkOptions(artwork);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
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
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image_not_supported,
                              color: AppColors.textSecondary,
                              size: 32.sp,
                            ),
                            Gap(8.h),
                            Text(
                              'Image non disponible',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // Info
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    artwork.title,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Gap(4.h),

                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: AppColors.textSecondary,
                        size: 12.sp,
                      ),

                      Gap(4.w),

                      Expanded(
                        child: Text(
                          _formatDate(artwork.createdAt),
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),

                      if (artwork.isSharedWithParent)
                        Icon(
                          Icons.family_restroom,
                          color: AppColors.greenPrimary,
                          size: 14.sp,
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

  void _showArtworkDetails(ArtworkModel artwork) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Container(
          width: 300.w,
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.file(
                  File(artwork.imagePath),
                  width: 200.w,
                  height: 200.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 200.w,
                      height: 200.w,
                      color: AppColors.backgroundSecondary,
                      child: Icon(
                        Icons.image_not_supported,
                        size: 48.sp,
                        color: AppColors.textSecondary,
                      ),
                    );
                  },
                ),
              ),

              Gap(16.h),

              Text(
                artwork.title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'DynaPuff_SemiCondensed',
                ),
              ),

              Gap(8.h),

              Text(
                'Créé le ${_formatDate(artwork.createdAt)}',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                ),
              ),

              Gap(16.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      controller.loadArtworkForEditing(artwork.id);
                      Get.to(() => const DrawingCanvasScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Modifier',
                      style: TextStyle(color: AppColors.white, fontSize: 12.sp),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      controller.exportArtwork(artwork.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      'Partager',
                      style: TextStyle(color: AppColors.white, fontSize: 12.sp),
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

  void _showArtworkOptions(ArtworkModel artwork) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              artwork.title,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),

            Gap(20.h),

            ListTile(
              leading: Icon(Icons.edit, color: AppColors.primary),
              title: const Text('Modifier'),
              onTap: () {
                Get.back();
                controller.loadArtworkForEditing(artwork.id);
                Get.to(() => const DrawingCanvasScreen());
              },
            ),

            if (!artwork.isSharedWithParent)
              ListTile(
                leading: Icon(
                  Icons.family_restroom,
                  color: AppColors.greenPrimary,
                ),
                title: const Text('Partager avec les parents'),
                onTap: () {
                  Get.back();
                  controller.shareWithParent(artwork.id);
                },
              ),

            ListTile(
              leading: Icon(Icons.share, color: AppColors.accent),
              title: const Text('Exporter'),
              onTap: () {
                Get.back();
                controller.exportArtwork(artwork.id);
              },
            ),

            ListTile(
              leading: Icon(Icons.delete, color: AppColors.error),
              title: const Text('Supprimer'),
              onTap: () {
                Get.back();
                _confirmDelete(artwork);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(ArtworkModel artwork) {
    Get.dialog(
      AlertDialog(
        title: const Text('Supprimer le dessin?'),
        content: Text(
          'Tu ne pourras pas récupérer "${artwork.title}" après suppression.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Annuler')),
          ElevatedButton(
            onPressed: () {
              controller.deleteArtwork(artwork.id);
              Get.back();
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Supprimer'),
          ),
        ],
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
      return 'Il y a ${difference.inDays} jours';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
