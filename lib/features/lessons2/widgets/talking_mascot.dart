import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/widgets/images/responsive_image_asset.dart';
import 'package:le_petit_davinci/core/widgets/misc/chat_bubble.dart';

class TalkingMascotController extends GetxController {
  final List<String> messages;
  final Function() onCompleted;

  final RxInt currentIndex = 0.obs;
  final RxBool isCompleted = false.obs;

  TalkingMascotController({required this.messages, required this.onCompleted});

  String get currentMessage => messages[currentIndex.value];

  void nextMessage() {
    if (currentIndex.value < messages.length - 1) {
      currentIndex.value++;
    } else if (!isCompleted.value) {
      isCompleted.value = true;
      onCompleted();
    }
  }

  void reset() {
    currentIndex.value = 0;
    isCompleted.value = false;
  }
}

class TalkingMascot extends StatelessWidget {
  const TalkingMascot({
    super.key,
    this.mascotSize = 300,
    required this.bubbleText,
    this.onTap,
  });

  final double mascotSize;
  final String bubbleText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ResponsiveImageAsset(
            assetPath: SvgAssets.bearMasscot,
            width: mascotSize,
            height: mascotSize,
          ),
          ChatBubble(
            bubbleText: bubbleText,
            bubbleColor: AppColors.accent,
            width: 200,
          ),
        ],
      ),
    );
  }
}
