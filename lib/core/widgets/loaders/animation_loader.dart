import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:lottie/lottie.dart';

//? a widget for displaying an animated loading indicator with optional text and action button
class CustomAnimationLoader extends StatelessWidget {
  const CustomAnimationLoader({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });

  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(animation, width: DeviceUtils.getScreenWidth() * 0.8),
          const Gap(AppSizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const Gap(AppSizes.defaultSpace),
          showAction
              ? SizedBox(
                width: 250,
                child: OutlinedButton(
                  onPressed: onActionPressed,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: AppColors.dark,
                  ),
                  child: Text(
                    actionText ?? '',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.apply(color: AppColors.light),
                  ),
                ),
              )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
