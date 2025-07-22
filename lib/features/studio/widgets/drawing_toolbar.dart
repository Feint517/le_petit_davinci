import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_drawing_board/paint_contents.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';

class DrawingToolbar extends GetView<StudioController> {
  const DrawingToolbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.borderPrimary, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: _buildCompactToolbar(),
    );
  }

  Widget _buildCompactToolbar() {
    return Row(
      children: [
        // Left section: Essential tools (undo/redo + main tool)
        _buildEssentialTools(),

        Gap(4.w),
        _buildVerticalDivider(),
        Gap(4.w),

        // Middle section: Scrollable tools
        Expanded(child: _buildScrollableTools()),

        Gap(4.w),
        _buildVerticalDivider(),
        Gap(4.w),

        // Right section: Menu for additional actions
        _buildMoreMenu(),
      ],
    );
  }

  Widget _buildEssentialTools() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Undo button
        Obx(
          () => _buildCompactButton(
            icon: Icons.undo,
            onPressed:
                controller.canUndo.value ? () => controller.undo() : null,
            isEnabled: controller.canUndo.value,
            size: 32.w,
          ),
        ),

        Gap(2.w),

        // Redo button
        Obx(
          () => _buildCompactButton(
            icon: Icons.redo,
            onPressed:
                controller.canRedo.value ? () => controller.redo() : null,
            isEnabled: controller.canRedo.value,
            size: 32.w,
          ),
        ),
      ],
    );
  }

  Widget _buildScrollableTools() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drawing tools
          Obx(
            () => _buildCompactButton(
              icon: Icons.brush,
              onPressed: () => controller.selectTool(SimpleLine()),
              isSelected: controller.selectedTool.value == SimpleLine,
              selectedColor: AppColors.primary,
              size: 32.w,
            ),
          ),
          Gap(2.w),

          Obx(
            () => _buildCompactButton(
              icon: Icons.circle_outlined,
              onPressed: () => controller.selectTool(Circle()),
              isSelected: controller.selectedTool.value == Circle,
              selectedColor: AppColors.primary,
              size: 32.w,
            ),
          ),
          Gap(2.w),

          Obx(
            () => _buildCompactButton(
              icon: Icons.crop_square,
              onPressed: () => controller.selectTool(Rectangle()),
              isSelected: controller.selectedTool.value == Rectangle,
              selectedColor: AppColors.primary,
              size: 32.w,
            ),
          ),
          Gap(2.w),

          Obx(
            () => _buildCompactButton(
              icon: Icons.auto_fix_high,
              onPressed: () => controller.selectTool(Eraser()),
              isSelected: controller.selectedTool.value == Eraser,
              selectedColor: AppColors.error,
              size: 32.w,
            ),
          ),
          Gap(4.w),

          // Color indicator
          Obx(
            () => GestureDetector(
              onTap: () => _showColorPicker(),
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  color: controller.selectedColor.value,
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: AppColors.borderPrimary, width: 1),
                ),
                child: Icon(
                  Icons.palette,
                  color: _getContrastColor(controller.selectedColor.value),
                  size: 14.sp,
                ),
              ),
            ),
          ),
          Gap(4.w),

          // Brush size indicator
          Obx(
            () => GestureDetector(
              onTap: _showBrushSizeSelector,
              child: Container(
                width: 32.w,
                height: 32.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: AppColors.borderPrimary, width: 1),
                ),
                child: Center(
                  child: Container(
                    width: (controller.brushSize.value * 0.3).clamp(4.0, 12.0),
                    height: (controller.brushSize.value * 0.3).clamp(4.0, 12.0),
                    decoration: BoxDecoration(
                      color: controller.selectedColor.value,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoreMenu() {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_horiz, size: 20.sp, color: AppColors.textPrimary),
      offset: Offset(0, 40.h),
      itemBuilder:
          (context) => [
            PopupMenuItem(
              value: 'template',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.auto_awesome,
                    size: 16.sp,
                    color: AppColors.accent,
                  ),
                  Gap(8.w),
                  const Text('Modèles'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'clear',
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.clear_all, size: 16.sp, color: AppColors.error),
                  Gap(8.w),
                  const Text('Effacer'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'save',
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.save,
                      size: 16.sp,
                      color:
                          controller.hasUnsavedChanges.value
                              ? AppColors.greenPrimary
                              : AppColors.textSecondary,
                    ),
                    Gap(8.w),
                    Text(
                      'Sauvegarder',
                      style: TextStyle(
                        color:
                            controller.hasUnsavedChanges.value
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
      onSelected: (value) {
        switch (value) {
          case 'template':
            _showTemplateSelector();
            break;
          case 'clear':
            _showClearDialog();
            break;
          case 'save':
            if (controller.hasUnsavedChanges.value) {
              controller.saveArtwork();
            }
            break;
        }
      },
    );
  }

  Widget _buildCompactButton({
    required IconData icon,
    required VoidCallback? onPressed,
    bool isSelected = false,
    bool isEnabled = true,
    Color? selectedColor,
    required double size,
  }) {
    final iconColor =
        isSelected
            ? (selectedColor ?? AppColors.primary)
            : isEnabled
            ? AppColors.textPrimary
            : AppColors.textSecondary.withOpacity(0.5);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(4.r),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color:
                isSelected
                    ? (selectedColor ?? AppColors.primary).withOpacity(0.1)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(4.r),
            border:
                isSelected
                    ? Border.all(
                      color: selectedColor ?? AppColors.primary,
                      width: 1,
                    )
                    : null,
          ),
          child: Icon(icon, color: iconColor, size: 16.sp),
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 20.h, color: AppColors.borderPrimary);
  }

  void _showBrushSizeSelector() {
    Get.bottomSheet(
      Container(
        height: 200.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Taille du pinceau',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
            Gap(20.h),
            Expanded(
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      controller.availableSizes.map((size) {
                        final isSelected = controller.brushSize.value == size;
                        return GestureDetector(
                          onTap: () {
                            controller.setBrushSize(size);
                            Get.back();
                          },
                          child: Container(
                            width: 40.w,
                            height: 40.w,
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.primary.withOpacity(0.1)
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color:
                                    isSelected
                                        ? AppColors.primary
                                        : AppColors.borderPrimary,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: (size * 0.5).clamp(6.0, 20.0),
                                height: (size * 0.5).clamp(6.0, 20.0),
                                decoration: BoxDecoration(
                                  color: controller.selectedColor.value,
                                  shape: BoxShape.circle,
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
        ),
      ),
    );
  }

  void _showColorPicker() {
    Get.bottomSheet(
      Container(
        height: 350.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choisir une couleur',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
            Gap(20.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.w,
                ),
                itemCount: controller.availableColors.length,
                itemBuilder: (context, index) {
                  final color = controller.availableColors[index];
                  final isSelected = controller.selectedColor.value == color;

                  return GestureDetector(
                    onTap: () {
                      controller.setColor(color);
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border:
                            isSelected
                                ? Border.all(
                                  color: AppColors.textPrimary,
                                  width: 3,
                                )
                                : Border.all(
                                  color: AppColors.borderPrimary,
                                  width: 1,
                                ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child:
                          isSelected
                              ? Icon(
                                Icons.check,
                                color: _getContrastColor(color),
                                size: 24.sp,
                              )
                              : null,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showTemplateSelector() {
    Get.bottomSheet(
      Container(
        height: 450.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choisir un modèle',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
            Gap(20.h),
            Expanded(
              child: Obx(
                () =>
                    controller.templates.isEmpty
                        ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.auto_awesome_outlined,
                                size: 48.sp,
                                color: AppColors.textSecondary,
                              ),
                              Gap(16.h),
                              Text(
                                'Aucun modèle disponible',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        )
                        : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.w,
                                childAspectRatio: 1.2,
                              ),
                          itemCount: controller.templates.length,
                          itemBuilder: (context, index) {
                            final template = controller.templates[index];
                            final isSelected =
                                controller.selectedTemplate.value?.id ==
                                template.id;

                            return GestureDetector(
                              onTap: () {
                                controller.selectTemplate(template);
                                Get.back();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? AppColors.primary
                                            : AppColors.borderPrimary,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.all(8.w),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          color: AppColors.backgroundSecondary,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.image_outlined,
                                            size: 32.sp,
                                            color: AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.w),
                                      child: Text(
                                        template.name,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.textPrimary,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showClearDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Icons.warning, color: AppColors.error, size: 24.sp),
            Gap(8.w),
            Text(
              'Effacer le dessin',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        content: Text(
          'Êtes-vous sûr de vouloir effacer tout le dessin ? Cette action ne peut pas être annulée.',
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Annuler',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.clearCanvas();
              Get.back();
              Get.snackbar(
                'Effacé! 🗑️',
                'Le dessin a été effacé',
                backgroundColor: AppColors.greenPrimary.withOpacity(0.8),
                colorText: AppColors.white,
                duration: const Duration(seconds: 2),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: const Text('Effacer'),
          ),
        ],
      ),
    );
  }

  Color _getContrastColor(Color color) {
    final luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
