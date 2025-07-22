import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';

class ParentArtworkSection extends StatelessWidget {
  const ParentArtworkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudioController>(
      init: StudioController(),
      builder: (controller) {
        return Obx(() {
          final sharedArtworks =
              controller.artworks
                  .where((artwork) => artwork.isSharedWithParent)
                  .toList();

          if (sharedArtworks.isEmpty) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: AppColors.borderPrimary, width: 1),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.palette,
                    size: 48.sp,
                    color: AppColors.textSecondary,
                  ),
                  Gap(12.h),
                  Text(
                    'Aucun dessin partagé',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    'Votre enfant n\'a pas encore partagé de dessins',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 12.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section heading
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SectionHeading(
                      sectionName: 'Dessins de votre enfant',
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        '${sharedArtworks.length}',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Gap(16.h),

              // Artwork stats
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    _buildStatItem(
                      icon: Icons.palette,
                      label: 'Total',
                      value: '${sharedArtworks.length}',
                      color: AppColors.primary,
                    ),

                    Container(
                      width: 1,
                      height: 30.h,
                      color: AppColors.primary.withValues(alpha: 0.3),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                    ),

                    _buildStatItem(
                      icon: Icons.today,
                      label: 'Cette semaine',
                      value: '${_getThisWeekCount(sharedArtworks)}',
                      color: AppColors.accent,
                    ),

                    Container(
                      width: 1,
                      height: 30.h,
                      color: AppColors.primary.withValues(alpha: 0.3),
                      margin: EdgeInsets.symmetric(horizontal: 16.w),
                    ),

                    _buildStatItem(
                      icon: Icons.star,
                      label: 'Feedback',
                      value: '${_getTotalFeedbackCount(sharedArtworks)}',
                      color: AppColors.orangeAccent,
                    ),
                  ],
                ),
              ),

              Gap(16.h),

              // Recent artworks horizontal scroll
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: sharedArtworks.length,
                  itemBuilder: (context, index) {
                    final artwork = sharedArtworks[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index < sharedArtworks.length - 1 ? 16.w : 0,
                      ),
                      child: _buildArtworkCard(artwork, context),
                    );
                  },
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: color, size: 20.sp),
          Gap(4.h),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 10.sp),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildArtworkCard(ArtworkModel artwork, BuildContext context) {
    return GestureDetector(
      onTap: () => _showArtworkDetailDialog(artwork, context),
      child: Container(
        width: 150.w,
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
                        size: 10.sp,
                      ),
                      Gap(4.w),
                      Expanded(
                        child: Text(
                          _formatDate(artwork.createdAt),
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 10.sp,
                          ),
                        ),
                      ),
                      if (artwork.feedback.isNotEmpty)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.orangeAccent.withValues(
                              alpha: 0.2,
                            ),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            '${artwork.feedback.length}',
                            style: TextStyle(
                              color: AppColors.orangeAccent,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.bold,
                            ),
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

  void _showArtworkDetailDialog(ArtworkModel artwork, BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Container(
              width: 350.w,
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        artwork.title,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'DynaPuff_SemiCondensed',
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(Icons.close, color: AppColors.textSecondary),
                      ),
                    ],
                  ),

                  Gap(16.h),

                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.r),
                    child: Image.file(
                      File(artwork.imagePath),
                      width: 250.w,
                      height: 250.w,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 250.w,
                          height: 250.w,
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

                  // Details
                  Text(
                    'Créé le ${_formatDate(artwork.createdAt)}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),

                  Gap(16.h),

                  // Add feedback section
                  _buildFeedbackSection(artwork),

                  Gap(16.h),

                  // Actions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _showFeedbackDialog(artwork, context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Ajouter un message',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 12.sp,
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

  Widget _buildFeedbackSection(ArtworkModel artwork) {
    if (artwork.feedback.isEmpty) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          'Aucun message envoyé pour ce dessin',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12.sp,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vos messages:',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(8.h),
        ...artwork.feedback
            .map(
              (feedback) => Container(
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 8.h),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ...List.generate(
                          feedback.stars,
                          (index) => Icon(
                            Icons.star,
                            color: AppColors.orangeAccent,
                            size: 12.sp,
                          ),
                        ),
                        Gap(8.w),
                        Text(
                          _formatDate(feedback.timestamp),
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    Gap(4.h),
                    Text(
                      feedback.message,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ],
    );
  }

  void _showFeedbackDialog(ArtworkModel artwork, BuildContext context) {
    final messageController = TextEditingController();
    int selectedStars = 5;

    showDialog(
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  title: Text(
                    'Encourager votre enfant',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Donnez une note et laissez un message encourageant:',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),

                      Gap(16.h),

                      // Star rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedStars = index + 1;
                              });
                            },
                            child: Icon(
                              index < selectedStars
                                  ? Icons.star
                                  : Icons.star_border,
                              color: AppColors.orangeAccent,
                              size: 24.sp,
                            ),
                          );
                        }),
                      ),

                      Gap(16.h),

                      // Message input
                      TextField(
                        controller: messageController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Bravo! Ton dessin est magnifique...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          contentPadding: EdgeInsets.all(12.w),
                        ),
                        style: TextStyle(fontSize: 12.sp),
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Annuler',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (messageController.text.isNotEmpty) {
                          _addFeedback(
                            artwork,
                            messageController.text,
                            selectedStars,
                          );
                          Navigator.of(context).pop();
                          Get.snackbar(
                            'Message envoyé!',
                            'Votre enfant va être très content!',
                            backgroundColor: AppColors.greenPrimary.withValues(
                              alpha: 0.8,
                            ),
                            colorText: AppColors.white,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      child: Text(
                        'Envoyer',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
          ),
    );
  }

  void _addFeedback(ArtworkModel artwork, String message, int stars) {
    // This would integrate with the StudioController to add feedback
    // For now, we'll just show the success message
    // In a real implementation, this would update the artwork model
    // and persist the feedback
  }

  int _getThisWeekCount(List<ArtworkModel> artworks) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

    return artworks.where((artwork) {
      return artwork.createdAt.isAfter(startOfWeek);
    }).length;
  }

  int _getTotalFeedbackCount(List<ArtworkModel> artworks) {
    return artworks.fold(
      0,
      (total, artwork) => total + artwork.feedback.length,
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
