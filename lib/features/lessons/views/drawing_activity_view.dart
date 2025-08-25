import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/buttons/buttons.dart';
import 'package:le_petit_davinci/core/widgets/misc/talking_mascot.dart';
import 'package:le_petit_davinci/features/lessons/models/drawing_activity_model.dart';
import 'package:le_petit_davinci/features/lessons/widgets/drawing_area.dart';
import 'package:le_petit_davinci/features/studio/controllers/studio_controller.dart';

class DrawingActivityView extends StatelessWidget {
  const DrawingActivityView({super.key, required this.activity});

  final DrawingActivity activity;

  @override
  Widget build(BuildContext context) {
    Get.put(StudioController(), permanent: true);

    return Obx(() {
      //? The view simply switches based on the model's state.
      if (!activity.isIntroCompleted.value) {
        return _buildIntroUI();
      } else {
        // --- Main Activity UI ---
        return _buildDrawingCanvas();
      }
    });
  }

  Widget _buildIntroUI() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Obx(
          () => TalkingMascot(
            mascotSize: 220,
            bubbleText: activity.mascotController.currentMessage,
            onTap: activity.mascotController.nextMessage,
          ),
        ),

        // The button's visibility is also driven by the model's controller.
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Padding(
        //     padding: EdgeInsets.only(
        //       bottom: DeviceUtils.getBottomNavigationBarHeight() + 16,
        //     ),
        //     child: Obx(() {
        //       return AnimatedOpacity(
        //         opacity:
        //             activity.mascotController.isCompleted.value ? 1.0 : 0.0,
        //         duration: const Duration(milliseconds: 300),
        //         child:
        //             activity.mascotController.isCompleted.value
        //                 ? CustomButton(
        //                   label: 'Start Drawing',
        //                   width: DeviceUtils.getScreenWidth() * 0.6,
        //                   // The button does nothing; the model handles the transition automatically.
        //                   onPressed: () {},
        //                 )
        //                 : const SizedBox.shrink(),
        //       );
        //     }),
        //   ),
        // ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: DeviceUtils.getBottomNavigationBarHeight() + 16,
            ),
            child: Obx(() {
              return AnimatedOpacity(
                opacity:
                    activity.mascotController.isCompleted.value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child:
                    activity.mascotController.isCompleted.value
                        // Replace the button with a loading indicator.
                        ? const CircularProgressIndicator()
                        : const SizedBox.shrink(),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildDrawingCanvas() {
    final lessonDrawingController = Get.put(
      DrawingController(),
      tag: activity.hashCode.toString(),
    );

    lessonDrawingController.setStyle(color: Colors.blue, strokeWidth: 5.0);

    return Column(
      children: [
        DrawingArea(
          drawingController: lessonDrawingController,
          templateImagePath: activity.templateImagePath,
        ),
        SafeArea(
          right: false,
          top: false,
          left: false,
          child: CustomButton(
            label: "Finish",
            onPressed: () {
              activity.markDrawingAsCompleted();
              Get.delete<DrawingController>(tag: activity.hashCode.toString());
            },
          ),
        ),
      ],
    );
  }
}
