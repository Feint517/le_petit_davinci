import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/styles/shadows.dart';
import 'package:le_petit_davinci/core/widgets/images/circular_image.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    this.isExpanded = false,
    this.onTap,
    required this.name,
    required this.subInfo,
    required this.image,
    required this.backgroundColor,
    this.imageBackgroundColor,
  });

  final bool isExpanded;
  final VoidCallback? onTap;
  final String name;
  final String subInfo;
  final String image;
  final Color backgroundColor;
  final Color? imageBackgroundColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.sm),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: backgroundColor,
          boxShadow: CustomShadowStyle.customCircleShadows(
            color: backgroundColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomCircularImage(
              image: image,
              boderColor: backgroundColor,
              backgroundColor: imageBackgroundColor,
            ),
            if (isExpanded) const Gap(AppSizes.sm),
            if (isExpanded)
              Column(
                children: [
                  Text(
                    name,
                    style: Theme.of(
                      context,
                    ).textTheme.headlineMedium!.apply(color: AppColors.white),
                  ),
                  Text(
                    subInfo,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge!.apply(color: AppColors.white),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
