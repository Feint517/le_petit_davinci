import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';

class DrawingToolbar extends GetView<StudioController> {
  const DrawingToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.borderPrimary, width: 1),
        ),
      ),
      child: Row(
        children: [
          // Undo button
          _buildToolButton(
            icon: Icons.undo,
            onPressed: () => controller.undo(),
            tooltip: 'Annuler',
          ),

          Gap(8.w),

          // Redo button
          _buildToolButton(
            icon: Icons.redo,
            onPressed: () => controller.redo(),
            tooltip: 'Refaire',
          ),

          Gap(16.w),

          // Vertical divider
          Container(width: 1, height: 30.h, color: AppColors.borderPrimary),

          Gap(16.w),

          // Brush tool
          Obx(
            () => _buildToolButton(
              icon: Icons.brush,
              isSelected: controller.selectedTool.value == DrawingTool.brush,
              onPressed: () => controller.selectTool(DrawingTool.brush),
              tooltip: 'Pinceau',
            ),
          ),

          Gap(8.w),

          // Eraser tool
          Obx(
            () => _buildToolButton(
              icon: Icons.auto_fix_high,
              isSelected: controller.selectedTool.value == DrawingTool.eraser,
              onPressed: () => controller.selectTool(DrawingTool.eraser),
              tooltip: 'Gomme',
            ),
          ),

          Gap(16.w),

          // Vertical divider
          Container(width: 1, height: 30.h, color: AppColors.borderPrimary),

          Gap(16.w),

          // Brush size selector
          _buildBrushSizeSelector(),

          const Spacer(),

          // Clear button
          _buildToolButton(
            icon: Icons.clear_all,
            onPressed: () => _showClearDialog(context),
            tooltip: 'Tout effacer',
            color: AppColors.error,
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required VoidCallback onPressed,
    required String tooltip,
    bool isSelected = false,
    Color? color,
  }) {
    final buttonColor = color ?? AppColors.textPrimary;

    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color:
                isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            border:
                isSelected
                    ? Border.all(color: AppColors.primary, width: 1)
                    : null,
          ),
          child: Icon(
            icon,
            color: isSelected ? AppColors.primary : buttonColor,
            size: 20.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildBrushSizeSelector() {
    return Row(
      children: [
        Icon(Icons.circle, size: 16.sp, color: AppColors.textSecondary),

        Gap(8.w),

        Obx(
          () => Container(
            width: 100.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Row(
              children:
                  controller.availableSizes.map((size) {
                    final isSelected = controller.brushSize.value == size;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectBrushSize(size),
                        child: Container(
                          margin: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? AppColors.white
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(13.r),
                            boxShadow:
                                isSelected
                                    ? [
                                      BoxShadow(
                                        color: AppColors.black.withOpacity(0.1),
                                        blurRadius: 2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]
                                    : null,
                          ),
                          child: Center(
                            child: Container(
                              width: size * 0.8,
                              height: size * 0.8,
                              decoration: BoxDecoration(
                                color: AppColors.textPrimary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  void _showClearDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Text(
          'Tout effacer?',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),
        content: Text(
          'Tu vas perdre tout ton dessin. Es-tu sûr?',
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Non',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.clearCanvas();
              Get.back();
              Get.snackbar(
                'Effacé!',
                'Ton dessin a été effacé',
                backgroundColor: AppColors.orange.withOpacity(0.8),
                colorText: AppColors.white,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Oui, effacer',
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
}
