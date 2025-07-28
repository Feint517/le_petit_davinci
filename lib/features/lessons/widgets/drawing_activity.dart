import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/features/lessons/controllers/lesson_controller.dart';

class DrawingActivity extends GetView<LessonController> {
  const DrawingActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  final template = Template(
                    templateImagePath: ImageAssets.drawableA,
                    templateName: 'Drawing Template',
                  );

                  //? If a template exists, stack it on top of the sized container.
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        color: Colors.white,
                      ),
                      Image.asset(
                        template.templateImagePath,
                        fit: BoxFit.contain,
                        opacity: const AlwaysStoppedAnimation(0.3),
                      ),
                    ],
                  );
                }),
                showDefaultActions: false,
                showDefaultTools: false,
              );
            },
          ),
        ),
      ),
    );
  }
}
