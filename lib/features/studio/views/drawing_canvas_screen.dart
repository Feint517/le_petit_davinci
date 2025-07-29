import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/widgets/drawing_toolbar.dart';
import 'package:le_petit_davinci/features/studio/widgets/color_palette.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';

class DrawingCanvasScreen extends GetView<StudioController> {
  final TemplateModel? template;
  final bool isLessonMode;
  final Function(String)? onComplete;

  const DrawingCanvasScreen({
    super.key,
    this.template,
    this.isLessonMode = false,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize template if provided
    if (template != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.initializeForLesson(template!);
      });
    }

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
          title:
              isLessonMode && template != null
                  ? Text(
                    template!.name,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'DynaPuff_SemiCondensed',
                    ),
                  )
                  : Obx(
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
            // Show different actions based on mode
            if (isLessonMode)
              // Complete button for lesson mode
              Obx(
                () => TextButton(
                  onPressed:
                      controller.isLoading.value
                          ? null
                          : () => _completeLesson(),
                  child: Text(
                    'Terminé',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            else
              // Quick save button for normal mode
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

            // Menu button (only in normal mode)
            if (!isLessonMode)
              PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  color: AppColors.textPrimary,
                  size: 24.sp,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                onSelected: (value) => _handleMenuAction(value),
                itemBuilder:
                    (context) => [
                      PopupMenuItem(
                        value: 'save',
                        child: Row(
                          children: [
                            Icon(Icons.save_alt, size: 20.sp),
                            Gap(12.w),
                            const Text('Sauvegarder'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'share',
                        child: Row(
                          children: [
                            Icon(Icons.share, size: 20.sp),
                            Gap(12.w),
                            const Text('Partager'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'new',
                        child: Row(
                          children: [
                            Icon(Icons.add, size: 20.sp),
                            Gap(12.w),
                            const Text('Nouveau dessin'),
                          ],
                        ),
                      ),
                    ],
              ),
          ],
        ),
        body: Column(
          children: [
            // Drawing toolbar
            const DrawingToolbar(),

            // Main drawing area
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
                      color: AppColors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return DrawingBoard(
                        controller: controller.drawingController,
                        background: Obx(() {
                          final selectedTemplate =
                              controller.selectedTemplate.value;
                          final templateToUse =
                              isLessonMode && template != null
                                  ? template
                                  : selectedTemplate;

                          if (templateToUse != null) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: constraints.maxWidth,
                                  height: constraints.maxHeight,
                                  color: Colors.white,
                                ),
                                Image.asset(
                                  templateToUse.templateImagePath,
                                  fit: BoxFit.contain,
                                  opacity: const AlwaysStoppedAnimation(0.3),
                                ),
                              ],
                            );
                          }

                          return Container(
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            color: Colors.white,
                          );
                        }),
                        showDefaultActions: false,
                        showDefaultTools: false,
                      );
                    },
                  ),
                ),
              ),
            ),

            // Color palette
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: const ColorPalette(),
            ),
          ],
        ),
      ),
    );
  }

  void _handleBackButton(BuildContext context) {
    if (controller.hasUnsavedChanges.value && !isLessonMode) {
      // Show save dialog only in normal mode
      _showUnsavedChangesDialog(context);
    } else if (isLessonMode) {
      // In lesson mode, show confirmation dialog
      _showLessonExitDialog(context);
    } else {
      Get.back();
    }
  }

  void _showLessonExitDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_amber, color: AppColors.warning, size: 24.sp),
            Gap(8.w),
            Text(
              'Quitter l\'exercice?',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
          ],
        ),
        content: Text(
          'Tu n\'as pas encore terminé ton dessin. Veux-tu vraiment quitter?',
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Continuer',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Return to lesson
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'Quitter',
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

  void _showUnsavedChangesDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Icon(Icons.warning_amber, color: AppColors.warning, size: 24.sp),
            Gap(8.w),
            Text(
              'Modifications non sauvegardées',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontFamily: 'DynaPuff_SemiCondensed',
              ),
            ),
          ],
        ),
        content: Text(
          'Tu as des modifications non sauvegardées. Que veux-tu faire?',
          style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Exit without saving
            },
            child: Text(
              'Quitter sans sauvegarder',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back(); // Close dialog
              await _quickSave();
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

  Future<void> _quickSave() async {
    await controller.saveArtwork();

    Get.snackbar(
      'Dessin sauvegardé!',
      'Ton chef-d\'œuvre a été sauvegardé dans ta galerie',
      backgroundColor: AppColors.greenPrimary,
      colorText: AppColors.white,
      snackPosition: SnackPosition.TOP,
      margin: EdgeInsets.all(16.w),
      borderRadius: 12.r,
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> _completeLesson() async {
    // Save the artwork with lesson-specific naming
    final artworkId = await controller.saveArtworkForLesson(
      lessonId: template?.id ?? 'lesson',
      activityName: template?.name ?? 'Dessin',
    );

    // Call the completion callback
    if (onComplete != null && artworkId != null) {
      onComplete!(artworkId);
    }

    // Return to lesson
    Get.back();
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'save':
        _quickSave();
        break;
      case 'share':
        _shareArtwork();
        break;
      case 'new':
        _startNewDrawing();
        break;
    }
  }

  void _shareArtwork() {
    if (controller.currentArtworkId.value.isNotEmpty) {
      controller.shareArtwork(controller.currentArtworkId.value);
    }
  }

  void _startNewDrawing() {
    if (controller.hasUnsavedChanges.value) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text(
            'Nouveau dessin?',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'DynaPuff_SemiCondensed',
            ),
          ),
          content: Text(
            'Cela effacera ton dessin actuel. Es-tu sûr?',
            style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
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
            ElevatedButton(
              onPressed: () {
                Get.back();
                controller.startNewArtwork();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Nouveau dessin',
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
    } else {
      controller.startNewArtwork();
    }
  }
}
