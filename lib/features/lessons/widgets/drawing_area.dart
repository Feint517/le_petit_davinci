// No longer extends GetView<StudioController>
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class DrawingArea extends StatelessWidget {
  // It now requires the specific controller and image path for the canvas.
  final DrawingController drawingController;
  final String? templateImagePath;

  const DrawingArea({
    super.key,
    required this.drawingController,
    this.templateImagePath,
  });

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
                controller: drawingController,
                background:
                    templateImagePath != null
                        ? Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          color: Colors.white,
                          child: Image.asset(
                            templateImagePath!,
                            fit: BoxFit.fitWidth,
                            opacity: const AlwaysStoppedAnimation(0.3),
                          ),
                        )
                        : Container(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight,
                          color: Colors.white,
                        ),
              );
            },
          ),
        ),
      ),
    );
  }
}
