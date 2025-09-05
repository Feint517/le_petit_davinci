// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/widgets/layouts/grid_layout.dart';
import 'package:le_petit_davinci/features/home/data/home_subject.dart';
import 'package:le_petit_davinci/features/home/widgets/section_heading.dart';
import 'subject_card.dart';

class SubjectSelection extends StatelessWidget {
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
            itemCount: subjects.length,
            spacing: 16.h,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return SubjectCard(subject: subject);
            },
          ),
        ],
      ),
    );
  }
}
