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
      if (!mascotMixin.isIntroCompleted.value) {
        return _buildIntroScreen();
      } else {
        return activity;
      }
    });
  }

  Widget _buildIntroScreen() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Mascot
        Obx(
          () => TalkingMascot(
            mascotSize: 220,
            bubbleText: mascotMixin.currentMascotMessage,
            onTap: () {
              if (mascotMixin.isInitialized) {
                mascotMixin.mascotController.nextMessage();
              }
            },
          ),
        ),

        // Start button (appears when mascot is done talking)
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: DeviceUtils.getBottomNavigationBarHeight() + 16,
            ),
            child: Obx(() {
              return AnimatedOpacity(
                opacity: mascotMixin.isMascotCompleted ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child:
                    mascotMixin.isMascotCompleted
                        ? CircularProgressIndicator(color: AppColors.accent)
                        : const SizedBox.shrink(),
              );
            }),
          ),
        ),
      ],
    );
  }
}
