import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';

class ColorPalette extends GetView<StudioController> {
  const ColorPalette({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section title
          Text(
            'Couleurs',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'DynaPuff_SemiCondensed',
            ),
          ),

          Gap(12.h),

          // Color grid
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children:
                controller.availableColors.map((color) {
                  return Obx(
                    () => _buildColorButton(
                      color: color,
                      isSelected: controller.selectedColor.value == color,
                    ),
                  );
                }).toList(),
          ),

          Gap(16.h),

          // Current color info
          Obx(
            () => Row(
              children: [
                Text(
                  'Couleur sélectionnée:',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12.sp,
                  ),
                ),

                Gap(8.w),

                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: controller.selectedColor.value,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.black.withOpacity(0.2),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),

                Gap(8.w),

                Text(
                  _getColorName(controller.selectedColor.value),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorButton({required Color color, required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        controller.selectColor(color);

        // Haptic feedback for better UX
        // HapticFeedback.lightImpact();

        // Visual feedback
        Get.snackbar(
          '',
          '',
          duration: const Duration(milliseconds: 500),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: color.withOpacity(0.8),
          colorText: _getContrastColor(color),
          messageText: Row(
            children: [
              Icon(Icons.palette, color: _getContrastColor(color), size: 16.sp),
              Gap(8.w),
              Text(
                'Couleur ${_getColorName(color)} sélectionnée!',
                style: TextStyle(
                  color: _getContrastColor(color),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          titleText: const SizedBox.shrink(),
          margin: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: 100.h, // Above the color palette
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: isSelected ? 50.w : 44.w,
        height: isSelected ? 50.w : 44.w,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color:
                isSelected ? AppColors.white : AppColors.white.withOpacity(0.6),
            width: isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.2),
              blurRadius: isSelected ? 8 : 4,
              offset: Offset(0, isSelected ? 4 : 2),
              spreadRadius: isSelected ? 1 : 0,
            ),
          ],
        ),
        child:
            isSelected
                ? Center(
                  child: Container(
                    width: 16.w,
                    height: 16.w,
                    decoration: BoxDecoration(
                      color: _getContrastColor(color),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: color, size: 12.sp),
                  ),
                )
                : null,
      ),
    );
  }

  String _getColorName(Color color) {
    if (color == Colors.red) return 'Rouge';
    if (color == Colors.blue) return 'Bleu';
    if (color == Colors.green) return 'Vert';
    if (color == Colors.yellow) return 'Jaune';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.purple) return 'Violet';
    if (color == Colors.pink) return 'Rose';
    if (color == Colors.brown) return 'Marron';
    if (color == Colors.black) return 'Noir';
    if (color == Colors.grey) return 'Gris';
    return 'Personnalisée';
  }

  Color _getContrastColor(Color color) {
    // Calculate relative luminance
    final luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    // Return white for dark colors, black for light colors
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
