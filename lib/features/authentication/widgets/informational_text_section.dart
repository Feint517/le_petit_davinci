import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:le_petit_davinci/core/constants/colors.dart';

class InformationalTextSection extends StatelessWidget {
  const InformationalTextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Je suis super content de te retrouver chaque jour pour apprendre et t\'amuser.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textPrimary,
            fontFamily: 'DynaPuff_SemiCondensed',
            fontWeight: FontWeight.w400,
          ),
        ),
        Gap(12.h),
        Text(
          'Aujourd\'hui, on commencera doucement avec les maths et un petit défi de lecture.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textPrimary,
            fontFamily: 'DynaPuff_SemiCondensed',
            fontWeight: FontWeight.w400,
          ),
        ),
        Gap(20.h),
        Text(
          'Tu es prêt ?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.sp,
            color: AppColors.orangeAccent,
            fontFamily: 'DynaPuff_SemiCondensed',
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
