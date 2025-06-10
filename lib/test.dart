// curved_edges_bottom.dart - Custom clipper for bottom curved edges
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/assets_manager.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/sizes.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/badges/lesson_badge.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/container/curved_header_container.dart';
import 'package:le_petit_davinci/core/widgets/navigation_bar/App_bar.dart';
import 'package:le_petit_davinci/features/lessons/widget/lesson_info.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      body: SingleChildScrollView(
        primary: true,
        child: Column(
          children: [
            CustomCurvedHeaderContainer(
              child: Column(
                children: [
                  Gap(DeviceUtils.getAppBarHeight()),
                  const CustomAppBar(
                    chipText: 'Anglais',
                    chipColor: AppColors.accent,
                  ),
                  const Gap(AppSizes.spaceBtwSections),

                  const LessonInfo(
                    lessonName: 'Listen & Match',
                    lessonDescription:
                        'Associer un mot entendu à son image correspondante.',
                  ),
                  const Gap(AppSizes.spaceBtwSections),
                  const LessonBadge(
                    label: 'Maître des sons',
                    color: AppColors.accent,
                    svgIconPath: SvgAssets.micPurple,
                  ),
                ],
              ),
            ),
            Text('data'),
          ],
        ),
      ),
    );
  }
}
