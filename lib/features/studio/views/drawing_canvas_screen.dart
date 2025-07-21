import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';
import 'package:le_petit_davinci/features/studio/widgets/drawing_toolbar.dart';
import 'package:le_petit_davinci/features/studio/widgets/color_palette.dart';

class DrawingCanvasScreen extends GetView<StudioController> {
  const DrawingCanvasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => _showExitDialog(context),
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        title: Obx(
          () => Text(
            controller.currentArtworkTitle.value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'DynaPuff_SemiCondensed',
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showSaveDialog(context),
            icon: Icon(Icons.save, color: AppColors.primary),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Toolbar
            const DrawingToolbar(),

            Divider(height: 1, color: AppColors.borderPrimary),

            // Canvas area
            Expanded(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderPrimary, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Stack(
                    children: [
                      // Template background (if selected)
                      Obx(() {
                        if (controller.selectedTemplate.value != null) {
                          return Positioned.fill(
                            child: Image.asset(
                              controller
                                  .selectedTemplate
                                  .value!
                                  .templateImagePath,
                              fit: BoxFit.contain,
                              opacity: const AlwaysStoppedAnimation(0.3),
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: AppColors.backgroundSecondary,
                                  child: Center(
                                    child: Icon(
                                      Icons.image_not_supported,
                                      color: AppColors.textSecondary,
                                      size: 48.sp,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }),

                      // Drawing canvas
                      RepaintBoundary(
                        key: controller.canvasKey,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: CustomPaint(
                            painter: DrawingPainter(controller.drawingPaths),
                            child: GestureDetector(
                              onPanStart: (details) {
                                final localPosition = details.localPosition;
                                controller.startDrawing(localPosition);
                              },
                              onPanUpdate: (details) {
                                final localPosition = details.localPosition;
                                controller.updateDrawing(localPosition);
                              },
                              onPanEnd: (details) {
                                controller.endDrawing();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Color palette
            const ColorPalette(),

            Gap(16.h),
          ],
        ),
      ),
    );
  }

  void _showExitDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Quitter le dessin?',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),
        content: Text(
          'Veux-tu sauvegarder ton dessin avant de partir?',
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Exit drawing screen
            },
            child: Text(
              'Non merci',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              _showSaveDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Sauvegarder',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSaveDialog(BuildContext context) {
    final titleController = TextEditingController(
      text: controller.currentArtworkTitle.value,
    );

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Sauvegarder le dessin',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Nom du dessin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 8.h,
                ),
              ),
              style: TextStyle(fontSize: 14.sp),
            ),
            Gap(16.h),
            Row(
              children: [
                Obx(
                  () => Checkbox(
                    value: false, // We'll add share functionality later
                    onChanged: null, // Disabled for now
                  ),
                ),
                Expanded(
                  child: Text(
                    'Partager avec mes parents',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Annuler',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ),
          Obx(
            () => ElevatedButton(
              onPressed:
                  controller.isLoading.value
                      ? null
                      : () async {
                        await controller.saveArtwork(
                          title: titleController.text,
                        );
                        Get.back(); // Close dialog
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child:
                  controller.isLoading.value
                      ? SizedBox(
                        width: 16.w,
                        height: 16.w,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                      : Text(
                        'Sauvegarder',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final List<DrawingPath> paths;

  DrawingPainter(this.paths);

  @override
  void paint(Canvas canvas, Size size) {
    for (final path in paths) {
      final paint =
          Paint()
            ..color = path.color
            ..strokeWidth = path.strokeWidth
            ..style = PaintingStyle.stroke
            ..strokeCap = StrokeCap.round
            ..strokeJoin = StrokeJoin.round;

      if (path.tool == DrawingTool.eraser) {
        paint.blendMode = BlendMode.clear;
      }

      if (path.points.isNotEmpty) {
        final drawPath = Path();
        drawPath.moveTo(path.points.first.dx, path.points.first.dy);

        for (int i = 1; i < path.points.length; i++) {
          drawPath.lineTo(path.points[i].dx, path.points[i].dy);
        }

        canvas.drawPath(drawPath, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DrawingPainter && listEquals(other.paths, paths);
  }

  @override
  int get hashCode => paths.hashCode;
}

// Helper function for list equality
bool listEquals<T>(List<T>? a, List<T>? b) {
  if (a == null) return b == null;
  if (b == null || a.length != b.length) return false;
  if (identical(a, b)) return true;
  for (int index = 0; index < a.length; index += 1) {
    if (a[index] != b[index]) return false;
  }
  return true;
}
