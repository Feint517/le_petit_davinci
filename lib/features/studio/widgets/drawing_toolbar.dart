import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      height: 70.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
      child: Row(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),
          childAnimationBuilder:
              (widget) => SlideAnimation(
                horizontalOffset: 50.0,
                child: FadeInAnimation(child: widget),
              ),
          children: [
            // Undo/Redo section
            _buildUndoRedoSection(),
            Gap(16.w),
            _buildVerticalDivider(),
            Gap(16.w),

            // Drawing tools section
            _buildDrawingToolsSection(),
            Gap(16.w),
            _buildVerticalDivider(),
            Gap(16.w),

            // Brush size section
            _buildBrushSizeSection(),
            const Spacer(),

            // Action buttons
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildUndoRedoSection() {
    return Row(
      children: [
        // Undo button - FIXED with proper observable usage
        Obx(
          () => _buildToolButton(
            icon: Icons.undo,
            onPressed:
                controller.canUndo.value ? () => controller.undo() : null,
            tooltip: 'Annuler (${controller.historyLength.value} actions)',
            isEnabled: controller.canUndo.value,
          ),
        ),

        Gap(8.w),

        // Redo button - FIXED with proper observable usage
        Obx(
          () => _buildToolButton(
            icon: Icons.redo,
            onPressed:
                controller.canRedo.value ? () => controller.redo() : null,
            tooltip: 'Refaire',
            isEnabled: controller.canRedo.value,
          ),
        ),
      ],
    );
  }

  Widget _buildDrawingToolsSection() {
    return Row(
      children: [
        // Brush tool
        Obx(
          () => _buildToolButton(
            icon: Icons.brush,
            onPressed: () => controller.selectTool(DrawingTool.brush),
            tooltip: 'Pinceau',
            isSelected: controller.selectedTool.value == DrawingTool.brush,
            selectedColor: AppColors.primary,
          ),
        ),

        Gap(8.w),

        // Eraser tool
        Obx(
          () => _buildToolButton(
            icon: Icons.auto_fix_high,
            onPressed: () => controller.selectTool(DrawingTool.eraser),
            tooltip: 'Gomme',
            isSelected: controller.selectedTool.value == DrawingTool.eraser,
            selectedColor: AppColors.error,
          ),
        ),

        Gap(8.w),

        // Color picker button
        Obx(
          () => GestureDetector(
            onTap: () => _showColorPicker(),
            child: Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: controller.selectedColor.value,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.borderPrimary, width: 2),
              ),
              child: Icon(
                Icons.palette,
                color: _getContrastColor(controller.selectedColor.value),
                size: 20.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBrushSizeSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(Icons.circle, size: 12.sp, color: AppColors.textSecondary),
            Gap(8.w),

            // Brush size selector - FIXED with proper Row structure for Gap widgets
            Obx(
              () => SizedBox(
                width: 120.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:
                      controller.availableSizes.map((size) {
                        final isSelected = controller.brushSize.value == size;
                        return GestureDetector(
                          onTap: () => controller.setBrushSize(size),
                          child: Container(
                            width: 24.w,
                            height: 24.w,
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? AppColors.primary.withOpacity(0.1)
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(12.r),
                              border:
                                  isSelected
                                      ? Border.all(
                                        color: AppColors.primary,
                                        width: 2,
                                      )
                                      : Border.all(
                                        color: AppColors.borderPrimary,
                                        width: 1,
                                      ),
                            ),
                            child: Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                width: (size * 0.5).clamp(4.0, 14.0),
                                height: (size * 0.5).clamp(4.0, 14.0),
                                decoration: BoxDecoration(
                                  color:
                                      isSelected
                                          ? controller.selectedColor.value
                                          : AppColors.textSecondary,
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
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        // Template selector
        _buildToolButton(
          icon: Icons.auto_awesome,
          onPressed: () => _showTemplateSelector(),
          tooltip: 'Choisir un modèle',
          color: AppColors.accent,
        ),

        Gap(8.w),

        // Clear canvas button
        _buildToolButton(
          icon: Icons.clear_all,
          onPressed: () => _showClearDialog(),
          tooltip: 'Tout effacer',
          color: AppColors.error,
        ),
      ],
    );
  }

  Widget _buildToolButton({
    required IconData icon,
    required VoidCallback? onPressed,
    required String tooltip,
    bool isSelected = false,
    bool isEnabled = true,
    Color? color,
    Color? selectedColor,
  }) {
    final buttonColor = color ?? AppColors.textPrimary;
    final backgroundColor =
        isSelected
            ? (selectedColor ?? AppColors.primary).withOpacity(0.1)
            : Colors.transparent;
    final iconColor =
        isSelected
            ? (selectedColor ?? AppColors.primary)
            : isEnabled
            ? buttonColor
            : AppColors.textSecondary;

    return Tooltip(
      message: tooltip,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.r),
              border:
                  isSelected
                      ? Border.all(
                        color: selectedColor ?? AppColors.primary,
                        width: 2,
                      )
                      : null,
            ),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 24.h, color: AppColors.borderPrimary);
  }

  void _showColorPicker() {
    Get.bottomSheet(
      Container(
        height: 300.h,
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
    );
  }

  void _showTemplateSelector() {
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
              'Choisir un modèle',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            Gap(20.h),

            Expanded(
              child: Obx(
                () => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.w,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: controller.templates.length,
                  itemBuilder: (context, index) {
                    final template = controller.templates[index];
                    final isSelected =
                        controller.selectedTemplate.value?.id == template.id;

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
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.all(8.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      template.previewImagePath,
                                    ),
                                    fit: BoxFit.cover,
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
    );
  }

  void _showClearDialog() {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.warning, color: AppColors.error),
            Gap(8.w),
            Text('Effacer le dessin'),
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
                'Effacé',
                'Le dessin a été effacé',
                backgroundColor: AppColors.greenPrimary.withOpacity(0.8),
                colorText: AppColors.white,
                duration: const Duration(seconds: 2),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: AppColors.white,
            ),
            child: Text('Effacer'),
          ),
        ],
      ),
    );
  }

  Color _getContrastColor(Color color) {
    // Calculate luminance to determine if white or black text is more readable
    final luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;
    return luminance > 0.5 ? Colors.black : Colors.white;
  }
}
