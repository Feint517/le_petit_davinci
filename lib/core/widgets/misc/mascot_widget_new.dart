import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';

enum BubblePosition { left, center, right }

class MascotWidgetNew extends StatelessWidget {
  const MascotWidgetNew({
    super.key,
    required this.speechText,
    this.assetPath = SvgAssets.bearMasscot,
    this.bubbleColor = AppColors.primary,
    this.textColor,
    this.maxBubbleWidth,
    this.bubblePosition = BubblePosition.center,
  });

  final String speechText;
  final String assetPath;
  final Color bubbleColor;
  final Color? textColor;
  final double? maxBubbleWidth;
  final BubblePosition bubblePosition;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //* Bulle de dialogue positioned above mascot
        SpeechBubble(speechText: speechText),

        //* Espacement entre la bulle et la mascotte, ajusté dynamiquement
        // Gap(adjustedSpacing),
        const Gap(AppSizes.md),

        //* Mascotte
        ResponsiveImageAsset(assetPath: assetPath, width: 120),
      ],
    );
  }
}

class SpeechBubble extends StatelessWidget {
  const SpeechBubble({
    super.key,
    required this.speechText,
    this.bubbleColor = AppColors.primary,
    this.textColor,
    this.maxBubbleWidth,
    this.textSize,
    this.bubblePosition = BubblePosition.center,
  });

  final String speechText;
  final Color bubbleColor;
  final Color? textColor;
  final double? maxBubbleWidth;
  final double? textSize;
  final BubblePosition bubblePosition;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxBubbleWidth ?? 280.w,
        minWidth: 160.w,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: maxBubbleWidth,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: CustomShadowStyle.customCircleShadows(
                color: bubbleColor,
              ),
            ),
            child: SingleChildScrollView(
              child: Text(
                speechText,
                style: TextStyle(
                  fontSize: textSize ?? 14.sp,
                  fontWeight: FontWeight.w500,
                  color: textColor ?? AppColors.white,
                  height: 1.3,
                ),
                textAlign: switch (bubblePosition) {
                  BubblePosition.left => TextAlign.left,
                  BubblePosition.center => TextAlign.center,
                  BubblePosition.right => TextAlign.right,
                },
              ),
            ),
          ),

          //* bubble tail
          Positioned(
            bottom: -6.h,
            left: 0,
            right: 0,
            child: BubbleTail(
              color: bubbleColor,
              bubblePosition: bubblePosition,
            ),
          ),
        ],
      ),
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  final Color color;

  const _BubbleTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final Path path =
        Path()
          ..moveTo(size.width / 2 - 6, 0) //? Point gauche
          ..lineTo(size.width / 2 + 6, 0) //? Point droit
          ..lineTo(size.width / 2, size.height) //? Point du bas (centre)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BubbleTail extends StatelessWidget {
  const BubbleTail({
    super.key,
    required this.color,
    required this.bubblePosition,
  });

  final Color color;
  final BubblePosition bubblePosition;

  @override
  Widget build(BuildContext context) {
    Widget tail = CustomPaint(
      size: Size(12.w, 8.h),
      painter: _BubbleTailPainter(color: color),
    );
    switch (bubblePosition) {
      case BubblePosition.left:
        return Align(
          alignment: Alignment.centerLeft,
          child: Padding(padding: EdgeInsets.only(left: 20.w), child: tail),
        );
      case BubblePosition.center:
        return Center(child: tail);
      case BubblePosition.right:
        return Align(
          alignment: Alignment.centerRight,
          child: Padding(padding: EdgeInsets.only(right: 20.w), child: tail),
        );
    }
  }
}
