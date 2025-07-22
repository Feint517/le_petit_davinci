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
        // Undo button
        Obx(
          () => _buildToolButton(
            icon: Icons.undo,
            onPressed:
                controller.drawingController.canUndo()
                    ? () => controller.undo()
                    : null,
            tooltip:
                'Annuler (${controller.drawingController.getHistory.length} actions)',
            isEnabled: controller.drawingController.canUndo(),
          ),
        ),

        Gap(8.w),

        // Redo button
        Obx(
          () => _buildToolButton(
            icon: Icons.redo,
            onPressed:
                controller.drawingController.canRedo()
                    ? () => controller.redo()
                    : null,
            tooltip: 'Refaire',
            isEnabled: controller.drawingController.canRedo(),
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
            isSelected: controller.selectedTool.value == DrawingTool.brush,
            onPressed: () => controller.selectTool(DrawingTool.brush),
            tooltip: 'Pinceau',
            selectedColor: AppColors.primary,
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
            selectedColor: AppColors.secondary,
          ),
        ),

        Gap(8.w),

        // Color indicator (shows current selected color)
        Obx(
          () => Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color:
                  controller.selectedTool.value == DrawingTool.eraser
                      ? AppColors.backgroundSecondary
                      : controller.selectedColor.value,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.borderPrimary, width: 2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child:
                controller.selectedTool.value == DrawingTool.eraser
                    ? Icon(
                      Icons.auto_fix_high,
                      color: AppColors.textSecondary,
                      size: 16.sp,
                    )
                    : null,
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
            Icon(
              Icons.line_weight,
              size: 14.sp,
              color: AppColors.textSecondary,
            ),
            Gap(4.w),
            Text(
              'Taille',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        Gap(4.h),

        Obx(
          () => Container(
            width: 120.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.borderPrimary, width: 1),
            ),
            child: Row(
              children:
                  controller.availableSizes.asMap().entries.map((entry) {
                    final index = entry.key;
                    final size = entry.value;
                    final isSelected = controller.brushSize.value == size;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.selectBrushSize(size),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? AppColors.white
                                    : Colors.transparent,
                            borderRadius: BorderRadius.circular(14.r),
                            boxShadow:
                                isSelected
                                    ? [
                                      BoxShadow(
                                        color: AppColors.black.withOpacity(0.1),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ]
                                    : null,
                          ),
                          child: Center(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: (size * 0.4).clamp(4.0, 16.0),
                              height: (size * 0.4).clamp(4.0, 16.0),
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
                      ),
                    );
                  }).toList(),
            ),
          ),
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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 44.w,
            height: 44.w,
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
            child: AnimatedScale(
              duration: const Duration(milliseconds: 100),
              scale: isSelected ? 1.1 : 1.0,
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(width: 1, height: 35.h, color: AppColors.borderPrimary);
  }

  void _showTemplateSelector() {
    Get.bottomSheet(
      Container(
        height: 300.h,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choisir un modèle',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'DynaPuff_SemiCondensed',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.selectTemplate(null);
                    Get.back();
                  },
                  child: Text(
                    'Dessin libre',
                    style: TextStyle(color: AppColors.primary, fontSize: 14.sp),
                  ),
                ),
              ],
            ),

            Gap(16.h),

            Expanded(
              child: Obx(
                () => GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: 0.8,
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
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color:
                                isSelected
                                    ? AppColors.primary
                                    : AppColors.borderPrimary,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: _getCategoryColor(
                                    template.category,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.r),
                                    topRight: Radius.circular(8.r),
                                  ),
                                ),
                                child: Icon(
                                  _getCategoryIcon(template.category),
                                  color: _getCategoryColor(template.category),
                                  size: 32.sp,
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
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange, size: 20.sp),
            Gap(8.w),
            Text(
              'Tout effacer?',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
          ],
        ),
        content: Text(
          'Tu vas perdre tout ton dessin actuel. Es-tu sûr de vouloir recommencer?',
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Non, garder',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.clearCanvas();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Oui, effacer tout',
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

  IconData _getCategoryIcon(TemplateCategory category) {
    switch (category) {
      case TemplateCategory.animals:
        return Icons.pets;
      case TemplateCategory.shapes:
        return Icons.category;
      case TemplateCategory.letters:
        return Icons.text_fields;
      case TemplateCategory.numbers:
        return Icons.numbers;
      case TemplateCategory.seasonal:
        return Icons.wb_sunny;
      case TemplateCategory.daily:
        return Icons.home;
    }
  }

  Color _getCategoryColor(TemplateCategory category) {
    switch (category) {
      case TemplateCategory.animals:
        return AppColors.greenPrimary;
      case TemplateCategory.shapes:
        return AppColors.secondary;
      case TemplateCategory.letters:
        return AppColors.primary;
      case TemplateCategory.numbers:
        return AppColors.accent;
      case TemplateCategory.seasonal:
        return AppColors.orangeAccent;
      case TemplateCategory.daily:
        return AppColors.pinkAccent;
    }
  }
}
