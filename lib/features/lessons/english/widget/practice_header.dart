// You can place this in the same file or extract it if you want
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/badges/lesson_badge.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/navbar.dart';

class PracticeHeader extends StatelessWidget {
  const PracticeHeader({
    super.key,
    required this.lessonName,
    this.lessonDescription,
    required this.badgeVariant,
    required this.badgeType,
    this.showNavBar = true,
    this.showBadge = true,
  });

  final bool showNavBar;
  final bool showBadge;
  final String lessonName;
  final String? lessonDescription;
  final BadgeVariant badgeVariant;
  final LessonBadgeType badgeType;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Gap(DeviceUtils.getAppBarHeight()),
        //CustomNavBar(activeChip: true, variant: badgeVariant),
        const Gap(AppSizes.spaceBtwSections),

        Text(lessonName, textAlign: TextAlign.center),
        Gap(AppSizes.spaceBtwItems / 2),

        if (lessonDescription != null)
          Text(lessonDescription!, textAlign: TextAlign.center),
        const Gap(AppSizes.spaceBtwSections),

        showBadge
            ? LessonBadge(badgeType: badgeType, badgeVariant: badgeVariant)
            : SizedBox.shrink(),
      ],
    );
  }
}
