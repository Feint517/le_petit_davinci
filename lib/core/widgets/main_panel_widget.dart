import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/misc/mascot_widget.dart';
import 'package:le_petit_davinci/routes/app_routes.dart';

/// Widget principal contenant la mascotte DaVinci et le bouton d'action
class MainPanelWidget extends StatelessWidget {
  final String speechText;
  final String buttonText;
  final VoidCallback? onButtonPressed;

  const MainPanelWidget({
    super.key,
    required this.speechText,
    required this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate automatic spacing based on mascot size
    final double mascotSize = 200.h;
    final double speechBubbleHeight = 80.h; // Estimated speech bubble height
    final double totalMascotHeight = mascotSize + speechBubbleHeight;
    final double containerTopPosition =
        totalMascotHeight * 0.6; // Container starts at 60% of mascot height
    final double mascotOverlapIntoContainer =
        totalMascotHeight - containerTopPosition;
    final double paddingBetweenMascotAndButton = 100.h; // Consistent gap
    final double containerTopPadding =
        mascotOverlapIntoContainer + paddingBetweenMascotAndButton;
    final double totalHeight =
        containerTopPosition +
        containerTopPadding +
        100.h; // 80h for button + bottom padding

    return SizedBox(
      width: double.infinity,
      height: totalHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          // White container positioned lower to leave space for mascot
          Positioned(
            top: containerTopPosition,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                left: 24.w,
                right: 24.w,
                top: containerTopPadding,
                bottom: 24.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 8),
                    blurRadius: 24,
                    color: Colors.black.withValues(alpha: 0.1),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Button at the bottom of white container
                  CustomButton(
                    label: buttonText,
                    icon: Icon(Icons.arrow_forward, color: Colors.white),
                    iconPosition: IconPosition.right,
                    variant: ButtonVariant.secondary,
                    size: ButtonSize.lg,
                    width: double.infinity,
                    onPressed: onButtonPressed ?? _defaultButtonAction,
                  ),
                ],
              ),
            ),
          ),

          // Mascot with speech bubble positioned at the top, outside white box
          Positioned(
            top: containerTopPosition - mascotSize * 0.6, // Adjusted to overlap
            left: 0,
            right: 0,
            child: MascotWidget(
              speechText: speechText,
              bubbleColor: AppColors.bluePrimary,
              mascotSize: mascotSize, // Use calculated mascot size
              maxBubbleWidth: 320.w,
              textSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }

  /// Action par défaut du bouton (navigation vers questions screen)
  void _defaultButtonAction() {
    print('MainPanelWidget button pressed: $buttonText');
    debugPrint('Navigation to questions screen...');
    Get.toNamed(AppRoutes.question);
  }
}
