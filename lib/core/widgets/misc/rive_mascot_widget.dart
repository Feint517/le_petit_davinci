import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rive/rive.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';

enum BubblePosition { left, center, right }

/// A reusable widget for displaying a mascot with a speech bubble using Rive animation.
class RiveMascotWidget extends StatelessWidget {
  /// The text to display in the speech bubble
  final String speechText;

  /// The path to the Rive animation file
  final String riveAssetPath;

  /// Background color for the bubble (optional)
  final Color bubbleColor;

  /// Text color for the bubble (optional)
  final Color? textColor;

  /// Size of the mascot (optional, default 120.h)
  final double? mascotSize;

  /// Maximum width of the speech bubble (optional)
  final double? maxBubbleWidth;

  /// Text size in the bubble (optional)
  final double? textSize;

  /// Position of the bubble relative to the mascot (optional, default center)
  final BubblePosition bubblePosition;

  /// Animation name to play (optional, will use first animation if not specified)
  final String? animationName;

  const RiveMascotWidget({
    super.key,
    required this.speechText,
    required this.riveAssetPath,
    this.bubbleColor = AppColors.primary,
    this.textColor,
    this.mascotSize,
    this.maxBubbleWidth,
    this.textSize,
    this.bubblePosition = BubblePosition.center,
    this.animationName,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate approximate text height to adjust mascot position
    final textSpan = TextSpan(
      text: speechText,
      style: TextStyle(
        fontSize: textSize ?? 14.sp,
        fontWeight: FontWeight.w500,
        fontFamily: 'DynaPuff_SemiCondensed',
        height: 1.3,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      maxLines: 10,
    );

    // Adjust constrained width for calculation
    final maxWidth = maxBubbleWidth ?? 280.w;
    textPainter.layout(
      maxWidth: maxWidth - 32.w,
    ); // Subtract horizontal padding

    // Adjust vertical spacing based on text height
    final textHeight = textPainter.height;
    final adjustedSpacing =
        (textHeight > 100) ? 16.h + (textHeight / 10).h : 8.h;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //* Speech bubble positioned above mascot
        _buildSpeechBubble(),

        //* Spacing between bubble and mascot, adjusted dynamically
        Gap(adjustedSpacing),

        //* Rive animated mascot
        SizedBox(
          width: mascotSize ?? 120.h,
          height: mascotSize ?? 120.h,
          child: RiveAnimation.asset(
            riveAssetPath,
            fit: BoxFit.contain,
            onInit: (artboard) {
              final controller = _getAnimationController(artboard);
              if (controller != null) {
                artboard.addController(controller);
              }
            },
          ),
        ),
      ],
    );
  }

  /// Get the appropriate animation controller based on animationName or first available
  RiveAnimationController? _getAnimationController(Artboard artboard) {
    if (artboard.animations.isEmpty) return null;

    if (animationName != null) {
      // Try to find the specified animation
      final namedAnimation =
          artboard.animations
              .where((anim) => anim.name == animationName)
              .firstOrNull;
      if (namedAnimation != null) {
        return SimpleAnimation(namedAnimation.name);
      }
    }

    // Fallback to first animation
    final firstAnimation = artboard.animations.first;
    return SimpleAnimation(firstAnimation.name);
  }

  /// Build the speech bubble with text
  Widget _buildSpeechBubble() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: maxBubbleWidth ?? 280.w,
        minWidth: 160.w,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Main bubble body
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
                  fontFamily: 'DynaPuff_SemiCondensed',
                  height: 1.3,
                ),
                textAlign: _getTextAlignment(),
              ),
            ),
          ),

          // Bubble tail (pointer to mascot)
          Positioned(
            bottom: -6.h,
            left: 0,
            right: 0,
            child: _buildBubbleTail(),
          ),
        ],
      ),
    );
  }

  /// Determine text alignment based on bubble position
  TextAlign _getTextAlignment() {
    switch (bubblePosition) {
      case BubblePosition.left:
        return TextAlign.left;
      case BubblePosition.center:
        return TextAlign.center;
      case BubblePosition.right:
        return TextAlign.right;
    }
  }

  /// Build the bubble tail positioned according to bubblePosition
  Widget _buildBubbleTail() {
    Widget tail = CustomPaint(
      size: Size(12.w, 8.h),
      painter: _BubbleTailPainter(color: bubbleColor),
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

/// Custom painter for drawing the speech bubble tail
class _BubbleTailPainter extends CustomPainter {
  final Color color;

  const _BubbleTailPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final Path path = Path();

    // Create triangular tail shape
    path.moveTo(size.width / 2 - 6, 0); // Left point
    path.lineTo(size.width / 2 + 6, 0); // Right point
    path.lineTo(size.width / 2, size.height); // Bottom point (center)
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
