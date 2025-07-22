import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';
import 'package:le_petit_davinci/features/studio/widgets/drawing_toolbar.dart';

class DrawingCanvasScreen extends GetView<StudioController> {
  const DrawingCanvasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _handleBackButton(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: _buildAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              // FIXED: Properly constrained toolbar with SizedBox
              SizedBox(
                height: 70.h,
                child: const DrawingToolbar(),
              ),

              Divider(height: 1, color: AppColors.borderPrimary),

              // FIXED: Canvas area - properly expanded and structured
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.borderPrimary,
                      width: 2,
                    ),
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
                    child: _buildCanvasContent(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: () => _handleBackButton(Get.context!),
        icon: Icon(
          Icons.arrow_back,
          color: AppColors.textPrimary,
          size: 24.sp,
        ),
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
        // Quick save button
        Obx(
          () => IconButton(
            onPressed: controller.isLoading.value ? null : () => _quickSave(),
            icon: controller.isLoading.value
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : Icon(
                    Icons.save,
                    color: controller.hasUnsavedChanges.value
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    size: 24.sp,
                  ),
          ),
        ),

        // More options menu
        PopupMenuButton<String>(
          icon: Icon(
            Icons.more_vert,
            color: AppColors.textPrimary,
            size: 24.sp,
          ),
          onSelected: (value) => _handleMenuAction(value),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'save_as',
              child: Row(
                children: [
                  Icon(Icons.save_as, size: 16.sp),
                  Gap(8.w),
                  const Text('Sauvegarder sous...'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'share',
              child: Row(
                children: [
                  Icon(Icons.share, size: 16.sp),
                  Gap(8.w),
                  const Text('Partager'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'export',
              child: Row(
                children: [
                  Icon(Icons.file_download, size: 16.sp),
                  Gap(8.w),
                  const Text('Exporter'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'new',
              child: Row(
                children: [
                  Icon(Icons.add, size: 16.sp),
                  Gap(8.w),
                  const Text('Nouveau dessin'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCanvasContent() {
    return Stack(
      children: [
        // Template background (if selected)
        Obx(() {
          if (controller.selectedTemplate.value != null) {
            return Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      controller.selectedTemplate.value!.templateImagePath,
                    ),
                    fit: BoxFit.contain,
                    opacity: 0.3,
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }),

        // FIXED: High-performance drawing board with proper error handling
        RepaintBoundary(
          key: controller.canvasKey,
          child: _buildDrawingBoard(),
        ),

        // Template hint overlay
        Obx(() => _buildTemplateHint()),

        // Drawing mode indicator
        Obx(() => _buildDrawingModeIndicator()),
      ],
    );
  }

  Widget _buildDrawingBoard() {
    return DrawingBoard(
      controller: controller.drawingController,
      background: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
      ),
      showDefaultActions: false, // We use our custom toolbar
      showDefaultTools: false,
    );
  }

  Widget _buildTemplateHint() {
    if (controller.selectedTemplate.value != null &&
        controller.selectedTemplate.value!.educationalPrompt != null) {
      return Positioned(
        top: 16.h,
        left: 16.w,
        right: 16.w,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb,
                color: AppColors.white,
                size: 16.sp,
              ),
              Gap(8.w),
              Expanded(
                child: Text(
                  controller.selectedTemplate.value!.educationalPrompt!,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => controller.selectedTemplate.value = null,
                child: Icon(
                  Icons.close,
                  color: AppColors.white,
                  size: 16.sp,
                ),
              ),
            ],
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildDrawingModeIndicator() {
    return Positioned(
      bottom: 16.h,
      right: 16.w,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: controller.selectedTool.value == DrawingTool.eraser
              ? AppColors.error.withOpacity(0.9)
              : AppColors.primary.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              controller.selectedTool.value == DrawingTool.eraser
                  ? Icons.auto_fix_high
                  : Icons.brush,
              color: AppColors.white,
              size: 16.sp,
            ),
            Gap(4.w),
            Text(
              controller.selectedTool.value == DrawingTool.eraser
                  ? 'Gomme'
                  : 'Pinceau',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBackButton(BuildContext context) {
    if (controller.hasUnsavedChanges.value) {
      _showSaveDialog(context);
    } else {
      Get.back();
    }
  }

  void _showSaveDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Row(
          children: [
            Icon(Icons.save, color: AppColors.primary),
            Gap(8.w),
            const Text('Sauvegarder ?'),
          ],
        ),
        content: const Text(
          'Tu as des modifications non sauvegardées. Veux-tu sauvegarder avant de quitter ?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Go back to previous screen
            },
            child: Text(
              'Quitter sans sauver',
              style: TextStyle(color: AppColors.error),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Continuer',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back(); // Close dialog
              await controller.saveArtwork();
              Get.back(); // Go back after saving
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Sauvegarder'),
          ),
        ],
      ),
    );
  }

  Future<void> _quickSave() async {
    if (controller.currentArtworkId.value.isEmpty) {
      // New artwork - show save dialog with title input
      _showSaveAsDialog();
    } else {
      // Existing artwork - quick save
      await controller.saveArtwork();
    }
  }

  void _showSaveAsDialog() {
    final titleController = TextEditingController(
      text: controller.currentArtworkTitle.value,
    );

    Get.dialog(
      AlertDialog(
        title: const Text('Sauvegarder le dessin'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Titre du dessin',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                prefixIcon: Icon(Icons.title),
              ),
              maxLength: 50,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                controller.currentArtworkTitle.value = title;
                Get.back();
                await controller.saveArtwork(customTitle: title);
              } else {
                Get.snackbar('Erreur', 'Veuillez entrer un titre');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
            ),
            child: const Text('Sauvegarder'),
          ),
        ],
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'save_as':
        _showSaveAsDialog();
        break;
      case 'share':
        _shareCurrentArtwork();
        break;
      case 'export':
        _exportCurrentArtwork();
        break;
      case 'new':
        _createNewArtwork();
        break;
    }
  }

  Future<void> _shareCurrentArtwork() async {
    if (controller.currentArtworkId.value.isEmpty) {
      // Save first if not saved
      await controller.saveArtwork();
    }

    if (controller.currentArtworkId.value.isNotEmpty) {
      await controller.shareArtwork(controller.currentArtworkId.value);
    } else {
      Get.snackbar('Erreur', 'Impossible de partager le dessin');
    }
  }

  Future<void> _exportCurrentArtwork() async {
    if (controller.currentArtworkId.value.isEmpty) {
      // Save first if not saved
      await controller.saveArtwork();
    }

    if (controller.currentArtworkId.value.isNotEmpty) {
      await controller.exportArtwork(controller.currentArtworkId.value);
    } else {
      Get.snackbar('Erreur', 'Impossible d\'exporter le dessin');
    }
  }

  void _createNewArtwork() {
    if (controller.hasUnsavedChanges.value) {
      Get.dialog(
        AlertDialog(
          title: const Text('Nouveau dessin'),
          content: const Text(
            'Tu as des modifications non sauvegardées. Veux-tu créer un nouveau dessin ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () async {
                Get.back();
                await controller.saveArtwork();
                controller.startNewArtwork();
              },
              child: const Text('Sauver et nouveau'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back();
                controller.startNewArtwork();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Nouveau sans sauver'),
            ),
          ],
        ),
      );
    } else {
      controller.startNewArtwork();
    }
  }
}