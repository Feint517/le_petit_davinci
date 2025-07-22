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
import 'package:le_petit_davinci/features/studio/widgets/color_palette.dart';

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
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => _handleBackButton(context),
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
                onPressed:
                    controller.isLoading.value ? null : () => _quickSave(),
                icon:
                    controller.isLoading.value
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
                          color:
                              controller.hasUnsavedChanges.value
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                          size: 24.sp,
                        ),
              ),
            ),

            // Menu button
            PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert,
                color: AppColors.textPrimary,
                size: 24.sp,
              ),
              itemBuilder:
                  (context) => [
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
                          Icon(Icons.family_restroom, size: 16.sp),
                          Gap(8.w),
                          const Text('Partager avec parents'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'export',
                      child: Row(
                        children: [
                          Icon(Icons.share, size: 16.sp),
                          Gap(8.w),
                          const Text('Exporter'),
                        ],
                      ),
                    ),
                  ],
              onSelected: (value) {
                switch (value) {
                  case 'save_as':
                    _showSaveDialog(context);
                    break;
                  case 'share':
                    _shareCurrentArtwork();
                    break;
                  case 'export':
                    _exportCurrentArtwork();
                    break;
                }
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              // Enhanced toolbar
              const DrawingToolbar(),

              Divider(height: 1, color: AppColors.borderPrimary),

              // Canvas area with professional drawing board
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
                    child: Stack(
                      children: [
                        // Template background (if selected)
                        Obx(() {
                          if (controller.selectedTemplate.value != null) {
                            return Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      controller
                                          .selectedTemplate
                                          .value!
                                          .templateImagePath,
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

                        // High-performance drawing board
                        RepaintBoundary(
                          key: controller.canvasKey,
                          child: DrawingBoard(
                            controller: controller.drawingController,
                            background: Container(
                              width: double.infinity,
                              height: double.infinity,
                              color: Colors.transparent,
                            ),
                            showDefaultActions:
                                false, // We'll use our custom toolbar
                            showDefaultTools: false,
                          ),
                        ),

                        // Template hint overlay
                        Obx(() {
                          if (controller.selectedTemplate.value != null &&
                              controller
                                      .selectedTemplate
                                      .value!
                                      .educationalPrompt !=
                                  null) {
                            return Positioned(
                              top: 16.h,
                              left: 16.w,
                              right: 16.w,
                              child: Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(8.r),
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
                                        controller
                                            .selectedTemplate
                                            .value!
                                            .educationalPrompt!,
                                        style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // Hide hint by removing template (optional)
                                      },
                                      child: Icon(
                                        Icons.close,
                                        color: AppColors.white,
                                        size: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),

                        // Canvas status indicator
                        Positioned(
                          bottom: 16.h,
                          right: 16.w,
                          child: Obx(
                            () => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 4.h,
                              ),
                              decoration: BoxDecoration(
                                color:
                                    controller.hasUnsavedChanges.value
                                        ? Colors.orange.withOpacity(0.9)
                                        : Colors.green.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    controller.hasUnsavedChanges.value
                                        ? Icons.edit
                                        : Icons.check,
                                    color: AppColors.white,
                                    size: 12.sp,
                                  ),
                                  Gap(4.w),
                                  Text(
                                    controller.hasUnsavedChanges.value
                                        ? 'Non sauvé'
                                        : 'Sauvé',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Enhanced color palette
              const ColorPalette(),

              Gap(16.h),
            ],
          ),
        ),

        // Floating action buttons for common actions
        floatingActionButton: Obx(
          () =>
              controller.hasUnsavedChanges.value
                  ? Container(
                    margin: EdgeInsets.only(bottom: 20.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Undo button
                        FloatingActionButton.small(
                          heroTag: "undo",
                          onPressed:
                              controller.drawingController.canUndo()
                                  ? () => controller.undo()
                                  : null,
                          backgroundColor:
                              controller.drawingController.canUndo()
                                  ? AppColors.secondary
                                  : AppColors.textSecondary,
                          child: Icon(
                            Icons.undo,
                            color: AppColors.white,
                            size: 18.sp,
                          ),
                        ),

                        Gap(8.h),

                        // Redo button
                        FloatingActionButton.small(
                          heroTag: "redo",
                          onPressed:
                              controller.drawingController.canRedo()
                                  ? () => controller.redo()
                                  : null,
                          backgroundColor:
                              controller.drawingController.canRedo()
                                  ? AppColors.accent
                                  : AppColors.textSecondary,
                          child: Icon(
                            Icons.redo,
                            color: AppColors.white,
                            size: 18.sp,
                          ),
                        ),
                      ],
                    ),
                  )
                  : const SizedBox.shrink(),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }

  void _handleBackButton(BuildContext context) {
    if (controller.hasUnsavedChanges.value) {
      _showExitDialog(context);
    } else {
      Get.back();
    }
  }

  void _quickSave() async {
    if (controller.drawingController.getHistory.isEmpty) {
      Get.snackbar(
        'Attention',
        'Dessine quelque chose avant de sauvegarder!',
        backgroundColor: Colors.orange.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    await controller.saveArtwork();
  }

  void _shareCurrentArtwork() async {
    if (controller.currentArtworkId.value.isEmpty) {
      // Save first, then share
      await controller.saveArtwork();
      if (controller.currentArtworkId.value.isNotEmpty) {
        await controller.shareWithParent(controller.currentArtworkId.value);
      }
    } else {
      await controller.shareWithParent(controller.currentArtworkId.value);
    }
  }

  void _exportCurrentArtwork() async {
    if (controller.currentArtworkId.value.isEmpty) {
      // Save first, then export
      await controller.saveArtwork();
      if (controller.currentArtworkId.value.isNotEmpty) {
        await controller.exportArtwork(controller.currentArtworkId.value);
      }
    } else {
      await controller.exportArtwork(controller.currentArtworkId.value);
    }
  }

  void _showExitDialog(BuildContext context) {
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
              'Quitter le dessin?',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
          ],
        ),
        content: Text(
          'Tu as des modifications non sauvegardées. Veux-tu sauvegarder ton dessin avant de partir?',
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Exit drawing screen without saving
            },
            child: Text(
              'Quitter sans sauver',
              style: TextStyle(color: AppColors.error, fontSize: 14.sp),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(), // Just close dialog
            child: Text(
              'Continuer le dessin',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back(); // Close dialog
              await controller.saveArtwork();
              Get.back(); // Exit after saving
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Sauvegarder et quitter',
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
    bool shareWithParents = false;

    Get.dialog(
      StatefulBuilder(
        builder:
            (context, setState) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              title: Row(
                children: [
                  Icon(Icons.save, color: AppColors.primary, size: 20.sp),
                  Gap(8.w),
                  Text(
                    'Sauvegarder le dessin',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DynaPuff_SemiCondensed',
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Nom du dessin',
                      hintText: 'Mon super dessin...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                    ),
                    style: TextStyle(fontSize: 14.sp),
                    maxLength: 30,
                  ),

                  Gap(16.h),

                  CheckboxListTile(
                    value: shareWithParents,
                    onChanged: (value) {
                      setState(() {
                        shareWithParents = value ?? false;
                      });
                    },
                    title: Text(
                      'Partager avec mes parents',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    subtitle: Text(
                      'Papa et maman pourront voir ton dessin et te laisser des messages!',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    activeColor: AppColors.primary,
                    contentPadding: EdgeInsets.zero,
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: Text(
                    'Annuler',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                Obx(
                  () => ElevatedButton(
                    onPressed:
                        controller.isLoading.value
                            ? null
                            : () async {
                              final title = titleController.text.trim();
                              if (title.isEmpty) {
                                Get.snackbar(
                                  'Attention',
                                  'Donne un nom à ton dessin!',
                                  backgroundColor: Colors.orange.withOpacity(
                                    0.8,
                                  ),
                                  colorText: Colors.white,
                                );
                                return;
                              }

                              await controller.saveArtwork(title: title);

                              if (shareWithParents &&
                                  controller
                                      .currentArtworkId
                                      .value
                                      .isNotEmpty) {
                                await controller.shareWithParent(
                                  controller.currentArtworkId.value,
                                );
                              }

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
      ),
    );
  }
}
