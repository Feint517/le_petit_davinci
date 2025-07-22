import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
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
                    // FINAL FIX: Use a LayoutBuilder to get the available constraints.
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // The LayoutBuilder provides the exact width and height the
                        // DrawingBoard can occupy.
                        return DrawingBoard(
                          controller: controller.drawingController,
                          // BEST PRACTICE: Pass these constraints to the background widget.
                          // This gives the background a definite size, which the DrawingBoard
                          // needs to initialize its canvas correctly.
                          background: Obx(() {
                            final template = controller.selectedTemplate.value;
                            // Create a base background container with the EXACT size
                            // from the LayoutBuilder.
                            Widget backgroundWidget = Container(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              color: Colors.white,
                            );

                            if (template != null) {
                              // If a template exists, stack it on top of the sized container.
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  backgroundWidget,
                                  Image.asset(
                                    template.templateImagePath,
                                    fit: BoxFit.contain,
                                    opacity: const AlwaysStoppedAnimation(0.3),
                                  ),
                                ],
                              );
                            }

                            return backgroundWidget;
                          }),
                          showDefaultActions: false,
                          showDefaultTools: false,
                        );
                      },
                    ),
                  ),
                ),
              ),
              const ColorPalette(),
              Gap(16.h),
            ],
          ),
        ),
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
              Get.back();
              Get.back();
            },
            child: Text(
              'Quitter sans sauver',
              style: TextStyle(color: AppColors.error, fontSize: 14.sp),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Continuer le dessin',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();
              await controller.saveArtwork();
              Get.back();
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
                              await controller.saveArtwork(customTitle: title);
                              if (shareWithParents &&
                                  controller
                                      .currentArtworkId
                                      .value
                                      .isNotEmpty) {
                                await controller.shareWithParent(
                                  controller.currentArtworkId.value,
                                );
                              }
                              Get.back();
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
