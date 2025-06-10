import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

enum BubbleType { completed, active, locked }

class LessonSpeechBubble extends StatelessWidget {
  final String text;
  final BubbleType type;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const LessonSpeechBubble({
    super.key,
    required this.text,
    required this.type,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 120.w,
        height: height ?? 60.h,
        child: CustomPaint(
          painter: SpeechBubblePainter(
            color: _getBubbleColor(),
            borderColor: _getBorderColor(),
            showPointer: true,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (type == BubbleType.completed)
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                  if (type == BubbleType.completed) SizedBox(width: 4.w),
                  Flexible(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: _getTextColor(),
                        fontFamily: 'DynaPuff_SemiCondensed',
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _getBubbleColor() {
    switch (type) {
      case BubbleType.completed:
        return AppColors.bluePrimary;
      case BubbleType.active:
        return Colors.white;
      case BubbleType.locked:
        return Colors.grey[300]!;
    }
  }

  Color _getBorderColor() {
    switch (type) {
      case BubbleType.completed:
        return AppColors.bluePrimaryDark;
      case BubbleType.active:
        return AppColors.bluePrimary;
      case BubbleType.locked:
        return Colors.grey[400]!;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case BubbleType.completed:
        return Colors.white;
      case BubbleType.active:
        return AppColors.textPrimary;
      case BubbleType.locked:
        return Colors.grey[600]!;
    }
  }
}

class SpeechBubblePainter extends CustomPainter {
  final Color color;
  final Color borderColor;
  final bool showPointer;

  SpeechBubblePainter({
    required this.color,
    required this.borderColor,
    this.showPointer = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final path = Path();
    const radius = 12.0;
    const pointerHeight = 8.0;
    const pointerWidth = 12.0;

    // Start from top-left
    path.moveTo(radius, 0);
    
    // Top side
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: const Radius.circular(radius),
    );
    
    // Right side
    path.lineTo(size.width, size.height - radius - pointerHeight);
    path.arcToPoint(
      Offset(size.width - radius, size.height - pointerHeight),
      radius: const Radius.circular(radius),
    );
    
    // Bottom side with pointer
    if (showPointer) {
      path.lineTo(size.width / 2 + pointerWidth / 2, size.height - pointerHeight);
      path.lineTo(size.width / 2, size.height);
      path.lineTo(size.width / 2 - pointerWidth / 2, size.height - pointerHeight);
    }
    
    path.lineTo(radius, size.height - pointerHeight);
    path.arcToPoint(
      Offset(0, size.height - radius - pointerHeight),
      radius: const Radius.circular(radius),
    );
    
    // Left side
    path.lineTo(0, radius);
    path.arcToPoint(
      const Offset(radius, 0),
      radius: const Radius.circular(radius),
    );

    // Draw filled bubble
    canvas.drawPath(path, paint);
    
    // Draw border
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}