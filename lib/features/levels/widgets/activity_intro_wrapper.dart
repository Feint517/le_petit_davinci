import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/levels/mixin/mascot_introduction_mixin.dart';

/// A reusable widget that wraps any activity with a standardized
/// mascot introduction screen.
class ActivityIntroWrapper extends StatelessWidget {
  const ActivityIntroWrapper({
    super.key,
    required this.activity,
    required this.mascotMixin,
  });

  final Widget activity;
  final MascotIntroductionMixin mascotMixin;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          // Always show the activity content
          activity,
          
          // Show mascot overlay on top when intro is not completed
          if (!mascotMixin.isIntroCompleted.value)
            _buildMascotOverlay(),
        ],
      );
    });
  }

  Widget _buildMascotOverlay() {
    return Container(
      // Semi-transparent background to dim the activity behind
      color: Colors.black.withOpacity(0.3),
      child: Stack(
        children: [
          // Mascot positioned at bottom left
          Positioned(
            left: 16,
            bottom: DeviceUtils.getBottomNavigationBarHeight() + 16,
            child: mascotMixin.isInitialized && mascotMixin.mascotController != null
                ? Obx(
                    () => TalkingMascot(
                      mascotSize: 220,
                      bubbleText: mascotMixin.mascotController!.currentMessage,
                      onTap: () {
                        mascotMixin.mascotController!.nextMessage();
                      },
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Start button (appears when mascot is done talking)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: DeviceUtils.getBottomNavigationBarHeight() + 16,
              ),
              child: mascotMixin.isInitialized && mascotMixin.mascotController != null
                  ? Obx(() {
                      final isCompleted = mascotMixin.mascotController!.isCompleted.value;
                      return AnimatedOpacity(
                        opacity: isCompleted ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: isCompleted
                            ? CircularProgressIndicator(color: AppColors.accent)
                            : const SizedBox.shrink(),
                      );
                    })
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
