import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({super.key, required this.sectionName});

  final String sectionName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionName,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'DynaPuff_SemiCondensed',
          ),
        ),
      ],
    );
  }
}
