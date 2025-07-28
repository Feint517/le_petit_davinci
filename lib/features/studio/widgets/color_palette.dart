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
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.borderPrimary, width: 1),
        ),
      ),
      child: Row(
        children: [
          //* Current color indicator
          Obx(
            () => Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: controller.selectedColor.value,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.borderPrimary, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.palette,
                color: _getContrastColor(controller.selectedColor.value),
                size: 20.sp,
              ),
            ),
          ),

          Gap(12.w),

          //* Color palette - Fixed: Removed problematic Obx wrapper
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    controller.availableColors.map((color) {
                      return Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: _buildColorButton(color),
                      );
                    }).toList(),
              ),
            ),
          ),

          Gap(12.w),

          //* Custom color picker button
          GestureDetector(
            onTap: _showCustomColorPicker,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.yellow,
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                  ],
                  stops: [0.0, 0.25, 0.5, 0.75, 1.0],
                ),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.borderPrimary, width: 2),
              ),
              child: Icon(Icons.add, color: Colors.white, size: 20.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColorButton(MaterialColor color) {
    return Obx(() {
      final isSelected = controller.selectedColor.value == color;

      return GestureDetector(
        onTap: () {
          controller.setColor(color);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: isSelected ? 40.w : 36.w,
          height: isSelected ? 40.w : 36.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  isSelected ? AppColors.textPrimary : AppColors.borderPrimary,
              width: isSelected ? 3 : 1,
            ),
            boxShadow:
                isSelected
                    ? [
                      BoxShadow(
                        color: color.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
          child:
              isSelected
                  ? Icon(
                    Icons.check,
                    color: _getContrastColor(color),
                    size: 16.sp,
                  )
                  : null,
        ),
      );
    });
  }

  void _showCustomColorPicker() {
    Get.bottomSheet(
      Container(
        height: 400.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choisir une couleur personnalisée',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Gap(20.h),

            Expanded(child: _buildSimpleColorPicker()),

            Gap(20.h),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: BorderSide(color: AppColors.borderPrimary),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: const Text('Annuler'),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: const Text('Choisir'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleColorPicker() {
    // Extended color palette for custom picker
    final List<MaterialColor> extendedColors = [
      // Basic colors
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
      // Colors.black,

      // // Light variations
      // Colors.red.shade200,
      // Colors.pink.shade200,
      // Colors.purple.shade200,
      // Colors.deepPurple.shade200,
      // Colors.indigo.shade200,
      // Colors.blue.shade200,
      // Colors.lightBlue.shade200,
      // Colors.cyan.shade200,
      // Colors.teal.shade200,
      // Colors.green.shade200,
      // Colors.lightGreen.shade200,
      // Colors.lime.shade200,
      // Colors.yellow.shade200,
      // Colors.amber.shade200,
      // Colors.orange.shade200,
      // Colors.deepOrange.shade200,
      // Colors.brown.shade200,
      // Colors.grey.shade200,
      // Colors.blueGrey.shade200,
      // Colors.white,
    ];

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        crossAxisSpacing: 8.w,
        mainAxisSpacing: 8.w,
      ),
      itemCount: extendedColors.length,
      itemBuilder: (context, index) {
        final color = extendedColors[index];

        return Obx(() {
          final isSelected = controller.selectedColor.value == color.value;

          return GestureDetector(
            onTap: () {
              controller.setColor(color);
              Get.back();
            },
            child: Container(
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color:
                      isSelected
                          ? AppColors.textPrimary
                          : AppColors.borderPrimary,
                  width: isSelected ? 3 : 1,
                ),
                boxShadow:
                    isSelected
                        ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ]
                        : null,
              ),
              child:
                  isSelected
                      ? Icon(
                        Icons.check,
                        color: _getContrastColor(color),
                        size: 16.sp,
                      )
                      : null,
            ),
          );
        });
      },
    );
  }

  Color _getContrastColor(Color color) {
    // Calculate luminance to determine if white or black text is more readable
    final r = (color.r * 255.0).round() & 0xff;
    final g = (color.g * 255.0).round() & 0xff;
    final b = (color.b * 255.0).round() & 0xff;
    final luminance = (0.299 * r + 0.587 * g + 0.114 * b) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
