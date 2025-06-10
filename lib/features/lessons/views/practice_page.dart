// curved_edges_bottom.dart - Custom clipper for bottom curved edges
import 'package:flutter/material.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';
import 'package:le_petit_davinci/core/constants/enums.dart';
import 'package:le_petit_davinci/core/utils/device_utils.dart';
import 'package:le_petit_davinci/core/widgets/custom_shapes/container/curved_header_container.dart';
import 'package:le_petit_davinci/features/lessons/widget/practice_content.dart';
import 'package:le_petit_davinci/features/lessons/widget/practice_header.dart';

class PracticePage extends StatelessWidget {
  const PracticePage({super.key, required this.type});

  final PracticeType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accent,
      body: SingleChildScrollView(
        primary: true,
        child: SizedBox(
          height: DeviceUtils.getScreenHeight(),
          //? we wrapped the stack with SizedBox because because in a scroll view, the Stack takes only the height of its children
          child: Stack(
            children: [
              CustomCurvedHeaderContainer(
                // child: Column(
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     Gap(DeviceUtils.getAppBarHeight()),
                //     const CustomAppBar(
                //       chipText: 'Anglais',
                //       chipColor: AppColors.accent,
                //     ),
                //     const Gap(AppSizes.spaceBtwSections),

                //     const LessonInfo(
                //       lessonName: 'Listen & Match',
                //       lessonDescription:
                //           'Associer un mot entendu à son image correspondante.',
                //     ),
                //     const Gap(AppSizes.spaceBtwSections),
                //     const LessonBadge(
                //       label: 'Maître des sons',
                //       color: AppColors.accent,
                //       svgIconPath: SvgAssets.micPurple,
                //     ),
                //   ],
                // ),
                child: PracticeHeader(type: type),
              ),
              Positioned(
                top: 400 - 80,
                right: 0,
                left: 0,
                child: PracticeContent(type: type),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
