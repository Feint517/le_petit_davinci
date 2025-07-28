import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';
import 'package:le_petit_davinci/features/studio/models/artwork_model.dart';
import 'package:le_petit_davinci/features/studio/views/drawing_canvas_screen.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

class TemplateSelectionScreen extends GetView<StudioController> {
  const TemplateSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        title: Text(
          'Choisir un Modèle',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                    Gap(12.w),
                    Expanded(
                      child: Text(
                        'Sélectionne un modèle pour t\'aider à dessiner. Tu peux colorier ou décorer comme tu veux!',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Gap(24.h),

              // Category tabs
              _buildCategoryTabs(),

              Gap(20.h),

              // Templates grid
              Expanded(child: Obx(() => _buildTemplatesGrid())),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 40.h,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children:
            TemplateCategory.values.map((category) {
              return Padding(
                padding: EdgeInsets.only(right: 12.w),
                child: _buildCategoryTab(category),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildCategoryTab(TemplateCategory category) {
    final isSelected = true; // For now, show all categories as active

    return GestureDetector(
      onTap: () {
        // TODO: Filter templates by category
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Center(
          child: Text(
            _getCategoryName(category),
            style: TextStyle(
              color: isSelected ? AppColors.white : AppColors.primary,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTemplatesGrid() {
    final templates = controller.templates;

    if (templates.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 80.sp,
              color: AppColors.textSecondary,
            ),
            Gap(16.h),
            Text(
              'Aucun modèle disponible',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8.h),
            Text(
              'Plus de modèles arrivent bientôt!',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
        childAspectRatio: 0.75,
      ),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return _buildTemplateCard(template);
      },
    );
  }

  Widget _buildTemplateCard(TemplateModel template) {
    return GestureDetector(
      onTap: () {
        controller.selectTemplate(template);
        Get.to(() => const DrawingCanvasScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: CustomShadowStyle.customCircleShadows(
            color: AppColors.white,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Template preview
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.backgroundSecondary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  child: Stack(
                    children: [
                      // Template image placeholder
                      Center(
                        child: Container(
                          width: 80.w,
                          height: 80.w,
                          decoration: BoxDecoration(
                            color: _getCategoryColor(template.category),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            _getCategoryIcon(template.category),
                            color: AppColors.white,
                            size: 40.sp,
                          ),
                        ),
                      ),

                      // Difficulty indicator
                      Positioned(
                        top: 8.h,
                        right: 8.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: _getDifficultyColor(template.difficulty),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              3,
                              (index) => Icon(
                                index < template.difficulty
                                    ? Icons.star
                                    : Icons.star_border,
                                color: AppColors.white,
                                size: 10.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Template info
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template.name,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Gap(4.h),

                  Text(
                    _getCategoryName(template.category),
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12.sp,
                    ),
                  ),

                  if (template.educationalPrompt != null) ...[
                    Gap(8.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        template.educationalPrompt!,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getCategoryName(TemplateCategory category) {
    switch (category) {
      case TemplateCategory.animals:
        return 'Animaux';
      case TemplateCategory.shapes:
        return 'Formes';
      case TemplateCategory.letters:
        return 'Lettres';
      case TemplateCategory.numbers:
        return 'Nombres';
      case TemplateCategory.seasonal:
        return 'Saisons';
      case TemplateCategory.daily:
        return 'Quotidien';
    }
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

  Color _getDifficultyColor(int difficulty) {
    switch (difficulty) {
      case 1:
        return AppColors.greenPrimary;
      case 2:
        return AppColors.orangeAccent;
      case 3:
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }
}
