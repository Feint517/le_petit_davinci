// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/features/home/controllers/home_controller.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';
import 'subject_card.dart';

class SubjectSelection extends GetView<HomeController> {
  const SubjectSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //* Title
          const SectionHeading(sectionName: 'Sélection des matières'),
          Gap(16.h),

          //* Grid of subject cards
          CustomGridLayout(
            itemCount: 6,
            mainAxisExtent: 185.h,
            itemBuilder: (context, index) {
              final subject = controller.subjects[index];
              // return OpenContainer(
              //   transitionType: ContainerTransitionType.fadeThrough,
              //   openBuilder: ( context,  _) {
              //     switch (subject.name) {
              //       case 'Français':
              //         Get.put(FrenchMapController(), permanent: false);
              //         return const FrenchMapScreen();
              //       case 'Mathématiques':
              //         Get.put(MathMapController());
              //         return const MathematicMapScreen();
              //       case 'English':
              //         Get.put(EnglishMapController());
              //         return const EnglishMapScreen();
              //       case 'Vie quotidienne':
              //         return const VieQuotidienneScreen();
              //       case 'Jeux':
              //         return const GamesScreen();
              //       default:
              //         return const SizedBox.shrink();
              //     }
              //   },
              //   closedElevation: 0,
              //   closedShape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20.r),
              //   ),
              //   closedColor: subject.cardColor,
              //   openColor: subject.cardColor,
              //   transitionDuration: const Duration(milliseconds: 800),
              //   closedBuilder: (context, openContainer) {
              //     return SubjectCard(
              //       subject: subject,
              //     );
              //   },
              // );
              return SubjectCard(subject: subject);
            },
          ),
        ],
      ),
    );
  }
}
