import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';

enum PlayAudioButtonSize {small, big}

class PlayAudioButton extends StatelessWidget {
  const PlayAudioButton({
    super.key,
    this.backgroundColor = AppColors.primary,
    this.buttonSize = PlayAudioButtonSize.small,
    this.onPressed,
  });

  final Color backgroundColor;
  final PlayAudioButtonSize buttonSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: switch(buttonSize) {
          PlayAudioButtonSize.small => 50,
          PlayAudioButtonSize.big => 80,
        },
        height: switch(buttonSize) {
          PlayAudioButtonSize.small => 50,
          PlayAudioButtonSize.big => 80,
        },
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: switch(buttonSize) {
            PlayAudioButtonSize.small => BorderRadius.circular(10),
          PlayAudioButtonSize.big => BorderRadius.circular(25),
          },
          boxShadow: CustomShadowStyle.customCircleShadows(
            color: backgroundColor,
          ),
        ),
        child: Icon(Icons.volume_up, color: AppColors.white, size: switch(buttonSize) {
          PlayAudioButtonSize.small => 30,
          PlayAudioButtonSize.big => 40,
        },),
      ),
    );
  }
}